" Looking good fam
filetype plugin indent on
syntax on

set t_Co=256
set background=dark
colorscheme dracula
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'RRethy/vim-illuminate'
Plug 'itchyny/lightline.vim'
call plug#end()

" Status bar mods for light line
set laststatus=2
set noshowmode
let &t_ut=''
