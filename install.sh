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

echo "\n\nInstalling oh my zsh"
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "\n\nInstalling powerlevel9k"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

echo "\n\nInstalling powerlevel9k fonts"
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf

mv PowerlineSymbols.otf ~/.local/share/fonts/
fc-cache -vf ~/.local/share/fonts/

mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

echo "\n\nWriting dotfiles"
curl -fsSL https://raw.githubusercontent.com/jameswolfeoliver/dotfiles/master/git/.gitconfig > ~/.gitconfig
#curl -fsSL https://raw.githubusercontent.com/jameswolfeoliver/dotfiles/master/zsh/.zshrc > ~/.zshrc
curl -fsSL https://raw.githubusercontent.com/jameswolfeoliver/dotfiles/master/vim/.vimrc > ~/.vimrc

vim +PlugInstall +qall   

echo "\n\nFinished"