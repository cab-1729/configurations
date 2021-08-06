"plugins
source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/plug-configs/python.vim
source $HOME/.config/nvim/plug-configs/quickscope.vim
source $HOME/.config/nvim/plug-configs/quickscope.vim
source $HOME/.config/nvim/plug-configs/vim-ranger.vim
"settings
	"color
set termguicolors
command -nargs=1 -complete=color Colo colo <args>|hi Normal guibg=NONE ctermbg=NONE
command -nargs=1 -complete=color Colorscheme colo <args>|hi Normal guibg=NONE ctermbg=NONE
colorscheme elflord
	"god knows what this does
set nocompatible
	"faster macro execution
set lazyredraw
	"store history
set undodir="/root/.local/share/nvim/undos"
set undofile
	"indent settings
set autoindent
set tabstop=4
set shiftwidth=4
set noexpandtab
	"session save
set sessionoptions+=localoptions
set sessionoptions+=globals
set ssop+=options
	"file specific formatting
filetype plugin on
	"enable transparency
hi Normal guibg=NONE ctermbg=NONE
"remaps
	"Move through QuickFixList
nnoremap <C-k> :cnext<CR>
nnoremap <C-j> :cprev<CR>
	"Quicker switch to term command
nnoremap ! :!
	"Move out of terminal easily
tnoremap <C-w> <C-\><C-n><C-w>
	"Paste in terminal using Crtl+R
if has('nvim')
	  tnoremap <expr> <C-r> '<C-\><C-N>"'.nr2char(getchar()).'pi'
endif
	"make Y behave like rest of capitals
nnoremap Y y$
	"keep centered while searching
nnoremap N Nzz
nnoremap n nzz
