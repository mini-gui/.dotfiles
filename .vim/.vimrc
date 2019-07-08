" initialize pathogen
set nocp
if exists('$DOTFILES')
    source $DOTFILES/.vim/autoload/pathogen.vim
endif

execute pathogen#infect('bundle/{}', '~/.dotfiles/.vim/bundle/{}')
execute pathogen#helptags()

" general settings
syntax on
filetype plugin indent on
set t_Co=256
set showcmd
set cursorline
set ttyfast
set cot=menu
set updatetime=100
set showmatch
set wildmenu
set lazyredraw
set encoding=utf-8
set breakindent
set nojoinspaces
set nrformats=
set autochdir
set noshowmode
set clipboard^=unnamed


" disable swapfiles
set noswapfile

" disable autoformat comments in newline
au FileType * set fo-=c fo-=r fo-=o

" search settings
set hlsearch
set ignorecase
set smartcase
set incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)k

" Enter and <S-Enter> to insert empty lines
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" fix esc delay
set ttimeout
set ttimeoutlen=100
set timeoutlen=3000

"colorscheme settings 
let g:onedark_termcolors=16
colorscheme onedark

" cursor in terminal vim
if exists('$TMUX')
    let &t_SI = "\ePtmux;\e\e[4 q\e\\"
    let &t_SR = "\ePtmux;\e\e[3 q\e\\"
    let &t_EI = "\ePtmux;\e\e[2 q\e\\"
else
    let &t_SI = "\e[4 q"
    let &t_SR = "\e[3 q"
    let &t_EI = "\e[2 q"
endif

" relative numbering with autocmd
set number
set relativenumber
au InsertEnter * set norelativenumber
au InsertLeave * set relativenumber

" always show at least one line after cursor
if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

" history / undo settings
set history=1000
set undolevels=1000

" move across visual line
nnoremap j gj
nnoremap k gk

" buffer navigation
set hidden
nnoremap <C-l>l :bnext<CR>
nnoremap <C-l>h :bprevious<CR>

" smart suggestion
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

" disable Q for ex-mode
nnoremap Q <nop>

" ctrl + n / p to move lines
nnoremap <C-n> :m .+1<CR>==
inoremap <C-n> <Esc>:m .+1<CR>==gi
vnoremap <C-n> :m '>+1<CR>gv=gv
nnoremap <C-p> :m .-2<CR>==
inoremap <C-p> <Esc>:m .-2<CR>==gi
vnoremap <C-p> :m '<-2<CR>gv=gv

" line wrapping
:set wrap
:set linebreak
:set nolist

" define templates
au BufNewFile *.py 0r ~/.dotfiles/.vim/templates/python.template

" tab settings
set tabstop=4
set softtabstop=4
set expandtab
set shiftround
set shiftwidth=4
set autoindent
set smartindent

" leader setting
let mapleader=" "
let maplocalleader=" "

"python syntax
let g:python_highlight_all = 1

" quick save
nnoremap <leader>ev :sp $MYVIMRC<CR>
nnoremap <leader>sv :so $MYVIMRC<CR>
nnoremap <leader>ww :w<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>qq :q<CR>
nnoremap <leader>QQ :q!<CR>
nnoremap <leader>QA :qa!<CR>

" quick search
nnoremap <leader>ff :%s/
set gdefault

" more natural split openings
set splitbelow
set splitright

" enforcing purity
noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Right> <Nop>
noremap <Left>  <Nop>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" statusline settings
" function! GitBranch()
"   return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
" endfunction
" 
" function! StatuslineGit()
"   let l:branchname = GitBranch()
"   return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
" endfunction

" backups
set nobackup
set noswapfile
set nowritebackup
set viminfo="NONE"

set laststatus=2
set statusline=
set statusline+=%2*::
" set statusline+=%{StatuslineGit()}\ 
set statusline+=%1*\ %F
set statusline+=\ %m
set statusline+=%=
set statusline+=\%y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ \[%{&fileformat}\]
set statusline+=\ %3l
set statusline+=/
set statusline+=%3L\ 
set statusline+=%2*\ %3p%%\ 
set statusline+=\ ::

" statusline colors
hi User1 cterm=bold ctermbg=white ctermfg=black
hi User2 cterm=bold ctermbg=black ctermfg=white

" auto-pairs config (support for f-strings)
autocmd FileType python let b:AutoPairs = AutoPairsDefine({"f'" : "'"})

" append.vim
nnoremap <silent> <Leader>a :set opfunc=Append<CR>g@
nnoremap <silent> <Leader>i :set opfunc=Insert<CR>g@
function! Append(type, ...)
    normal! `]
    if a:type == 'char'
        call feedkeys("a", 'n')
    else
        call feedkeys("o", 'n')
    endif
endfunction
function! Insert(type, ...)
    normal! `[
    if a:type == 'char'
        call feedkeys("i", 'n')
    else
        call feedkeys("O", 'n')
    endif
endfunction

nmap <leader>tt :QuickRun<CR>
let g:quickrun_config = {
    \'*': {
    \'outputter/buffer/split': ':8split',
    \'ouputter/buffer/into': 1,
    \'ouputter/buffer/close_on_emply': 1,
    \'hook/time/enable': 1,
    \'hook/time/format': '[Finished in %gs]',
    \},
\}

" seamles tmux navigation
let g:tmux_navigator_disable_when_zoomed = 1
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-s>h :TmuxNavigateLeft<cr>
nnoremap <silent> <c-s>j :TmuxNavigateDown<cr>
nnoremap <silent> <c-s>k :TmuxNavigateUp<cr>
nnoremap <silent> <c-s>l :TmuxNavigateRight<cr>
nnoremap <silent> <c-s>/ :TmuxNavigatePrevious<cr>

" airline simple settings
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod = ':t'

" buffer navigation
nnoremap <leader>hh :bprevious<CR>
nnoremap <leader>ll :bnext<CR>
nnoremap <leader>ii :confirm bd<CR>
