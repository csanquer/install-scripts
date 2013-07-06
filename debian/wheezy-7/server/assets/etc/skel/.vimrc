" use autoload pathogen.vim from https://github.com/tpope/vim-pathogen
"call pathogen#infect()

" Basics
set nocompatible        " must be first line

" Windows Compatible
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
"if has('win32') || has('win64')
"  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
"endif

if &term == "builtin_gui"
    set background=light
else
    set background=dark
endif
"set background=dark         " Assume a dark background
"set term=builtin_ansi       " Make arrow and other keys work
filetype plugin indent on   " Automatically detect file types.
syntax on                   " syntax highlighting
"set mouse=a                 " automatically enable mouse usage
"set autochdir              " always switch to the current file directory..
" not every vim is compiled with this, use the following line instead
"scriptencoding utf-8
set fileformat=unix
set encoding=utf-8
set autowrite                  " automatically write a file when leaving a modified buffer
"set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
set virtualedit=onemore         " allow for cursor beyond last character"
set history=100                " Store a ton of history (default is 20)
"set spell                       " spell checking on

" Setting up the directories
"set backup                      " backups are nice ...
"set backupdir=$HOME/.vimbackup//  " but not when they clog .
"set directory=$HOME/.vimswap//  " Same for swap files
"set viewdir=$HOME/.vimviews//   " same for view files

"" Creating directories if they don't exist
"silent execute '!mkdir -p $HOME/.vimbackup'
"silent execute '!mkdir -p $HOME/.vimswap'
"silent execute '!mkdir -p $HOME/.vimviews'
"au BufWinLeave * silent! mkview  "make vim save view (state) (folds, cursor, etc)
"au BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)


" Vim UI
"color molokai                   " load a colorscheme
"set tabpagemax=15               " only show 15 tabs
set showmode                    " display the current mode

"set cursorline                  " highlight current line
"hi cursorline guibg=#333333     " highlight bg color of current line
"hi CursorColumn guibg=#333333   " highlight cursor

if has('cmdline_info')
    set ruler                   " show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
    set showcmd                 " show partial commands in status line and
                                " selected characters/lines in visual mode
endif

if has('statusline')
    set laststatus=1            " show statusline only if there are > 1 windows
    " Use the commented line if fugitive isn't installed
    set statusline=%<%f\ %=\:\b%n%y%m%r%w\ %l,%c%V\ %P " a statusline, also on steroids
    "set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
endif

set backspace=indent,eol,start  " backspace for dummys
set linespace=0                 " No extra spaces between rows
set nu                          " Line numbers on
set showmatch                   " show matching brackets/parenthesis
set incsearch                   " find as you type search
set hlsearch                    " highlight search terms
set winminheight=0              " windows can be 0 line high
set ignorecase                  " case insensitive search
set smartcase                   " case sensitive when uc present
set wildmenu                    " show list instead of just completing
set wildmode=list:longest,full  " comand <Tab> completion, list matches, then longest common part, then all.
"set whichwrap=b,s,h,l,<,>,[,] " backspace and cursor keys wrap to
set scrolljump=5                " lines to scroll when cursor leaves screen
set scrolloff=3                 " minimum lines to keep above and below cursor
set foldenable                  " auto fold code
set gdefault                    " the /g flag on :s substitutions by default

" Formatting
"set nowrap                      " wrap long lines
set autoindent                  " indent at the same level of the previous line
set tabstop=4                   " an indentation every four columns
set softtabstop=4
set shiftwidth=4                " use indents of 4 spaces
set expandtab                   " tabs are spaces

nmap <F10> :set number! number?<cr>
"set matchpairs+=<:>              " match, to be used with %
set pastetoggle=<F12>             " pastetoggle (sane indentation on pastes)
"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks

"nmap <silent> <F2> :NERDTreeToggle<CR>
