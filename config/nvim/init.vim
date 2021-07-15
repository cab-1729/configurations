"settings
	"color
set termguicolors
colorscheme gruvbox
	"god knows what this does
set nocompatible
	"indent settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set sessionoptions+=localoptions
set sessionoptions+=globals
set ssop+=options
	"file specific formatting
filetype plugin on
"plugins
source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/plug-configs/python.vim
source $HOME/.config/nvim/plug-configs/quickscope.vim
source $HOME/.config/nvim/plug-configs/rainbow.vim
"remaps
nnoremap <C-k> :cnext<CR>
nnoremap <C-j> :cprev<CR>
nnoremap ! :!
tnoremap <C-w> <C-\><C-n><C-w>
