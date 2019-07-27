shopt -s histappend
# When the shell exits, append to the history file instead of overwriting it
export PATH=/usr/local/opt/postgresql@9.4/bin/:/~/.aw/pex_resources/scripts/binaries:~/.rbenv/shims:~/.nvm/v0.10.32/bin:~/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/munki:/opt/X11/bin:~/gocode/bin
# After each command, append to the history file and reread it
export HISTTIMEFORMAT="%c "
export HISTCONTROL=ignoredups:erasedups  
export HISTSIZE=1000000                   # big big history
export HISTFILESIZE=1000000               # big big history

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

if [ $(which direnv) ] ; then eval "$(direnv hook bash)"; fi

alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"
fshow_preview() {
    glNoGraph |
        fzf --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview="$_viewGitLogLine" \
                --header "enter to view, alt-y to copy hash" \
                --bind "enter:execute:$_viewGitLogLine   | less -R" \
                --bind "alt-y:execute:$_gitLogLineToHash | xclip"
}

if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
    GIT_PROMPT_ONLY_IN_REPO=0
    GIT_PROMPT_LEADING_SPACE=0
    GIT_PROMPT_THEME=Single_line_Minimalist
    source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

#     
if [ ! -z "$TMUX" ]; then
    glyph="\[$(tput setaf 110)\] \[$(tput sgr0)\]"
    # glyph=" "
else
    glyph="\[$(tput setaf 2)\]i \[$(tput sgr0)\]"
    # glyph=" "
fi
glyph=""

function color {
    echo \[$(tput setaf $1)\] \[$(tput sgr0)\]
}

# function get_glyph {
#     if [ $(we_are_on_repo) -eq 0 ]; then
#         echo $glyph
#     fi
# }

if [ "$EUID" -ne 0 ]; then # non root shell
    export PS1="  : \[$(tput setaf 3)\]\u\[$(tput setaf 5)\]@\[$(tput setaf 5)\]\`${SELECT}\`\W\[$(tput sgr0)\] "
else
    export PS1=" \[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]ROOT\[$(tput setaf 2)\]@\[$(tput setaf 4)\]$(hostname | awk '{print toupper($0)}') \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]🛸 \[$(tput sgr0)\]"
fi

#Generic shortcuts:
alias files="ranger"
alias calender="calcurse"
alias cdlast=$'cd $(ls -lt | grep \'^d\' | head -1 | awk \'{print $NF}\')'
alias mvlastd='mv "$HOME/Downloads/$(ls -tr ~/Downloads | tail -n 1)" .'
alias pcp='fd . --type f --extension .gpg ~/.password-store/  --exec-batch python -c "import sys, os; print(os.linesep.join([x.replace(r\"$HOME/.password-store/\", \"\", 1) for x in sys.argv[1:]])) " {.} | fzf --prompt "pass > " --height=1 --border --color=fg:7,gutter:0,pointer:0,bg+:7 | xargs pass -c'
alias jpaste='pbpaste | jq'

# System Maintainence
alias progs="pacman -Qet" # List programs I've installed
alias orphans="pacman -Qdt" # List orphan programs
alias upgr="neofetch && sudo pacman -Syyu --noconfirm && echo Update complete. | figlet"
alias sdn="sudo shutdown now"
alias nf="clear && neofetch" # Le Redditfetch

# Some aliases
alias cls="clear"
alias v="nvim"
alias vim="nvim"
alias sv="sudo vim"
alias r="ranger"
alias sr="sudo ranger"
alias ka="killall"
alias g="git"
alias gs="git status --short"
alias gd="git diff"
alias ga="git add"
alias gb="git branch"
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
#alias bpy="bpython -q"
alias ipy="ipython --TerminalInteractiveShell.editing_mode=vi --no-banner"
#alias py="python3 -q"
#alias python="python3 -q"
alias venv="source venv/bin/activate"
alias gdb="gdb -q"
alias sqlite='sqlite3'
alias git-show-files='git diff-tree --no-commit-id --name-only -r'
alias html_preview='vim -c "set syntax=html"'
alias killdjango='kill -9 $(pgrep -f "manage.py runserver")'
alias dockup='docker-compose up'
alias mvlastd="ls -t ~/Downloads/ | head -1 | xargs -I '%' mv ~/Downloads/'%'"

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
alias l='ls'
alias la='ls -a'
alias grep="grep --color=always" # Color grep - highlight desired sequence.
alias ccat="highlight --out-format=xterm256" #Color cat - print file with syntax highlighting.
alias base16_enable="source ~/.scripts/enable_base16"
# alias nvm="source ~/.local/bin/nvm/nvm"

# Internet
alias YT="youtube-viewer"
alias ethspeed="speedometer -r enp2s0"
alias wifispeed="speedometer -r wlp3s0"
alias publicip='curl -s checkip.dyndns.org | sed -e "s/.*Current IP Address: //" -e "s/<.*$//"'

#clipboard
alias ccopy="pbcopy"
alias ppaste="pbpaste"

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
    BASE16_SHELL="$HOME/.config/base16-shell/"
    [ -n "$PS1" ] && \
            [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
                    eval "$("$BASE16_SHELL/profile_helper.sh")"
fi

set -o vi

alias lint='arc lint'
alias t='fab test'

test -f ~/.bashrc && source ~/.bashrc
test -f /usr/local/etc/autojump.sh && source $_
test -f /usr/local/etc/bash_completion.d/git-completion.bash
test -f /usr/local/opt/gnu-getopt/etc/bash_completion.d && source /usr/local/opt/gnu-getopt/etc/bash_completion.d
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion || {
    # if not found in /usr/local/etc, try the brew --prefix location
    [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ] && \
        . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
}

source /usr/local/opt/fzf/shell/completion.bash
source /usr/local/opt/fzf/shell/key-bindings.bash

fzf_then_open_in_editor() {
  local file=$(fzf)
  # Open the file if it exists
  if [ -n "$file" ]; then
    # Use the default editor if it's defined, otherwise Vim
    ${EDITOR:-nvim} "$file"
  fi
}
export EDITOR=nvim

export GOPATH=$HOME/work/go/
export GOROOT=~/.go/gimme/versions/go1.12.6.darwin.amd64
export PATH=$PATH:~/local/bin:~/Library/Python/3.7/bin
export PATH=$GOROOT/bin:$GOPATH/bin:$PATH
export PATH="$HOME/Library/Haskell/bin:$PATH"
export PATH=$PATH:~/scripts
export PATH=$PATH:~/.cargo/bin
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

echo "
#/bin/env bash

export PATH=$PATH
export GOROOT=$GOROOT
export GOPATH=$GOPATH

go list ... > /tmp/go-package-index-tmp
mv /tmp/go-package-index-tmp /tmp/go-package-index
" > ~/scripts/goindex.sh
chmod +x ~/scripts/goindex.sh

if which pyenv > /dev/null ; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
fi

[ -r ~/.profile_lda ] && . ~/.profile_lda
export GPG_TTY=$(tty)

fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

bind '"\C-v": "fzf_then_open_in_editor\n"'
bind '"\C-p":"pcp\n"'

[ -r ~/.bashrc ] && . ~/.bashrc
