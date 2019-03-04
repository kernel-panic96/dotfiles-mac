#!/bin/bash
# Description : Provisioning script for my development environment
#               1. Installs brew if not present
#               2. Clones and distributes dotfiles
#               3. Installs brew packages/casks and python packages
#               4. Installs vim plugins and a patched iosevka font

SUCCESS=0
FAILURE=1

function brew_if_not_exists {
    local cmd="${@: -1}"
    local subcommand=$( [ "$1" == "cask" ] && echo "cask" || echo "")

    echo "[$0] Checking for brew package $(tput setaf 5)$cmd$(tput sgr0)..."

    if ! command -v $cmd > /dev/null; then
        if ! brew $subcommand list | grep -i '\b'$cmd'\b' > /dev/null; then
            echo "[$0] $(tput setaf 5)Installing $(tput sgr0)$cmd" 
            brew $@
            return $? # $? holds the status code of the last executed command
        fi
    fi
    return $FAILURE
}

function clone_if_dir_not_exists {
    local repo=$1
    local dir=$2

    if [ ! -d $dir ]; then
        echo "[$0] Installing base16-shell"
        git clone https://github.com/$repo.git $dir

        return $?
    else
        return $FAILURE # Did not install anything
    fi
}

if [ ! $(command -v brew) ]; then
	echo -n "[$0] Homebrew is necessary, continue with installing it? [Y/n]"
	read ANSWER || exit $FAILURE

	if [ "$ANSWER" == "y" ] || [ "$ANSWER" == "Y" ] || [ "$ANSWER" == "" ]; then
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"  || echo "something went wrong with the brew installation. aborting" && exit $FAILURE
	fi
fi

# ----- Symlink config files -----

if [ -d ~/dotfiles ]; then
    mkdir -p ~/.config/karabiner/json
    mkdir -p ~/.config/nvim

    ln -s .vimrc ~/.vimrc
    ln -s karabiner.json ~/.config/karabiner/karabiner.json
    ln -s .tmux.conf ~/.tmux.conf
    ln -s .chunkwmrc ~/.chunkwmrc
    ln -s .bash_profile ~/.bash_profile
    ln -s .skhdrc ~/.skhdrc
    ln -s .chunkwm_plugins ~/chunkwm_plugins
    ln -s init.vim ~/.config/nvim/init.vim
fi

#----- Package Installation -----

echo "[$0] $(tput setaf 5)Boostrapping software packages... $(tput sgr0)"

packages=(
    bash-git-prompt
    cmake             # Build system, required for 'YouCompleteMe' vim plugin
    glances           # Fancy system monitor
    go                # Golang programming language toolchain
    highlight         # Code highlighting tool
    htop              # Not so fancy but faster system monitor
    jq                # JSON highlighter
    neofetch          # Ascii art os logo + some system information, eye candy
    neovim            # My preffered text editor
    node              # Server side JavaScript
    python3           # Programming language interpreter
    httpie            # CLI http client
    ipython           # Alternative python shell
    ranger            # Terminal file browser
    tmux              # Terminal multiplexer
    tree              # Directory tree displayer
)

for pkg in "${packages[@]}"; do
    brew_if_not_exists install $pkg
done

brew tap koekeishiya/formulae

# Tiling window manager
if brew_if_not_exists install --HEAD chunkwm; then
    brew services start chunkwm
    cp /usr/local/opt/chunkwm/share/chunkwm/examples/chunkwmrc ~/.chunkwmrc
    ln -s /usr/local/opt/chunkwm/share/chunkwm/plugins ~/.chunkwm_plugins
    curl https://gist.githubusercontent.com/shihanng/65b73712df2e51d4d78cc27c218bac35/raw/470c8b8c2072b01f6866626802bc76e8ccaf5a80/.skhdrc > ~/.skhdrc
fi

brew_if_not_exists install --HEAD skhd && brew services start skhd       # Hotkey deamon for intercepting keyboard shortcuts
brew_if_not_exists cask install karabiner-elements                       # tool for remapping of keyboard keys
brew_if_not_exists cask install spotify
brew_if_not_exists cask install iterm2                                   # my preffered terminal emulator
brew_if_not_exists cask install google-chrome

# --- Repos
command -v git > /dev/null || (echo "[$0] $(tput setaf 2)Error$(tput sgr0): Could not find git, check the PATH evnironment variable if you have it installed, aborting." && exit $FAILURE)

clone_if_dir_not_exists chriskempson/base16-shell   ~/.config/base16-shell
clone_if_dir_not_exists VundleVim/Vundle.vim        ~/.vim/bundle/Vundle.vim

# ----- Install vim plugins -----

# --- YouCompleteMe

if [ -d ~/.vim/bundle/YouCompleteMe ] && [ ! -f ~/.vim/bundle/YouCompleteMe/.ycm_installed ]; then
    echo "[$0] $(tput setaf 5)Installing $(tput sgr0)vim plugins based on ~/.vimrc with Vundle"
    vim +PluginInstall +GoInstallBinaries +qall

    echo "[$0] $(tput setaf 5) Building $(tput sgr0)YouCompleteMe vim plugin"
    cd ~/.vim/bundle/YouCompleteMe
    ./install.py --go-completer && touch .ycm_installed
fi

# --- vim-instant-markdown

if ! npm list -g | grep -i instant-markdown-d; then
    npm -g install instant-markdown-d
    mkdir -p ~/.vim/after/ftplugin/markdown
    curl https://raw.githubusercontent.com/suan/vim-instant-markdown/master/after/ftplugin/markdown/instant-markdown.vim > $_/instant_markdown.vim
fi


# ----- Patched font Installation -----

if [ ! -f "$HOME/Library/Fonts/Iosevka Nerd Font Complete Mono.ttf" ]; then
    echo "[$0] $(tput setaf 5)Downloading $(tput sgr0)'Iosevka Nerd Font Complete Mono' patched font"
    curl https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Iosevka/Regular/complete/Iosevka\ Nerd\ Font\ Complete\ Mono.ttf > "$HOME/Library/Fonts/Iosevka Nerd Font Complete Mono.ttf"
    curl https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Iosevka/Regular/complete/Iosevka\ Term\ Nerd\ Font\ Complete\ Mono.ttf > "$HOME/Library/Fonts/Iosevka Term Nerd Font Complete Mono.ttf"
fi
