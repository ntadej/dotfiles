export LANG=en_US.UTF-8
export LC_COLLATE=C
export LC_TIME=sl_SI.UTF-8
export LC_MONETARY=sl_SI.UTF-8
export LC_PAPER=sl_SI.UTF-8
export LC_MEASUREMENT=sl_SI.UTF-8
export LC_ADDRESS=sl_SI.UTF-8
export LC_MESSAGES=C

if [[ $ZSH_VERSION = "5.0.2" ]] && [[ -f "$HOME/.local/bin/zsh" ]]; then
  export CUSTOM_ZSH_VERSION=1
  $HOME/.local/bin/zsh -l
  exit
fi
