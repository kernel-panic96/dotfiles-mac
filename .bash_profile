stty -ixon
set -o vi
 
#           ﮏ  ﲵ     ﮚ    ﴣ   ﱗ ﴨ ﳑ  ﮊ 履 ﲅ ﱇ ♥     
if [ "$EUID" -ne 0 ]; then # non root shell
    export PS1=" \[$(tput setaf 2)\]\[$(tput sgr0)\] : \[$(tput setaf 3)\]\u\[$(tput setaf 5)\]@\[$(tput setaf 5)\]\`${SELECT}\`\W\[$(tput sgr0)\] \[$(tput sgr0)\]"
else
    export PS1=" \[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]ROOT\[$(tput setaf 2)\]@\[$(tput setaf 4)\]$(hostname | awk '{print toupper($0)}') \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]🛸 \[$(tput sgr0)\]"
fi

#Generic shortcuts:
alias files="ranger"
alias calender="calcurse"
alias cdlast=$'cd $(ls -lt | grep \'^d\' | head -1 | awk \'{print $NF}\')'
alias mvlastd='mv "$HOME/Downloads/$(ls -tr ~/Downloads | tail -n 1)" .'

# System Maintainence
alias progs="pacman -Qet" # List programs I've installed
alias orphans="pacman -Qdt" # List orphan programs
alias upgr="neofetch && sudo pacman -Syyu --noconfirm && echo Update complete. | figlet"
alias sdn="sudo shutdown now"
alias nf="clear && neofetch" # Le Redditfetch

# Some aliases
alias v="nvim"
alias vim="nvim"
alias sv="sudo vim"
alias r="ranger"
alias sr="sudo ranger"
alias ka="killall"
alias g="git"
alias gitup="git push origin master"
alias mkd="mkdir -pv"
alias rf="source ~/.bash_profile"
alias ref="shortcuts.sh && source ~/.bashrc" # Refresh shortcuts manually and reload bashrc
alias bars="bash ~/.config/polybar/launch.sh" # Run Polybar relaunch script
alias bw="wal -i ~/.config/wall.png" # Rerun pywal
alias info="info_vim"
alias copypwd="pwd | xclip -sel clipboard"
alias cdp='cd $(ppaste)'
weath() { curl wttr.in/$1 ;} # Check the weather (give city or leave blank).

# Dev stuff
alias bpy="bpython -q"
alias ipy="ipython --TerminalInteractiveShell.editing_mode=vi"
alias py="python3 -q"
alias python="python3 -q"
alias venv="source venv/bin/activate"
alias gdb="gdb -q"
alias sqlite='sqlite3'
alias git-show-files='git diff-tree --no-commit-id --name-only -r'
alias html_preview='vim -c "set syntax=html"'
alias killdjango='kill -9 $(pgrep -f "manage.py runserver")'

## Django
alias pmr='python manage.py runserver'
alias pmmm='python manage.py makemigrations'
alias pmm='python manage.py migrate'
alias pmsql='python manage.py sqlmigrate'
alias pms='python manage.py shell'
alias pmt='python manage.py test'

# Adding color
alias ls='ls -hGF'
alias ll='ls -hlFG'
alias grep="grep --color=always" # Color grep - highlight desired sequence.
alias ccat="highlight --out-format=xterm256" #Color cat - print file with syntax highlighting.
alias base16_enable="source ~/.scripts/enable_base16"
alias nvm="source ~/.local/bin/nvm/nvm"

# Internet
alias YT="youtube-viewer"
alias ethspeed="speedometer -r enp2s0"
alias wifispeed="speedometer -r wlp3s0"
alias publicip='curl -s checkip.dyndns.org | sed -e "s/.*Current IP Address: //" -e "s/<.*$//"'

#clipboard
alias ccopy="xclip -sel clipboard"
alias ppaste="xclip -sel clipboard -out"

# Audio and Music
alias mute="osascript -e 'set volume output muted true'"
alias unmute="osascript -e 'set volume output muted false'"
alias pause="mpc toggle"
alias next="mpc next"
alias prev="mpc prev"
alias trupause="mpc pause"
alias beg="mpc seek 0%"
alias lilbak="mpc seek -10"
alias lilfor="mpc seek +10"
alias bigbak="mpc seek -120"
alias bigfor="mpc seek +120"

test -f ~/.bash_shortcuts && source ~/.bash_shortcuts

if [ -f ~/.config/base16-shell ]; then
    BASE16_SHELL=$HOME/.config/base16-shell/
fi

if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
    GIT_PROMPT_ONLY_IN_REPO=1
    GIT_PROMPT_THEME=Single_line_Minimalist
    source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
        [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
                eval "$("$BASE16_SHELL/profile_helper.sh")"

export GOPATH=$HOME/workspace/go
export PATH=$PATH:~/local/bin:~/Library/Python/3.7/bin
