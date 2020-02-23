# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# shellcheck disable=SC1090
source ~/.zsh/checks.sh
source ~/.zsh/colors.sh
source ~/.zsh/setopt.sh
source ~/.zsh/history.sh
source ~/.zsh/exports.sh
source ~/.zsh/functions.sh
source ~/.zsh/completion.sh
source ~/.zsh/aliases.sh

source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh/prompt.sh

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source ~/.zsh/iterm2_shell_integration.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.zsh/p10k.zsh ]] || source ~/.zsh/p10k.zsh
