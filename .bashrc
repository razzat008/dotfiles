### EXPORT
. ~/.bash_profile
export TERM="xterm-256color"                      # getting proper colors
export DISPLAY=:1
export EDITOR="vim"
export HISTCONTROL=ignoredups:erasedups:ignorespace           # no duplicate entries

#colorscript -e illumina

## CHANGE TITLE OF TERMINALS
case ${TERM} in
  xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|alacritty|st|konsole*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
        ;;
  screen*)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
    ;;
esac


shopt -s autocd # autocd when entering just a path
#shopt -s checkwinsize

up () {
  local d=""
  local limit="$1"

  # Default to limit of 1
  if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
    limit=1
  fi

  for ((i=1;i<=limit;i++)); do
    d="../$d"
  done

  # perform cd. Show error if cd fails
  if ! cd "$d"; then
    echo "Couldn't go up $limit dirs.";
  fi
}


#bash insulter
if [ -f /etc/bash.command-not-found ]; then
        . /etc/bash.command-not-found
fi


# aliases
#git
alias addup='git add -u '
alias addall='git add . '
alias branch='git branch '
alias checkout='git checkout '
alias delbra='git branch -D '
alias clone='git clone '
#alias commit='git commit -m '
alias fetch='git fetch '
alias pull='git pull origin '
alias push='git push origin '
alias stat='git status '  # 'status' is protected name so using 'stat' instead
alias ls="ls --color=auto"
alias la="ls -a --color=auto"
alias v="vim"
alias n="nvim"
# alias termlog="loginctl terminate user ceaser"
alias ls="ls --color=auto"
# alias hiber_="systemctl hibernate"
alias cls="clear"
alias checkint="ping archlinux.org -c3"
alias pacup="sudo pacman -Syu"


alias "anser"="adb shell pm list packages| grep " #to search for apps through adb/pm
alias "andel"="adb shell pm uninstall -k --user 0 " #to remove apps through adb

alias fm=ranger #ranger
alias lg=lazygit #for lazygit

#bluetooth
alias aircon="bluetoothctl connect 25:A0:0B:9F:C0:13"
alias aircond="bluetoothctl disconnect 25:A0:0B:9F:C0:13"

#for autocompletion based on autocompletion
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# control panel

#for prompt
