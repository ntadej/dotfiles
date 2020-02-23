# shellcheck disable=SC1090
source ~/.zsh/checks.sh
source ~/.zsh/colors.sh
source ~/.zsh/setopt.sh
source ~/.zsh/history.sh
source ~/.zsh/exports.sh
source ~/.zsh/functions.sh
source ~/.zsh/completion.sh
source ~/.zsh/aliases.sh

eval "$(starship init zsh)"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source ~/.zsh/iterm2_shell_integration.sh
