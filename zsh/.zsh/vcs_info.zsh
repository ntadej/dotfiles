# Based on https://github.com/kdungs/dotfiles/blob/master/zshrc
# VCS info
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-st
zstyle ':vcs_info:*' formats "%{$fg[magenta]%}(%s) %{$fg_bold[cyan]%} %b%{$reset_color%} %c %u"
zstyle ':vcs_info:*' stagedstr "%{$fg[green]%}✔%{$reset_color%}"
zstyle ':vcs_info:*' unstagedstr "%{$fg[red]%}✘%{$reset_color%}"
zstyle ':vcs_info:*' actionformats "%s→%b (%c%u) %a"
# Hooks
function +vi-git-untracked() {
    # Show if untracked files are present in git
    local untracked

    untracked=${$(git ls-files --exclude-standard --others | head -n 1)}
    if [[ -n ${untracked} ]] ; then
        hook_com[unstaged]+=" %{$fg[yellow]%}✚%{$reset_color%}"
    fi
}
function +vi-git-st() {
    # Show difference between local and remote
    local ahead behind remote
    local -a gitstatus

    # Check for remote branch
    remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} --symbolic-full-name --abbrev-ref 2> /dev/null)}
    if [[ -n ${remote} ]] ; then
        ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2> /dev/null | wc -l)
        (( $ahead )) && gitstatus+=( " %{$fg[green]%}↑${ahead// /}%{$reset_color%}" )
        behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} | wc -l)
        (( $behind )) && gitstatus+=( "%{$fg[red]%}↓${behind// /}%{$reset_color%}" )
        hook_com[branch]+="%{$reset_color%} %{$fg[cyan]%}:: ${remote}${(j: :)gitstatus}%{$fg[cyan]%}"
    fi
}
