" Specift a directory for plugins
call plug#begin('~/.vim/plugged')

" ====================
" | Language support |
" ====================

" Syntax
Plug 'sheerun/vim-polyglot' " Multilanguage

" Language tools
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " Golang

" ==========================
" | File system navigation |
" ==========================

Plug 'scrooloose/nerdtree' " NerdTree
Plug 'Xuyuanp/nerdtree-git-plugin' " Git Plugin
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fuzzyfinder

" =========
" | Theme |
" =========

Plug 'rakr/vim-one' " One
Plug 'itchyny/lightline.vim' " lightline

" ==========
" | TagBar |
" ==========

Plug 'majutsushi/tagbar' " Tagbar
Plug 'ludovicchabant/vim-gutentags' " Tag File Generation

" ================
" | Autocomplete |
" ================

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Deoplete

" ========
" | Misc |
" ========

Plug 'powerman/vim-plugin-AnsiEsc' " Documentation lookup
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'airblade/vim-gitgutter' " Shows line modified since last git pull
Plug 'terryma/vim-multiple-cursors' " atom like multicursor

call plug#end()

filetype plugin indent on

" =========
" | Theme |
" =========

if (has("termguicolors"))
 set termguicolors
endif

" Theme
let g:one_allow_italics = 1 " Allows Italics

syntax enable
colorscheme one
set background=dark

" Make comment on italic
highlight Comment cterm=italic

" Make neovim bg transparant
highlight Normal ctermbg=none
highlight NonText ctermbg=none
set notermguicolors

" Cursors tuning
highlight CursorLine ctermbg=256
highlight CursorColumn ctermbg=256

" Lightline
set noshowmode " remove -- INSERT --

let g:lightline = {
      \ 'colorscheme': 'one',
      \ }

" ===============
" | Text editor |
" ===============

let mapleader = ","     " Leader configuration
set tabstop=2           " Show existing tab with 2 spaces width
set shiftwidth=2        " When indenting with '>', uses 2 spaces width
set expandtab           " On pressing tab, insert 2 spaces
set nu                  " Display line numbers
set autowrite           " Autowrite on :make
set nobackup noswapfile " Disable backup files
set encoding=utf-8      " Encoding
set hlsearch            " Highlight search results
set incsearch           " Incremental search, search as you type
set ignorecase          " Ignore case when searching
set smartcase           " Ignore case when searching lowercase
set cursorline          " Highlight cursor line
set cursorcolumn        " Highlight cursor column
set title               " Set the title of the iterm tab

" Stop highlighting on Enter
map <CR> :noh<CR> 

" Remove the arrow key
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

"  =========
"  | Ctags |
"  =========

let g:gutentags_cache_dir = '~/.tags_cache'
" Build ctags on save
au BufWritePost *.go silent! !ctags -R --exclude=.git --exclude=log & 
au BufWritePost *.php silent! !ctags -R --exclude=.git --exclude=log & 
au BufWritePost *.yml silent! !ctags -R --exclude=node_modules --exclude=.git --exclude=log & 
au BufWritePost *.js silent! !ctags -R --exclude=node_modules --exclude=.git --exclude=log & 
au BufWritePost *.ts silent! !ctags -R --exclude=node_modules --exclude=.git --exclude=log & 
au BufWritePost *.vue silent! !ctags -R --exclude=node_modules --exclude=.git --exclude=log & 

" ============
" | Terminal |
" ============

" split the screen verticaly and open a new term
nmap <leader>vt :vsplit term://zsh<CR>
" escape the insert mode on escape
:tnoremap <Esc> <C-\><C-n>

" ==========
" | GoLang |
" ==========

let g:go_fmt_command = "goimports" " Auto imports


"run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" Error navigation
autocmd FileType go map <leader>n :cnext<CR>
autocmd FileType go map <leader>m :cprevious<CR>
autocmd FileType go nnoremap <leader>a :cclose<CR>
autocmd FileType go nnoremap <leader>t :wa<CR> :GoTest<CR>
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

" Synthaxe highlight for go
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1

" Metalinter support
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1

" ============
" | NERDTREE |
" ============

" Auto open
autocmd vimenter * NERDTree | wincmd p

" Open NERDTree on f3
map <F3> :NERDTreeToggle<CR>

" Close NerdTree if the only windows left is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ============
" | Deoplete |
" ============

let g:deoplete#enable_at_startup = 1 " start deoplete.

" ==========
" | TagBar |
" ==========

" Auto open
autocmd VimEnter * nested :TagbarOpen

" Open on f4 
nmap <F4> :TagbarToggle<CR>

" ===============
" | FUZZYFINDER |
" ===============

" bind fuzzy finder
map <C-f> :FZF<CR>
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-h': 'split',
  \ 'ctrl-v': 'vsplit' }

" =======
" | TAB |
" =======

" bind tab control
" Open new tab
map <C-t> :tabnew<CR>
map <C-l> :+tabnext<CR>
map <C-h> :-tabnext<CR>

