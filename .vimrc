

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" author: mike gont
"
" sections:
"    - plugins
"    - basic vim configurations
"    - vim ui
"    - colors and fonts
"    - text, tab and indent related
"    - custom actions
"    - macros
"    - plugins configurations
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" dependencies:
" git
" fzf

" Setup vundle plugins manager
set rtp+=~/.vim/bundle/Vundle.vim/

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'preservim/nerdtree'

" context-aware pasting
Plugin 'sickill/vim-pasta'

" easy commenting motions
" Use gcc to comment out a line (takes a count), gc to comment out the target of a motion
" (for example, gcap to comment out a paragraph), gc in visual mode to comment out the selection,
" and gc in operator pending mode to target a comment. You can also use it as a command,
" either with a range like :7,17Commentary, or as part of a :global invocation like with :g/TODO/Commentary.
Plugin 'tpope/vim-commentary'
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s

" mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.
" add surroundings:    ys<text object><surroundings> (e.g. ysiw] for current word, and yss] for current line)
" change surroundings: cs<existing><new> (e.g. cs'")
" delete surroundings: ds<existing> (e.g. ds")
Plugin 'tpope/vim-surround'

" Colors
Plugin 'dracula/vim', { 'name': 'dracula' }

call vundle#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" basic vim configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" make backspace behave in a sane manner
set backspace=indent,eol,start

" set UTF-8 encoding
set enc=utf-8

" disable vi compatibility (emulation of old bugs)
set nocompatible

" recursive path for find
set path+=**

" split to the right/bottom
set splitbelow splitright


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim ui
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" line numbers
set number
" set relativenumber

" highlight matching braces
set showmatch

" mouse
set mousemodel=extend
set mouse=a

" show partial command at the bottom right corner
set showcmd

" search selected (ctrl-8 also works here)
nnoremap <C-?> *N

" highlight line when in insert
autocmd InsertEnter,InsertLeave * set cul!

" moves screen up/down when 7 lines from the edge
set so=7

" tab next prev map
map <F7> :tabp <CR>
map <F8> :tabn <CR>

" enable bash like tab completion
set wildmode=longest,list,full
set wildmenu

" Searching
set ignorecase " case insensitive searching
set smartcase " case-sensitive if expresson contains a capital letter
set hlsearch " highlight search results
set incsearch " set incremental search, like modern browsers
noremap <space> :set hlsearch! hlsearch?<cr> " clear highlighted search

" toggle invisible characters
set list
set listchars=tab:→\ ,trail:⋅,space:⋅
" bu for other options: eol:¬,extends:❯,precedes:❮

" quickfix window
map <F5> :cp <CR>
map <F6> :cn <CR>
map <F3> :copen <CR>
map <F4> :cclose <CR>
map <Leader><F4> `G:cclose <CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" colors and fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" theme 
" colorscheme nord
colorscheme dracula

" turn syntax highlighting on
set t_Co=256
syntax on

" font for gvim
set guifont=Roboto\ Mono


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Tab control
set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=4 " the visible width of tabs
set softtabstop=4 " edit as if the tabs are 4 characters wide
set shiftwidth=4 " number of spaces to use for indent and unindent
set shiftround " round indent to a multiple of 'shiftwidth'

" Indentation options
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" override indent for c++
set cinoptions=(0,N-s,g0
let g:c_syntax_for_h = 1

" wrap lines at 120 chars. 
set textwidth=120

" toggle spell checking
command Spellcheck :setlocal spell!


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" custom actions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Ctrl-S for saving
nmap <C-s> :w<CR>

" Ctrl-F5 for reloading
nmap <C-F5> :e<cr>

" open a markdown buffer for notes in a new tab
command Notes :tabe ~/.vim/notes-scratchpad.md

" search using Ggrep in the quickfix window
command! -nargs=+ GgrepAutoP execute 'silent Ggrep!' <q-args> | cw | redraw!
command! GgrepAutoCw execute 'silent Ggrep!' expand('<cword>') | cw | redraw!
map <Leader>g mG:GgrepAutoP 
map <Leader>f mG:GgrepAutoCw <CR><C-W>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" macros
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" change word to lower case and add underscore
let @u='vawuea_'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" config lightline ------------------------------------------------------------

" always show the status line
set laststatus=2

" disable default status line mode print
set noshowmode

" git conf for lightline using vim-fugitive plugin
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
" -----------------------------------------------------------------------------

" Map fzf search to CTRL P
nnoremap <C-p> :Files<Cr>

" config NERDTree
map <C-f> :NERDTreeToggle<CR>
map <leader>nf :NERDTreeFind<CR>

