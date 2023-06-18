[[ -d $HOME/bin ]] && export PATH="$PATH:$HOME/bin"
[[ -f $ZDOTDIR/aliases.zsh ]] && source $ZDOTDIR/aliases.zsh
[[ -f $ZDOTDIR/aliases_local.zsh ]] && source $ZDOTDIR/aliases_local.zsh
[[ -f $ZDOTDIR/bindings.zsh ]] && source $ZDOTDIR/bindings.zsh

zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins.zsh

[[ -f ${zsh_plugins:r}.txt ]] || touch ${zsh_plugins:r}.txt

fpath+=(${ZDOTDIR:-~}/.antidote)
autoload -Uz $fpath[-1]/antidote

if [[ ! $zsh_plugins -nt ${zsh_plugins:r}.txt ]]; then
  (antidote bundle <${zsh_plugins:r}.txt >|$zsh_plugins)
fi

source $zsh_plugins

# Completion config
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
  '+l:|?=** r:|?=**'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

autoload -U colors && colors

PS1="%~ %{$fg[magenta]%}❯ "
