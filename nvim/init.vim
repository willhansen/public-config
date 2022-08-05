"More posix compliant shell than fish
if &shell =~# 'fish$'
    set shell=sh
endif

"plugins
call plug#begin('~/.vim/plugged')
 " Plugin Section
 Plug 'dracula/vim'
 Plug 'morhetz/gruvbox'
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 " Plug 'machakann/vim-sandwich'
 Plug 'tpope/vim-commentary'
 Plug 'kyazdani42/nvim-web-devicons'
 "Plug 'beauwilliams/statusline.lua'
 "Plug 'famiu/feline.nvim'
 Plug 'hoob3rt/lualine.nvim'
 Plug 'chrisbra/changesPlugin'
 Plug 'ojroques/nvim-bufbar'
 Plug 'deris/vim-shot-f'
 Plug 'yggdroot/indentline'
 Plug 'norcalli/nvim-colorizer.lua'
 Plug 'blankname/vim-fish'
call plug#end()

" color schemes
if (has("termguicolors"))
 set termguicolors
endif
syntax enable
" colorscheme evening
colorscheme dracula
"let g:gruvbox_contrast_dark = 'hard'
"colorscheme gruvbox

" font
"set guifont=ProggyCleanTTCE\ Nerd\ Font\ Mono:h12
set guifont=Fira\ Code:h10

" lua configs
lua require('config')

" enable tab bar
lua require('bufbar').setup {}

"custom options
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set smartcase               " when searching try to be smart about cases

set incsearch               " incremental search
set tabstop=2               " number of columns occupied by a tab 
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=2            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
 
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
"set cc=80                  " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.

" set to auto read when a file is changed from the outside
set autoread
" apply the autoread behavior to terminal (why not by default?)
au FocusGained * :checktime

" make Y yank to end of line instead of whole line, for consistency with D and C
map Y y$

" Let the enter button clear highlighting after a search
:nnoremap <silent> <CR> :nohlsearch<CR><CR>

" ctrl-s to save
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <Tab> pumvisible() ? coc#_select_confirm() : "\<Tab>"

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Title should be filename
set title

" Allow confirm exit without saving on :q
set confirm

" Maybe some sanity with brackets.  Maybe.
inoremap (<Tab> ()<Left>
inoremap {<Tab> {}<Left>
inoremap {<CR> {<CR><CR>}<Up><Tab>
inoremap [<Tab> []<Left>
inoremap <<Tab> <><Left>
inoremap '<Tab> ''<Left>
inoremap "<Tab> ""<Left>
inoremap """<Tab> """"""<Left><Left><Left>
inoremap """<CR> """<CR><CR>"""<Up><Tab>

" indentline plugin should not overwrite hidden color
let g:indentLine_setColors = 0
"let g:indentLine_defaultGroup = 'SpecialKey'

lua require'colorizer'.setup()

set foldmethod=indent   " fold based on indent
set foldlevelstart=20
nnoremap <space> za     " let space toggle folds
" set foldcolumn=2   " This one messes with vscodium formatting

autocmd FileType xml setlocal shiftwidth=1 tabstop=1
