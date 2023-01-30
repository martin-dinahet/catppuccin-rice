if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

source "$HOME/.cargo/env"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

alias c="clear"
alias v="clear && nvim"
alias e="clear && exit"
alias l="clear && lsd -l"
alias t="clear && lsd --tree"
alias r="clear && ranger"
alias g="clear && git"
alias p="clear && python3"
alias d="clear && deno"

alias cd="clear && cd"
alias la="clear && lsd -la"
alias mk="clear && mkdir -p"
alias sk="clear && sudo mkdir -p"
alias cp="clear && cp -r"
alias sp="clear && sudo cp -r"
alias mv="clear && mv"
alias sv="clear && sudo mv"
alias rm="clear && rm -r"
alias sr="clear && sudo rm -r"

alias uwu="clear && ani-cli"

alias wifi-on="clear && rfkill unblock wlan"
alias wifi-off="clear && rfkill block wlan"
alias bluetooth-on="clear && rfkill unblock bluetooth"
alias bluetooth-off="clear && rfkill block bluetooth"
alias bright="clear && brightnessctl s"

alias stopx="clear && killall i3"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
