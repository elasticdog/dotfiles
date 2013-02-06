"
" ~/.vimrc
"

" GENERAL
" --------------------------------------

set nocompatible  " Use Vim settings (versus Vi compatible)
set autoread      " Automatically reload when a file is changed outside of Vim
set nobackup      " Do not automatically backup files
set history=1000  " Remember 1000 lines of command line history

filetype off
execute pathogen#infect()
set runtimepath+=$GOROOT/misc/vim  " Use upstream Go lang plugins
filetype plugin indent on          " Enable file type detection


" COLORS AND FONTS
" --------------------------------------

syntax enable           " Enable syntax highlighting
set background=dark     " Set the background color brightness
colorscheme vividchalk  " Emulate TextMate's color scheme by default
" NOTE: if &t_Co == 256 ... test for 256-color capable terminal

if has('gui_running')
	colorscheme solarized  " Use different color scheme in GUI
	set columns=132        " Set the window's width
	set lines=44           " Set the window's height
	set cursorline         " Highlight the screen line of the cursor
	set guioptions-=T      " Remove the toolbar from the window


	" Set font according to operating system
	if has('macunix')
		set antialias
		set guifont=Menlo:h16
	elseif has('win32')
		set guifont=Terminus:h12:cANSI
	else
		set guifont=Terminus\ 12
	endif

	if has('gui_macvim')
		set fuoptions=maxvert,maxhorz  " Maximize when entering fullscreen
		set transparency=4             " Use slight window transparency
	endif
else
	" Make sure folds can be read when using a dark terminal
	highlight Folded ctermfg=LightGray ctermbg=DarkBlue
endif

" Highlight trailing whitespace characters and tabs not used for indention
highlight WhitespaceErrors ctermbg=Red guibg=Red
match WhitespaceErrors /\s\+$\|[^\t]\@<=\t\+/



" USER INTERFACE
" --------------------------------------

if version >= 703
	set cryptmethod=blowfish  " Use strong encryption for writing encrypted files
	set relativenumber        " Show line numbers relative to the cursor's line
else
	set number       " Show line numbers
endif

set cmdheight=1      " Reserve one row for the command bar
set hidden           " Allow the changing of buffers without saving
set hlsearch         " Highlight the last used search pattern
set ignorecase       " Ignore case when searching
set incsearch        " Enable incremental searching
set lazyredraw       " Do not redraw screen while executing macros
set list             " Display unprintable characters
set matchtime=4      " Blink matched brackets for 4/10ths of a second
set nojoinspaces     " Do not insert 2 spaces after sentences when joining
set nomodeline       " Do not read settings from modelines
set nostartofline    " Do not move cursor to SOL during jump commands
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

" Allow backspacing over everything
set backspace=eol,indent,start

" Disable sound/visual bell on errors
set noerrorbells
set novisualbell
set t_vb=

" Centrally store all swap files using full path names
set directory=/var/tmp//

" Show as much as possible of the last line in a window versus '@' lines
set display=lastline

" Make vertical separators between windows blank
set fillchars=vert:\ ,fold:-

" In list mode, use these custom characters
set listchars=tab:\|\ ,extends:>,precedes:<

" Always show the customized statusline
set laststatus=2
set statusline=%<%f\ [%M%n%R%H]%=%l/%L,%v\ %p%%

" Time out on mappings after two seconds, key codes after a tenth of a second
set timeoutlen=2000
set ttimeoutlen=100

" Cursor can be positioned anywhere when in blockwise Visual mode
set virtualedit=block

" Use enhanced command line completion
set wildmenu
set wildmode=longest:full,full
set wildignore=*.o,*.obj,*.exe,*.class,*.swp



" TEXT HANDLING
" --------------------------------------

set autoindent  " Do dumb auto-indentation when no filetype is set
set linebreak   " Wrap long lines at words boundaries
set expandtab   " Convert tabs to spaces
set nowrap      " Do not automatically wrap long lines

" Set up default tab spacing
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Indent bulleted lists properly
set comments=://,b:#,:%,:XCOMM,n:>,fb:-,fb:*

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



" HELPER FUNCTIONS
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

" See :help restore-cursor
function! RestoreCursor()
	" don't restore the cursor position for VCS commit logs
	if line("'\"") > 0
	\  && line("'\"") <= line("$")
	\  && bufname('%') !~ '\.git\/COMMIT_EDITMSG\|svn-commit\.tmp'
		exe "normal! g`\""
	endif
endfunction



" MAPPINGS & CUSTOM COMMANDS
" --------------------------------------

" Always use very magic regexes for search patterns
nnoremap / /\v
vnoremap / /\v

" Save a keystroke when entering command-line mode
noremap ; :

" Highlight all occurrences of current word without moving
nnoremap <D-*> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" Don't move linewise when long lines are wrapped
noremap j gj
noremap k gk

" Q formats paragraphs, instead of entering Ex mode
noremap Q gqip

" Assist with common typo when trying to quit
nnoremap q: q:iq<Esc>

