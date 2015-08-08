############
## PROMPT ## 
############

autoload -U compinit promptinit 
compinit
promptinit

autoload -U colors && colors

PROMPT="%{$fg[green]%}[%n@%m %1~]$%{$reset_color%} "
RPROMPT=""

##############
## DIRSTACK ##
##############

## dirstack, for cd -1, etc
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

DIRSTACKSIZE=40

setopt autopushd pushdsilent pushdtohome

## Remove duplicate entries
setopt pushdignoredups

## This reverts the +/- operators.
setopt pushdminus

#############
## HISTORY ##
#############

HISTFILE=$HOME/.zhistory
setopt APPEND_HISTORY
HISTSIZE=500
SAVEHIST=400
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY

##########
## MISC ##
##########

## enable zmv
autoload -U zmv

## no need to use 'cd' to change dirs
setopt autocd
## autocomplete searches all $PATH
setopt extendedglob

# history expansion on space!
bindkey " " magic-space

chpwd() { print -Pn "\e]0;%m: %~\a" };

#############
## ALIASES ##
#############

## utilities
alias lsm='du -sk *xml | sort +0n' 
alias ls='ls -A --color=auto'
alias ll='ll -lA --color=auto'
alias l='less'
alias cd..='cd ..'
alias psme='ps -u $USER -f'

## globals
alias -g tdn='> /dev/null'
alias -g bell='&& tput bel'

## suffixes
alias -s txt=vim
alias -s htm=vim
alias -s html=vim

## default completions
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

