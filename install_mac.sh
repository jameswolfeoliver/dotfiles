#!/usr/bin/env bash
########################################################################################################################
## Installing dependancies #############################################################################################
########################################################################################################################

maybeBrewInstall() { # $1 name of apt resource
    echo "Installing $1..."
    silentTest="$1 --version 2>&1 >/dev/null"
    eval $silentTest
    RES_IS_AVAILABLE=$?

    if [ $RES_IS_AVAILABLE -eq 0 ]; then 
        echo "  $1 -- passed"
    else 
        echo "  $1 -- failed"
        brew install $1
    fi

    echo "$1 install completed"
    echo ""
}

onStartInstall() { # $1 is name of resource
    echo "[Installing $1] Status: Started"
    echo ""
}

onFailInstall() { # $1 is name of resource
    echo "[Installing $1] Status: Failed"
    echo ""
}

onFinishInstall() { # $1 is name of resource
    echo "[Installing $1] Status: Finished"
    echo ""
}

maybeBackupConfig() { # $1 is the file path
    if [ -f $1 ]; then
        mv $1 ~/.backup_configs/ 
    fi
}

echo "Please input password so we can install dependancies. 
Feel free to look over the script to make sure no funny business is going down."

echo ""
sudo echo "Welcome to James' dotfiles installer!"
echo ""

# assert xcode {
    onStartInstall xcode
    xcode-select --version 2>&1 >/dev/null
    XCODE_IS_AVAILABLE=$?

    if [ $XCODE_IS_AVAILABLE -eq 0 ]; then 
        echo "  xcode -- passed"
    else 
        echo "  xcode -- failed"
        echo "Please use xcode-select --install to install Command Line Tools (CLT) for Xcode and try again"
        onFailInstall xcode
        exit
    fi
    onFinishInstall xcode
# }

# assert homebrew {
    onStartInstall brew
    brew --version 2>&1 >/dev/null
    BREW_IS_AVAILABLE=$?

    if [ $BREW_IS_AVAILABLE -eq 0 ]; then 
        echo "  brew -- passed"
    else 
        echo "  brew -- failed"
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    onFinishInstall brew
# }

# install dependancies {
    dependancies=('git' 'zsh' 'curl' 'vim')
    echo "Installing dependancies [${dependancies[@]}]"

    for i in "${dependancies[@]}"; do
        maybeBrewInstall $i
    done
# }

########################################################################################################################
## Installing dot files ################################################################################################
########################################################################################################################

mkdir ~/.backup_configs >/dev/null

# setup oh-my-zsh {
    onStartInstall oh-my-zsh
    chsh -s $(which zsh)

    echo ""
    echo "Type 'exit' if/when zsh launches. This is a silly workaround to allow the script to resume."
    echo ""
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    maybeBackupConfig ~/.zshrc
    curl -fsSL https://raw.githubusercontent.com/jameswolfeoliver/dotfiles/master/zsh/.zshrc > ~/.zshrc

    onFinishInstall oh-my-zsh
# }


# setup powerlevel9k {
    onStartInstall powerlevel9k
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

    curl -fsSL https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf > ./PowerlineSymbols.otf
    curl -fsSL https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf > ./10-powerline-symbols.conf

    mkdir -p ~/.local/share/fonts/ >/dev/null
    mv PowerlineSymbols.otf ~/.local/share/fonts/
    fc-cache -vf ~/.local/share/fonts/ >/dev/null

    mkdir -p ~/.config/fontconfig/conf.d/ >/dev/null
    mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
    onFinishInstall powerlevel9k
# }


# setup git {
    onStartInstall git

    maybeBackupConfig ~/.gitconfig
    curl -fsSL https://raw.githubusercontent.com/jameswolfeoliver/dotfiles/master/git/.gitconfig > ~/.gitconfig

    onFinishInstall git
# }

# setup vim {
    onStartInstall vim

    maybeBackupConfig ~/.vimrc
    curl -fsSL https://raw.githubusercontent.com/jameswolfeoliver/dotfiles/master/vim/.vimrc > ~/.vimrc
    vim +PlugInstall +qall 

    onFinishInstall vim
# }


echo ""
echo "James' dotfiles installer has completed! Log out and back in again for changes to take effect"
echo "You can find backups of your dotfiles in ~/.backup_configs/"
echo "Enjoy!"