"
" ~/.vimrc
"

" GENERAL
" --------------------------------------

set nocompatible  " Use Vim settings (versus Vi compatible)
set autoread      " Automatically reload when a file is changed outside of Vim
set nobackup      " Do not automatically backup files
set history=100   " Remember 100 lines of command line history

filetype plugin indent on  " Enable file type detection



" COLORS AND FONTS
" --------------------------------------

syntax enable       " Enable syntax highlighting
colorscheme desert  " Use the desert color scheme by default
" NOTE: if &t_Co == 256 ... test for 256-color capable terminal

if has('gui_running')
	set columns=115    " Set the window's width
	set lines=42       " Set the window's height
	set guioptions-=T  " Remove the toolbar from the window

	" Set font according to operating system
	if has('macunix')
		colorscheme vividchalk  " Emulate TextMate's color scheme
		set antialias
		set guifont=Andale_Mono:h14
	elseif has('win32')
		set guifont=Terminus:h12:cANSI
	else
		set guifont=Terminus\ 12
	endif

	" Use slight transparency when available
	if has('gui_macvim')
		set transparency=8
	endif
else
	" Make sure folds can be read when using a dark terminal
	highlight Folded ctermfg=LightGray ctermbg=DarkBlue
endif



" USER INTERFACE
" --------------------------------------

" Allow backspacing over everything
set backspace=eol,indent,start

set cmdheight=1     " Reserve one row for the command bar
set hidden          " Allow the changing of buffers without saving
set hlsearch        " Highlight the last used search pattern
set ignorecase      " Ignore case when searching
set incsearch       " Enable incremental searching
set lazyredraw      " Do not redraw screen while executing macros
set matchtime=4     " Blink matched brackets for 4/10ths of a second
set number          " Show line numbers
set ruler           " Show the cursor position at all times
set scrolloff=2     " Keep two lines above and below cursor when scrolling
set showcmd         " Display incomplete commands
set showmatch       " Highlight matching brackets
set smartcase       " Override ignorecase if search has upper case characters
set whichwrap+=h,l  " Allow cursor keys to line wrap
set winminheight=0  " Minimal height of a non-current window

" Show as much as possible of the last line in a window versus '@' lines
set display=lastline

" Make vertical separators between windows blank
set fillchars=vert:\ ,fold:-

" In list mode, use these custom characters
set listchars=tab:»\ ,extends:>,precedes:<

" Time out on mappings after two seconds, key codes after a tenth of a second
set timeoutlen=2000
set ttimeoutlen=100

" Cursor can be positioned anywhere when in blockwise Visual mode
set virtualedit=block

" Disable sound/visual bell on errors
set noerrorbells
set novisualbell
set t_vb=

" Use enhanced command line completion
set wildmenu
set wildmode=longest:full,full
set wildignore=*.o,*.obj,*.exe,*.class,*.swp

" Always show the customized statusline
set laststatus=2
set statusline=%<%f\ [%M%n%R%H]%=%l/%L,%v\ %p%%

" Highlight trailing whitespace characters and tabs not used for indention
highlight WhitespaceErrors ctermbg=Red guibg=Red
match WhitespaceErrors /\s\+$\|[^\t]\@<=\t\+/



" TEXT HANDLING
" --------------------------------------

set autoindent   " Copy indent from current line when starting a new line
set linebreak    " Wrap long lines at words boundaries
set noexpandtab  " Do not convert tabs to spaces
set smartindent  " Do smart autoindenting when starting a new line
set smarttab     " Use tabs at the start of a line, spaces elsewhere
set nowrap       " Do not automatically wrap long lines

" Set up default tab spacing
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Change default format options to always recognize numbered lists and
" automatically insert comment leader after hitting <Enter> in Insert mode
set formatoptions+=rn



" FOLDING
" --------------------------------------

set foldmethod=indent  " Lines with equal indent form a fold
set foldlevel=99       " Default to no folds closed



" MAPPINGS & CUSTOM COMMANDS
" --------------------------------------

" Change the CWD to where the current file is located
noremap <silent> <Leader>cd :cd %:p:h<CR>

" Remove trailing whitespace
noremap <silent> <Leader>rtw :%s/\s\+$//g<CR>``

" Remove last search pattern highlighting
noremap <Leader>h :nohlsearch<CR>

" Assist with common typo when trying to quit
nnoremap q: q:iq<Esc>

" Yank from the cursor to the end of the line
noremap Y y$

" Move between windows using Ctrl + home row motion keys
noremap <C-j> <C-W>j<C-W>_
noremap <C-k> <C-W>k<C-W>_
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" Scroll through a quickfix list using Ctrl + Up/Down cursor keys
" NOTE: Using these in a non-gui Vim almost never works properly
if has('gui_running')
	noremap <C-Up> :cp<CR>
	noremap <C-Down> :cn<CR>
	inoremap <C-Up> <C-o>:cp<CR>
	inoremap <C-Down> <C-o>:cn<CR>
endif

" Move a line of text up or down using the ...
" NOTE: Using these in a non-gui Vim almost never works properly
if has('gui_running')
	" Set mapped keys according to operating system
	if has('macunix')
		" ... Apple + cursor keys
		nnoremap <silent> <D-j> m`:m+<CR>==g``
		nnoremap <silent> <D-k> m`:m-2<CR>==g``
		vnoremap <silent> <D-j> :m'>+<CR>gv=gv
		vnoremap <silent> <D-k> :m'<-2<CR>gv=gv
	else
		" ... Alt + cursor keys
		nnoremap <silent> <M-j> m`:m+<CR>==g``
		nnoremap <silent> <M-k> m`:m-2<CR>==g``
		vnoremap <silent> <M-j> :m'>+<CR>gv=gv
		vnoremap <silent> <M-k> :m'<-2<CR>gv=gv
	endif
endif



" PLUGIN CONFIGURATION
" --------------------------------------

" bufexplorer.vim - Buffer Explorer
let g:bufExplorerShowRelativePath = 1  " Show relative paths

" NERD_commenter.vim - NERD Commenter
let NERDDefaultNesting = 1       " Coments are nested automatically
let NERDMapleader = '<Leader>c'  " Use the standard <Leader> instead of ,
let NERDSpaceDelims = 1          " Add a space between delimeters and comments

" project.vim - Project Plugin
let g:proj_flags = 'cimst'    " Close Project window when file selected
let g:proj_window_width = 30  " Width of Project window matches Taglist
nmap <silent> <Leader>p <Plug>ToggleProject
nmap <silent> <Leader>P :Project<CR>

" rails.vim - Ruby on Rails
let g:rails_default_database = 'sqlite3'

" taglist.vim - Tag List
let Tlist_Enable_Fold_Column = 0       " Do not show folding tree
let Tlist_Exit_OnlyWindow = 1          " Exit Vim if only Taglist left open
let Tlist_GainFocus_On_ToggleOpen = 1  " Taglist window gains focus on open
let Tlist_Inc_Winwidth = 0             " Do not adjust window width
nnoremap <silent> <Leader>t :TlistToggle<CR>
nnoremap <silent> <Leader>T :TlistOpen<CR>
highlight MyTagListFileName term=reverse ctermbg=8 guibg=#333333



" FILETYPE SPECIFIC SETTINGS
" --------------------------------------

" For all Ruby/YAML files, use the standard 2 spaces for indentation
autocmd FileType ruby,yaml setlocal et sts=2 sw=2 ts=2

" Jump to the last known cursor position when opening any file
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\	exe "normal! g`\"" |
	\ endif
