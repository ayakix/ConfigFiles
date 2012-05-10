###############################################
# 環境変数                                    #
###############################################
# MacPorts
export PATH=$PATH:/Applications/android-sdk-mac_x86/tools:/Applications/android-sdk-mac_x86/platform-tools
export PATH=/opt/local/bin:/opt/local/sbin/:$PATH
export MANPATH=/opt/local/man:$MANPATH

alias gae_server='python2.5 /usr/local/bin/dev_appserver.py'
alias gae_deploy='python2.5 /usr/local/bin/appcfg.py update'

# AUTOCOMP
autoload -U compinit
compinit
setopt auto_cd
setopt auto_pushd
setopt correct

# LANG
export LANG=ja_JP.UTF-8

# PROMPT
case ${UID} in
0)
    PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') %{${fg[red]}%}%n@%m%#%{${reset_color}%} "
    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
    RPROMPT="%{${fg[green]}%}[%~:%T]%{${reset_color}%}"
    ;;
*)
    PROMPT="%{${fg[red]}%}%n@%m%%%{${reset_color}%} "
    PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
    SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
    RPROMPT="%{${fg[green]}%}[%~:%T]%{${reset_color}%}"
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
esac

# TITLE
case "${TERM}" in
kterm*|xterm*|terminal*)
 precmd() {
  echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
 }
 ;;
esac

# HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history

# mkcd
function mkcd() {
  if [[ -d $1 ]]; then
    echo "It already exsits! Cd to the directory."
    cd $1
  else
    mkdir -p $1 && cd $1
  fi
}
