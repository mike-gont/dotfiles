

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
"    - ccscope and gtags
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Setup vundle plugins manager
set rtp+=~/.vim/bundle/Vundle.vim/

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'dracula/vim', { 'name': 'dracula' }
Plugin 'arcticicestudio/nord-vim'
Plugin 'itchyny/lightline.vim'
Plugin 'ack.vim'
Plugin 'taglist.vim'
Plugin 'tpope/vim-fugitive'

" Ctrl-P to search for files. use <F5> inside to refresh.
Plugin 'kien/ctrlp.vim'

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

" turn line numbers on with relative
set number
set relativenumber

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

" Cool search into quickfix window - from yakir
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

" config fzf
"map <C-p> <C-o>:Files<CR>
"map <leader>t :Tags<CR>

" config NERDTree
map <C-f> :NERDTreeToggle<CR>
map <leader>nf :NERDTreeFind<CR>

" config CtrlP:
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|build|build_unittest|logs.whiteboxtest)$',
  \ 'file': '\v\.(so|pyc|swp|exe|bat|jar|zip|bz2|tar|sqlite|orig)$',
  \ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ccscope and gtags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" gtags -----------------------------------------

" need to install gtags seperatly before this 
" gtags config from installation dir 
source ~/.vim/gtags-vim/plugin/gtags.vim

" set cscope to use gtags 
set csprg=gtags-cscope

let Gtags_No_Auto_Jump = 1

func Gtags_load_all()
    !gtags 
    cs add GTAGS
endfunc

" init command
command InitGtags :call Gtags_load_all()<cr><cr>

" finds reference or definitions depending on context
" cw def -> ref, cw ref -> def
map <Leader>s mG:GtagsCursor <cr>
map <Leader>d mG:Gtags
map <Leader>a mG:Gtagsa
" note: I added mG to set a marker, so that the quickfix close command would jump back to it


" cscope ----------------------------------------

" use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
set cscopetag

" check cscope for definition of a symbol before checking ctags: set to 1
" if you want the reverse search order.
set csto=0


" To do the first type of search, hit 'CTRL-\', followed by one of the
" cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
" search will be displayed in the current window.  You can use CTRL-T to
" go back to where you were before the search.  

nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
" makes the vim window split vertically, with search result displayed in
" the new window.

nmap <C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :vert scs find i <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

" Using 'CTRL-l' then a search type
" makes vim open a new tab, with search result displayed in
" the new tab.

nmap <C-l>s :tab scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-l>g :tab scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-l>c :tab scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-l>t :tab scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-l>e :tab scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-l>f :tab scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-l>i :tab scs find i <C-R>=expand("<cfile>")<CR><CR>
nmap <C-l>d :tab scs find d <C-R>=expand("<cword>")<CR><CR>

" Taglist
let g:Tlist_Show_One_File = 1
let g:Tlist_Auto_Open = 0
let g:Tlist_WinWidth = 60
nnoremap <silent> <Leader><F9> :TlistHighlightTag<CR>
nnoremap <silent> <F9> :TlistToggle<CR>

