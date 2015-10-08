execute pathogen#infect('bundle-modifications/{}', 'bundle/{}')
syntax on
filetype plugin indent on

"--------------------------------------------------------------------------------
" AUTOCMD
"--------------------------------------------------------------------------------

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands

" Searching options
set incsearch           " do incremental searching
set hlsearch            " search highlighting
set ignorecase          " Case doesn't matter
set smartcase           " ... until it does

set switchbuf=useopen   " Only have one buffer of a file open at a time
set hidden              " Keep buffers open in the background

" Use spaces every 2 characters instead of tabs
set softtabstop=2
set shiftwidth=2
set expandtab

" Allow windows to be squashed to zero
set winminheight=0

" Open windows below
set splitbelow

" Keep 2 lines of context when scrolling
set scrolloff=2

" Don't litter the filesystem with .swp files
set directory=~/.vim/swp//

set nowrap
set linebreak
set number
set relativenumber
set visualbell

set encoding=utf-8

set wildmode=list:longest

colorscheme desert

let maplocalleader=","

"--------------------------------------------------------------------------------
" MAPPINGS
"--------------------------------------------------------------------------------

" Don't use Ex mode, use Q for quitting when saved
map Q :q<CR>

" Navigate between windows easier
map <C-J> <C-W>j
map <C-K> <C-W>k

" Navigate between tabs
map <C-H> gT
map <C-L> gt

" Stop showing highlighted search results
nmap <silent> <Leader><Space> :noh<CR>

" Toggle line wrapping
nmap <silent> <C-W><C-W> :setlocal invwrap<CR>

" Select some text and search with it
vmap // y/\V<C-R>"<CR>
vmap ?? y?\V<C-R>"<CR>

" Wrapped line movement
map <Up> gk
map <Down> gj

" Execute macro in the 'q' register
map <C-Q> @q

" More useful mappings to find the latest { or }
nmap [[ [{
nmap ]] ]}

" j/k
imap jk <ESC>

" hate-hate-hate using K to open a man page
nmap K <Nop>

" Stop accidently hitting <F1>
nmap <F1> <Nop>
nmap <D-F1> <Nop>

" Save the file easier
nmap <silent> <Leader>w :w<CR>
nmap <silent> <Leader>W :wa<CR>

" Magic voodoo that changes %% into the path of the current file in cmd mode
cnoremap %% <C-R>=expand('%:h').'/'<CR>

" Swap buffers
nmap <Leader><Leader> <C-^>

" Use 'very-magic' searching
nnoremap g/ /\v

"--------------------------------------------------------------------------------
" AUTOCMD
"--------------------------------------------------------------------------------

" For all text files set 'textwidth' to 78 characters
autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif
