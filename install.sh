git --version 2>&1 >/dev/null
GIT_IS_AVAILABLE=$?

if [ $GIT_IS_AVAILABLE -eq 0 ]; then 
    echo "GIT -- passed"
else 
    echo "GIT -- failed"
    echo "\tCannot continue wihtout GIT. Please install GIT and try again"
    exit
fi

zsh --version 2>&1 >/dev/null
ZSH_IS_AVAILABLE=$?

if [ $ZSH_IS_AVAILABLE -eq 0 ]; then 
    echo "ZSH -- passed"
else 
    echo "ZSH -- failed"
    echo "\tCannot continue wihtout ZSH. Please install ZSH and try again"
    exit
fi

vim --version 2>&1 >/dev/null
VIM_IS_AVAILABLE=$?

if [ $VIM_IS_AVAILABLE -eq 0 ]; then 
    echo "VIM -- passed"
else 
    echo "VIM -- failed"
    echo "\tCannot continue wihtout VIM. Please install VIM and try again"
    exit
fi

curl --version 2>&1 >/dev/null
CURL_IS_AVAILABLE=$?

if [ $CURL_IS_AVAILABLE -eq 0 ]; then 
    echo "CURL -- passed"
else 
    echo "CURL -- failed"
    echo "\tCannot continue wihtout CURL. Please install CURL and try again"
    exit
fi

echo "Installing oh my zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Installing powerlevel9k"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

echo "Installing powerlevel9k fonts"
curl https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf > ~/.local/share/fonts/
fc-cache -vf ~/.local/share/fonts/
curl https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf > ~/.config/fontconfig/conf.d/

echo "Writing dotfiles"
curl -fsSL {link} > ~/.gitconfig
curl -fsSL {link} > ~/.zshrc
curl -fsSL {link} > ~/.vimrc

vim +PlugInstall +qall   

echo "Cleanup"

echo "Finished"