" Assist with common mistake of not opening file with sudo
cnoremap w!! w !sudo tee % >/dev/null

" Yank from the cursor to the end of the line
nnoremap Y y$

" Add full path and buffer number to Ctrl-G display
nnoremap <C-g> 2<C-g>

" Move between windows using Ctrl + home row motion keys
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" Run the entire file through the indent filter
noremap <silent> <Leader>= :call Preserve("normal gg=G")<CR>

" Change the CWD to where the current file is located
noremap <silent> <Leader>cd :cd %:p:h<CR>

" Remove last search pattern highlighting
noremap <silent> <Leader>h :nohlsearch<CR>

" Justify text center, left, or right
noremap <silent> <Leader>jc :center<CR>
noremap <silent> <Leader>jl :left<CR>
noremap <silent> <Leader>jr :right<CR>

" Highlight lines longer than textwidth
" or column 79 if the textwidth option is not set
noremap <silent> <Leader>l m`:execute '/\%>' . (&tw ? &tw : 79) . 'v.\+'<CR>``

" Toggle paste mode
nnoremap <Leader>p :set invpaste paste?<CR>

" Remove trailing whitespace
noremap <silent> <Leader>rtw :call Preserve("%s/\\s\\+$//e")<CR>

" Replace word with the contents of the unnamed register (paste buffer)
noremap <silent> <Leader>rw "_diwhp<CR>

" Toggle spellchecking for the local buffer
noremap <silent> <Leader>sc :setlocal spell! spelllang=en_us<CR>

" Save typing when doing a global search/replace
noremap <Leader>sr :%s//g<Left><Left>

" Select the text that was just pasted
noremap <Leader>v V`]

" Open a new vertical split and switch over to it
noremap <silent> <Leader>w <C-w>v<C-w>l

" NOTE: Using these in a non-gui Vim almost never works properly
if has('gui_running')
	" Scroll through a quickfix list using Ctrl + Up/Down cursor keys
	noremap <C-Up> :cp<CR>
	noremap <C-Down> :cn<CR>
	inoremap <C-Up> <C-o>:cp<CR>
	inoremap <C-Down> <C-o>:cn<CR>

	" Move a line of text up or down using the ...
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

" ack.vim - Ack Integration
let g:ackprg = 'ag --nogroup --nocolor --column'
nnoremap <Leader>a :Ack

" bufexplorer.vim - Buffer Explorer
let g:bufExplorerShowRelativePath = 1  " Show relative paths

" ctrlp.vim - Fuzzy Finder
let g:ctrlp_map = '<c-l>'
let g:ctrlp_cmd = 'CtrlPMixed'

" factor.vim - Factor Plugin
let g:FactorRoot = '/Applications/factor'

" rails.vim - Ruby on Rails
let g:rails_default_database = 'sqlite3'

" scratch.vim - Scratch Buffer
noremap <silent> <Leader><Tab> :Scratch<CR>

" tabular.vim - Tabularize Plugin
nnoremap <Leader>A :Tabularize /

" taglist.vim - Tag List
let Tlist_Enable_Fold_Column = 0       " Do not show folding tree
let Tlist_Exit_OnlyWindow = 1          " Exit Vim if only Taglist left open
let Tlist_GainFocus_On_ToggleOpen = 1  " Taglist window gains focus on open
let Tlist_Inc_Winwidth = 0             " Do not adjust window width
nnoremap <silent> <Leader>t :TlistToggle<CR>
highlight MyTagListFileName term=reverse ctermbg=8 guibg=#333333

" yankring.vim - Yank Ring
let g:yankring_persist = 0
let g:yankring_history_file = '.yankring_history'
let g:yankring_n_keys = 'D x X'  " prevent cloberring custom Y mapping above
nnoremap <silent> <Leader>yr :YRShow<CR>



" FILETYPE SPECIFIC SETTINGS
" --------------------------------------
if has("autocmd")
	" For all go files, use tabs for indentation and auto-format on write
	autocmd FileType go setlocal noet sts=4 sw=4 ts=4 tw=74
	autocmd BufWritePre *.go :silent Fmt

	" For all JavaScript/JSON/Ruby/YAML files, use the standard 2 spaces for indentation
	autocmd FileType javascript,json,ruby,yaml setlocal et sts=2 sw=2 ts=2

	" Make sure all markdown files have the correct filetype set
	autocmd BufRead,BufNewFile *.{md,mkd,mkdn,mdown,markdown} setfiletype markdown
	autocmd BufRead,BufNewFile *.{mmd,multimarkdown} setfiletype markdown

	" For all markdown files, use 2 spaces for indentation
	autocmd FileType markdown setlocal et sts=2 sw=2 ts=2 tw=74

	" For all Python files, use the standard 4 spaces for indentation
	autocmd FileType python setlocal et sts=4 sw=4 ts=4

	" Jump to the last known cursor position when opening files
	autocmd BufReadPost * call RestoreCursor()
endif
