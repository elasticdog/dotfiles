"
" ~/.vimrc
"

" GENERAL
" --------------------------------------

set nocompatible  " Use Vim settings (versus Vi compatible)
set autoread      " Automatically reload when a file is changed outside of Vim
set nobackup      " Do not automatically backup files
set history=100   " Remember 100 lines of command line history

filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on  " Enable file type detection



" COLORS AND FONTS
" --------------------------------------

syntax enable           " Enable syntax highlighting
colorscheme vividchalk  " Emulate TextMate's color scheme by default
" NOTE: if &t_Co == 256 ... test for 256-color capable terminal

if has('gui_running')
	set columns=132                " Set the window's width
	set fuoptions=maxvert,maxhorz  " Maximize when entering fullscreen
	set lines=44                   " Set the window's height
	set guioptions-=T              " Remove the toolbar from the window

	" Set font according to operating system
	if has('macunix')
		set antialias
		set guifont=Anonymous_Pro:h18
	elseif has('win32')
		set guifont=Terminus:h12:cANSI
	else
		colorscheme desert
		set guifont=Terminus\ 12
	endif

	" Use slight transparency when available
	if has('gui_macvim')
		set transparency=16
	endif
else
	" Make sure folds can be read when using a dark terminal
	highlight Folded ctermfg=LightGray ctermbg=DarkBlue
endif



" USER INTERFACE
" --------------------------------------

" Allow backspacing over everything
set backspace=eol,indent,start

set cmdheight=1      " Reserve one row for the command bar
set hidden           " Allow the changing of buffers without saving
set hlsearch         " Highlight the last used search pattern
set ignorecase       " Ignore case when searching
set incsearch        " Enable incremental searching
set lazyredraw       " Do not redraw screen while executing macros
set list             " Display unprintable characters
set matchtime=4      " Blink matched brackets for 4/10ths of a second
set nomodeline       " Do not read settings from modelines
set nostartofline    " Do not move cursor to SOL during jump commands
set number           " Show line numbers
set numberwidth=1    " Use the minimal number of columns for line numbers
set ruler            " Show the cursor position at all times
set scrolloff=2      " Keep two lines above and below cursor when scrolling
set showcmd          " Display incomplete commands
set showmatch        " Highlight matching brackets
set sidescrolloff=3  " Keep two columns left and right of cursor when scrolling
set smartcase        " Override ignorecase if search has upper case characters
set ttyfast          " Improve smoothness or redraw for newer terminals
set whichwrap+=h,l   " Allow cursor keys to line wrap
set winminheight=0   " Minimal height of a non-current window

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

set autoindent   " Do dumb auto-indentation when no filetype is set
set linebreak    " Wrap long lines at words boundaries
set noexpandtab  " Do not convert tabs to spaces
set smartindent  " Do smart autoindenting when starting a new line
set smarttab     " Use tabs at the start of a line, spaces elsewhere
set nowrap       " Do not automatically wrap long lines

" Set up default tab spacing
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Change default format options:
set formatoptions-=t  " turn off auto-wrapping type
set formatoptions-=c  " turn off auto-wrapping comments
set formatoptions+=q  " format comments manually with gq
set formatoptions+=n  " gq recognizes numbered lists
set formatoptions+=1  " prefer breaking before, not after, a one-letter word



" FOLDING
" --------------------------------------

set foldmethod=indent  " Lines with equal indent form a fold
set foldlevel=99       " Default to no folds closed



" MAPPINGS & CUSTOM COMMANDS
" --------------------------------------

" Execute a command while preserving the cursor location and search history
function! Preserve(command)
	" save the last search and cursor position
	let _s=@/
	let l = line(".")
	let c = col(".")
	" execute the given command
	execute a:command
	" restore the search history and cursor position
	let @/=_s
	call cursor(l, c)
endfunction

" Change the CWD to where the current file is located
noremap <silent> <Leader>cd :cd %:p:h<CR>

" Remove trailing whitespace
noremap <silent> <Leader>rtw :call Preserve("%s/\\s\\+$//e")<CR>

" Run the entire file through the indent filter
noremap <silent> <Leader>= :call Preserve("normal gg=G")<CR>

" Highlight lines longer than textwidth
" or column 79 if the textwidth option is not set
noremap <silent> <Leader>l m`:execute '/\%>' . (&tw ? &tw : 79) . 'v.\+'<CR>``

" Remove last search pattern highlighting
noremap <silent> <Leader>h :nohlsearch<CR>

" Justify text center, left, or right
noremap <silent> <Leader>jc :center<CR>
noremap <silent> <Leader>jl :left<CR>
noremap <silent> <Leader>jr :right<CR>

" Save typing when doing a global search/replace
noremap <Leader>s :%s//g<Left><Left>

" Assist with common typo when trying to quit
nnoremap q: q:iq<Esc>

" Q formats paragraphs, instead of entering Ex mode
noremap Q gq

" Yank from the cursor to the end of the line
noremap Y y$

" Add full path and buffer number to Ctrl-G display
nnoremap <C-g> 2<C-g>

" Move between windows using Ctrl + home row motion keys
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
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

" factor.vim - Factor Plugin
let g:FactorRoot = '/Applications/factor'

" NERD_tree.vim - File Explorer
let g:NERDTreeChDirMode = 2     " the CDW will follow the root folder
let g:NERDTreeQuitOnOpen = 1    " close the exporer window after opening a file
let g:NERDTreeWinPos = 'right'  " position the explorer window on the right

noremap <silent> <Leader>fe :NERDTreeToggle<CR>

" rails.vim - Ruby on Rails
let g:rails_default_database = 'sqlite3'

" taglist.vim - Tag List
let Tlist_Enable_Fold_Column = 0       " Do not show folding tree
let Tlist_Exit_OnlyWindow = 1          " Exit Vim if only Taglist left open
let Tlist_GainFocus_On_ToggleOpen = 1  " Taglist window gains focus on open
let Tlist_Inc_Winwidth = 0             " Do not adjust window width
nnoremap <silent> <Leader>T :TlistToggle<CR>
highlight MyTagListFileName term=reverse ctermbg=8 guibg=#333333

" yankring.vim - Yank Ring
nnoremap <silent> <Leader>yr :YRShow<CR>



" FILETYPE SPECIFIC SETTINGS
" --------------------------------------

" For all Ruby/YAML files, use the standard 2 spaces for indentation
autocmd FileType ruby,yaml setlocal et sts=2 sw=2 ts=2

" Jump to the last known cursor position when opening any file
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\	exe "normal! g`\"" |
	\ endif
