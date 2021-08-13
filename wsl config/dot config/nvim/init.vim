"have to keep it here for plugin to work
set termguicolors
"plugins
source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/plug-configs/python.vim
source $HOME/.config/nvim/plug-configs/quickscope.vim
source $HOME/.config/nvim/plug-configs/quickscope.vim
source $HOME/.config/nvim/plug-configs/vim-ranger.vim
luafile $HOME/.config/nvim/lua/nvim-colorizer.lua
"settings
	"color
command -nargs=1 -complete=color Colo colo <args>|hi Normal guibg=NONE ctermbg=NONE
command -nargs=1 -complete=color Colorscheme colo <args>|hi Normal guibg=NONE ctermbg=NONE
	"looks nice over and orangish background
colorscheme elflord
	"enable transparency
hi Normal guibg=NONE ctermbg=NONE
	"god knows what this does
set nocompatible
	"faster macro execution
set lazyredraw
	"numbers visible by default
set number
set relativenumber
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
"remaps
	"Move through QuickFixList
nnoremap <C-k> :cnext<CR>
nnoremap <C-j> :cprev<CR>
	"quicker switch to term command
nnoremap ! :!
	"move out of terminal easily
tnoremap <C-w> <C-\><C-n><C-w>
	"paste in terminal using Crtl+R
if has('nvim')
	  tnoremap <expr> <C-r> '<C-\><C-N>"'.nr2char(getchar()).'pi'
endif
	"make Y behave like rest of capitals
nnoremap Y y$
	"keep centered while searching
nnoremap N Nzz
nnoremap n nzz
	"toggle numbers, I have no idea what Ex mode is
nnoremap Q :set invnumber<CR>:set invrelativenumber<CR>
	"arrow keys to resize current pane
nnoremap <Up> :res +1<CR>
nnoremap <Down> :res -1<CR>
nnoremap <Left> :vert res -1<CR>
nnoremap <Right> :vert res +1<CR>
