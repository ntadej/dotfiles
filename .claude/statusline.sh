#!/bin/bash
# Claude Code status line in the style of ~/.p10k.zsh (rainbow, slanted separators, Nerd Font icons):
#   os · user@host · repo · git state   then   model · context used · plan usage limits (session cost when there are none).
# Claude Code pipes session JSON on stdin; fields: https://code.claude.com/docs/en/statusline#available-data
# Written for macOS /bin/bash 3.2, so glyphs are spelled as UTF-8 bytes rather than \u escapes.

IFS='|' read -r model ctx five five_reset week cost dir repo host < <(jq -r '[
  .model.display_name // "?",
  .context_window.used_percentage // "",
  .rate_limits.five_hour.used_percentage // "",
  .rate_limits.five_hour.resets_at // "",
  .rate_limits.seven_day.used_percentage // "",
  .cost.total_cost_usd // 0,
  .workspace.current_dir // .cwd // "",
  .workspace.repo.name // "",
  .workspace.repo.host // ""
] | map(tostring) | join("|")')

esc=$'\033' reset=$'\033[0m' bold=$'\033[1m' nobold=$'\033[22m'
head=$'\xee\x82\xba' sep=$'\xee\x82\xbc' sub=$'\xe2\x95\xb1' # U+E0BA , U+E0BC , U+2571 ╱
apple=$'\xef\x85\xb9' folder=$'\xef\x81\xbc' branch_icon=$'\xef\x84\xa6 ' # U+F179 , U+F07C , U+F126
case $host in
  *gitlab*) git_icon=$'\xef\x8a\x96' ;; # U+F296
  *github*) git_icon=$'\xef\x84\x93' ;; # U+F113
  *) git_icon=$'\xef\x87\x93' ;;        # U+F1D3
esac

# Segments as parallel arrays: background, foreground, text (text may switch foreground but never resets).
bgs=() fgs=() txts=()
seg() { bgs+=("$1"); fgs+=("$2"); txts+=("$3"); }

# Append the collected segments to $line as one chain with slanted ends, as p10k draws a prompt side, then clear them.
# Neighbours with the same background are split by ╱ (p10k's subsegment separator).
line=''
chain() {
  local i n=${#bgs[@]}
  ((n)) || return
  line+="${esc}[38;5;${bgs[0]}m$head"
  for ((i = 0; i < n; i++)); do
    line+="${esc}[48;5;${bgs[i]}m${esc}[38;5;${fgs[i]}m ${txts[i]} "
    if ((i + 1 == n)); then
      line+="$reset${esc}[38;5;${bgs[i]}m$sep$reset"
    elif [[ ${bgs[i + 1]} == "${bgs[i]}" ]]; then
      line+="${esc}[38;5;${fgs[i]}m$sub"
    else
      line+="${esc}[48;5;${bgs[i + 1]}m${esc}[38;5;${bgs[i]}m$sep"
    fi
  done
  bgs=() fgs=() txts=()
}

# Percentage segment, coloured like p10k states: green below 50, yellow below 80, red (status-error colours) from 80.
pct() {
  local p
  p=$(printf '%.0f' "$2")
  if ((p >= 80)); then seg 1 3 "$1 $p%$3"; elif ((p >= 50)); then seg 3 0 "$1 $p%$3"; else seg 2 0 "$1 $p%$3"; fi
}

# Git state as p10k's my_git_formatter shows it: branch (@commit when detached) ⇣behind ⇡ahead *stashes
# ~conflicted +staged !unstaged ?untracked. Prints the background (yellow when modified or conflicted, else green)
# and the text. One porcelain-v2 call gives all of it; --no-optional-locks keeps it from blocking other git commands.
vcs() {
  git -C "$dir" --no-optional-locks status --porcelain=v2 --branch --show-stash 2>/dev/null | awk \
    -v black="${esc}[38;5;0m" -v white="${esc}[38;5;7m" -v red="${esc}[38;5;1m" -v icon="$git_icon" -v branch_icon="$branch_icon" '
    $2 == "branch.oid"     { oid = substr($3, 1, 8) }
    $2 == "branch.head"    { head = $3 }
    $2 == "branch.ab"      { ahead = substr($3, 2) + 0; behind = substr($4, 2) + 0 }
    $2 == "stash"          { stashes = $3 + 0 }
    $1 == "1" || $1 == "2" { if (substr($2, 1, 1) != ".") staged++; if (substr($2, 2, 1) != ".") unstaged++ }
    $1 == "u"              { conflicts++ }
    $1 == "?"              { new++ }
    END {
      if (head == "") exit 1
      out = icon " " (head == "(detached)" ? white "@" black oid : branch_icon black head)
      if (behind)    out = out " " black "⇣" behind
      if (ahead)     out = out (behind ? "" : " ") black "⇡" ahead
      if (stashes)   out = out " " black "*" stashes
      if (conflicts) out = out " " red "~" conflicts
      if (staged)    out = out " " black "+" staged
      if (unstaged)  out = out " " black "!" unstaged
      if (new)       out = out " " black "?" new
      print ((staged || unstaged || conflicts) ? 3 : 2), out
    }'
}

# Left side: os, user@host, repo (name from the origin remote, else the folder), git state
seg 7 232 "$apple"
seg 6 0 "${USER:-$(id -un)}@$(hostname -s)"
where=${repo:-${dir##*/}}
[[ -n $where ]] && seg 4 255 "$folder $bold$where$nobold"
read -r vcs_bg vcs_text < <(vcs) && seg "$vcs_bg" 0 "$vcs_text"
chain
left=$line line=''

# Right side: model, context, plan limits or session cost
seg 7 0 "$model"
[[ -n $ctx ]] && pct ctx "$ctx"
if [[ -n $five || -n $week ]]; then
  [[ -n $five ]] && pct 5h "$five" "${five_reset:+ ↻$(date -r "$five_reset" +%H:%M)}"
  [[ -n $week ]] && pct 7d "$week"
elif [[ $cost != 0 ]]; then
  seg 7 0 "$(printf '$%.2f' "$cost")"
fi
chain
right=$line

# Push the right side to the terminal's right edge, like p10k's right prompt. Claude Code passes the terminal width
# in COLUMNS; MARGIN leaves room for the padding Claude Code adds around the status line (raise it if the line wraps).
# When the two sides don't fit, they stay one space apart.
width() { printf '%s' "$1" | LC_ALL=C sed $'s/\x1b\\[[0-9;]*m//g' | LC_ALL=en_US.UTF-8 wc -m; }
gap=$((${COLUMNS:-0} - ${STATUSLINE_MARGIN:-4} - $(width "$left") - $(width "$right")))
((gap < 1)) && gap=1
printf '%s%*s%s\n' "$left" "$gap" '' "$right"
