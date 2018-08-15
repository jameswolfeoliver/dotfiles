" Looking good fam
filetype plugin indent on
syntax on

set t_Co=256
set background=dark
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif 

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'RRethy/vim-illuminate'
Plug 'itchyny/lightline.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

" Status bar mods for light line
set laststatus=2
set noshowmode
let &t_ut=''
