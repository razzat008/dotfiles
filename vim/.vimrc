set number
set relativenumber
set path+=**
set ignorecase
set visualbell
set smartcase
set clipboard=unnamedplus
set incsearch
set showcmd
set showmode
set showmatch
set nowrap
set hlsearch
set cursorline
"set cursorcolumn
set mouse=a
set wildmenu
set hlsearch

if has('syntax')
  syntax on
endif

" mapping leader key
let mapleader=" "
noremap <leader>ff :FZF <CR> 
noremap ; :
noremap <leader>e :Explore <CR>
noremap <leader>nh :nohl <CR>
noremap <esc> :nohl<CR>
noremap <C-s> :w <CR> 
noremap <C-q> :q <CR> 
noremap <C-c> :%y <CR> 
noremap <C-d> <C-d>zz <CR> 
noremap <C-u> <C-u>zz <CR> 

" tab operations
noremap <leader>to :tabnew <CR>
noremap <leader>tp :tabprevious <CR>
noremap <leader>tn :tabNext <CR>
noremap <leader>tx :close <CR>
noremap <leader>x :close <CR>

"colorscheme desert
