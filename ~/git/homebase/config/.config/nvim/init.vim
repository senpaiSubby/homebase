set nocompatible
set hidden


set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Specify a directory for plugins
set rtp+=~/.local/share/nvim/plugged
call plug#begin('~/.local/share/nvim/plugged')




Plug 'morhetz/gruvbox'
Plug 'zezic/onedark.vim'

"Linters
Plug 'neomake/neomake'

" Formatting
Plug 'sbdchd/neoformat'

" Async autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Completion from other opened files
Plug 'Shougo/context_filetype.vim'
" Smooth scrolling
Plug 'yuttie/comfortable-motion.vim'
" Python autocompletion
Plug 'zchee/deoplete-jedi', { 'do': ':UpdateRemotePlugins' }

" Just to add the python go-to-definition and similar features, autocompletion
" from this plugin is disabled
Plug 'davidhalter/jedi-vim'

" Automatically close parenthesis, etc
Plug 'jiangmiao/auto-pairs'
" Tagbar
Plug 'majutsushi/tagbar'

" Indent guides
Plug 'Yggdroot/indentLine'

" Rainbow parenthesis
Plug 'kien/rainbow_parentheses.vim'

" Hightlight Yanking
Plug 'machakann/vim-highlightedyank'
" Fuzzy file finder
Plug 'ctrlpvim/ctrlp.vim' 
" File manager
"Plug 'scrooloose/nerdtree'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'

" Airline status bars
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

" lightline status bar
"Plug 'itchyny/lightline.vim'

" Git indicators
Plug 'airblade/vim-gitgutter'
" Text jumping
Plug 'easymotion/vim-easymotion'
" Sexy color scheme
Plug 'reedes/vim-colors-pencil' 



" Initialize plugin system
call plug#end()
filetype on
filetype plugin on
filetype plugin indent on

"-------------------
" General settings
"-------------------
set guicursor=
set encoding=utf8
set t_Co=256
let base16colorspace=256
set guifont="SauceCodePro Nerd Font Mono 8"
colorscheme gruvbox
syntax enable



" Allow saving of files as sudo when I forgot to start vim using sudo.
"map <leader>o :w !sudo tee % <CR>

" switch buffers
map <leader>] :bnext <CR>
map <leader>[ :bprevious <CR>


let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='gruvbox'

let g:ranger_map_keys = 0
map `` :Ranger <CR>
map <leader>pr :!python %
map <leader>p :!python % <CR>

" Enable alignment
let g:neoformat_basic_format_align = 1

" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

"---------------------------
" Pencil Theme
"---------------------------
let g:pencil_terminal_italics = 1
let g:pencil_gutter_color = 1
let g:pencil_neutral_code_bg = 1   " 0=gray (def), 1=normal
let g:pencil_higher_contrast_ui = 1   " 0=low (def), 1=high
"----------------------------
" Rainbow parenthesis
"----------------------------
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


"-------------------
" Nerd Tree
"-------------------
"map `` :NERDTreeToggle<CR>
"map ]] :bnext<CR>
"map [[ :bprevious<CR>
"" Open nerdtree automatically
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"" Open automatically on folder
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
"" Close nvim if nerdtree is last opened
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"
"
"-------------------
" Vim indents
"-------------------------

let g:indentLine_enabled = 1



let g:python2_host_prog='/usr/bin/python'
let g:python3_host_prog='/usr/bin/python3'
set shell=/bin/zsh
set number                                " show line numbers
set ttyfast                               " terminal acceleration

set tabstop=4                             " 4 whitespaces for tabs visual presentation
set shiftwidth=4                          " shift lines by 4 spaces
set smarttab                              " set tabs for a shifttabs logic
set expandtab                             " expand tabs into spaces
set autoindent                            " indent when moving to the next line
set showmatch                             " show matching part of bracket parts (), [], {}
set enc=utf-8                             " utf-8 by default
set nobackup                              " no backup files
set noswapfile
set backspace=indent,eol,start            " backspace removes all
set scrolloff=20
set clipboard=unnamed                     " use system clipboard
set listchars=tab:>\ ,trail:•,extends:#,nbsp:." Indent guides settings

" Auto update
set autoread
set autowrite

" Uncomment it if you want to use mouse
" if has('mouse')
set mouse=a
" endif


"------------------------
" light line
"------------------------
let g:lightline = {'colorscheme': 'solarized dark'}

" -----------------------
" deoplete settings
" -----------------------

" Run on startup
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
" complete with words from any opened file
let g:context_filetype#same_filetypes = {}
let g:context_filetype#same_filetypes._ = '_'
" Remap to tab
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" Auto close popup after Completion
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose | endif

" -----------------------
" Tab / Buffers settings
" -----------------------
tab sball
set switchbuf=useopen
set laststatus=2
nmap <F9> :bprev<CR>
nmap <F10> :bnext<CR>
nmap <silent> <leader>q: SyntasticCheck # <CR> :bp <BAR> bd #<CR>

" --------------------------
" Airline settings
" --------------------------
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts=1


" -----------------------
" Comforable Motion
" -----------------------
"  disable auto config
let g:comfortable_motion_no_default_key_mappings = 1

" Scroll according to window height
let g:comfortable_motion_impulse_multiplier = 1  " Feel free to increase/decrease this value.
nnoremap <silent> <C-d> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 2)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -2)<CR>
nnoremap <silent> <C-f> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 4)<CR>
nnoremap <silent> <C-b> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -4)<CR>


"scroll speeds
let g:comfortable_motion_friction = 70.0
let g:comfortable_motion_air_drag = 2.0

let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"

" -----------------------
" DevIcon settings
" -----------------------
" loading the plugin 
let g:webdevicons_enable = 1

" adding the flags to NERDTree 
let g:webdevicons_enable_nerdtree = 1

" adding to vim-airline's tabline
let g:webdevicons_enable_airline_tabline = 1

" adding to vim-airline's statusline
let g:webdevicons_enable_airline_statusline = 1

" turn on/off file node glyph decorations (not particularly useful)
let g:WebDevIconsUnicodeDecorateFileNodes = 1

" use double-width(1) or single-width(0) glyphs 
" only manipulates padding, has no effect on terminal or set(guifont) font
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1

" whether or not to show the nerdtree brackets around flags 
let g:webdevicons_conceal_nerdtree_brackets = 0

" the amount of space to use after the glyph character (default ' ')
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '

" Force extra padding in NERDTree so that the filetype icons line up vertically
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1 

" change the default character when no match found
let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = 'ƛ'

" set a byte character marker (BOM) utf-8 symbol when retrieving file encoding
" disabled by default with no value
let g:WebDevIconsUnicodeByteOrderMarkerDefaultSymbol = ''

" enable folder/directory glyph flag (disabled by default with 0)
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" enable open and close folder/directory glyph flags (disabled by default with 0)
let g:DevIconsEnableFoldersOpenClose = 1

" enable pattern matching glyphs on folder/directory (enabled by default with 1)
let g:DevIconsEnableFolderPatternMatching = 1

" enable file extension pattern matching glyphs on folder/directory (disabled by default with 0)
let g:DevIconsEnableFolderExtensionPatternMatching = 0
