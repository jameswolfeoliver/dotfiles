#!/usr/bin/env bash
########################################################################################################################
## Installing dependancies #############################################################################################
########################################################################################################################

maybeAptInstall() { # $1 name of apt resource
    echo "Installing $1..."
    silentTest="$1 --version 2>&1 >/dev/null"
    eval $silentTest
    RES_IS_AVAILABLE=$?

    if [ $RES_IS_AVAILABLE -eq 0 ]; then 
        echo "\t$1 -- passed"
    else 
        echo "\t$1 -- failed"
        sudo apt-get install $1
    fi

    echo "$1 install completed\n"
}

echo "Please input password so we can install dependancies. 
Feel free to look over the script to make sure no funny business is going down."

sudo echo "\nWelcome to James' dotfiles installer!\n"

# install dependancies {
    dependancies=('git' 'zsh' 'curl' 'vim')
    echo "Installing dependancies [${dependancies[@]}]"

    for i in "${dependancies[@]}"; do
        maybeAptInstall $i
    done
# }

########################################################################################################################
## Installing dot files ################################################################################################
########################################################################################################################

onStartInstall() { # $1 is name of resource
    echo "[Installing $1] Status: Started"
}

onFailInstall() { # $1 is name of resource
    echo "[Installing $1] Status: Failed"
}

onFinishInstall() { # $1 is name of resource
    echo "[Installing $1] Status: Finished"
}

maybeBackupConfig() { # $1 is the file path
    if [ -f $1 ]; then
        mv $1 ~/.backup_configs/ 
    fi
}

mkdir ~/.backup_configs >/dev/null

# setup oh-my-zsh {
    onStartInstall oh-my-zsh
    chsh -s $(which zsh)
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    maybeBackupConfig ~/.zshrc
    curl -fsSL https://raw.githubusercontent.com/jameswolfeoliver/dotfiles/master/zsh/.zshrc > ~/.zshrc

    onFinishInstall oh-my-zsh
# }