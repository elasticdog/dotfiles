"
" ~/.nvimrc
"

" PLUGINS
" --------------------------------------

call plug#begin()

Plug 'bling/vim-airline'
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.whitespace = 'Ξ'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'd11wtq/ctrlp_bdelete.vim'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_match_window = 'max:16,results:64'
let g:ctrlp_open_multiple_files = '1r'
let g:ctrlp_open_new_file = 'r'

Plug 'terryma/vim-expand-region'
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

Plug 'jeetsukumaran/vim-filebeagle'
let g:filebeagle_show_line_numbers = 1
let g:filebeagle_show_line_relativenumbers = 0

Plug 'tpope/vim-fugitive'
command! Gstaged :Git! diff --staged

Plug 'airblade/vim-gitgutter'
let g:gitgutter_override_sign_column_highlight = 0

Plug 'mhinz/vim-grepper'
let g:grepper = {
	\ 'tools':     ['ag', 'git', 'grep'],
	\ 'open':      1,
	\ 'switch':    1,
	\ 'jump':      0,
	\ 'next_tool': '<C-G>',
	\ }

Plug 'majutsushi/tagbar'
let g:tagbar_autoclose = 1

Plug 'janko-m/vim-test'
let test#strategy = 'neovim'

Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-endwise'
Plug 'floobits/floobits-neovim'
Plug 'tpope/vim-repeat'
Plug 'mtth/scratch.vim'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
Plug 'maxbrunsfeld/vim-yankstack'

" File Types
Plug 'nathangrigg/vim-beancount'
Plug 'elixir-lang/vim-elixir'
Plug 'lambdatoast/elm.vim'
Plug 'dag/vim-fish'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug '~/.config/nvim/vendor/nginx'
Plug '~/.config/nvim/vendor/nix'
Plug 'rodjek/vim-puppet'
Plug 'rust-lang/rust.vim'
let g:rustfmt_autosave = 1
Plug 'cespare/vim-toml'

" Color Schemes
Plug 'tpope/vim-vividchalk'

call plug#end()

runtime! macros/matchit.vim
call ctrlp_bdelete#init()
call yankstack#setup()


" COLORS AND FONTS
" --------------------------------------

colorscheme vividchalk

" Remove the underline from the cursorline
highlight CursorLine cterm=bold ctermbg=234

" Adjust colors for the line numbers and fold indicators
highlight CursorLineNr ctermfg=Yellow ctermbg=234
highlight LineNr ctermfg=DarkGray ctermbg=232
highlight FoldColumn ctermfg=DarkGray ctermbg=234
highlight SignColumn ctermfg=DarkGray ctermbg=234

" Highlight directories different from files in listings
highlight Directory ctermfg=Blue

" Highlight trailing whitespace characters and tabs not used for indentation
highlight WhitespaceErrors ctermbg=red guibg=red
match WhitespaceErrors /\s\+$/
autocmd BufWinEnter * match WhitespaceErrors /\s\+$\|[^\t]\@<=\t\+/
autocmd InsertEnter * match WhitespaceErrors /\s\+\%#\@<!$\|[^\t]\@<=\t\+/
autocmd InsertLeave * match WhitespaceErrors /\s\+$\|[^\t]\@<=\t\+/
autocmd BufWinLeave * call clearmatches()


" SETTINGS
" --------------------------------------

set ignorecase                  " Ignore case when searching
set infercase                   " Base insert mode completion based on the typed text
set smartcase                   " Override ignorecase if search has upper case characters

set autoindent                  " Do dumb auto-indentation when no filetype is set
set autoread                    " Automatically reload when a file is changed outside of Vim
set backspace=indent,eol,start  " Allow backspacing over everything
set cmdheight=2                 " Use two screen lines for the command-line to avoid hit-enter prompts
set complete-=i                 " Disable scanning of included files for keyword completion
set cursorline                  " Highlight the screen line of the cursor
set directory=/var/tmp//        " Centrally store all swap files using full path names
set display+=lastline           " Show as much as possible of the last line in a window versus '@' lines
set expandtab                   " Convert tabs to spaces
set fileformats+=mac            " Always check for mac end-of-line formats
set foldlevel=99                " Default to no folds closed
set foldmethod=indent           " Lines with equal indent form a fold
set formatoptions+=1            " Prefer breaking before, not after, a one-letter word
set formatoptions+=n            " When formatting text with gq, recognize lists
set hidden                      " Allow the changing of buffers without saving
set history=1000                " Remember 1000 lines of command line history
set hlsearch                    " Highlight the last used search pattern
set incsearch                   " Enable incremental searching
set laststatus=2                " Always show the statusline
set lazyredraw                  " Do not redraw screen while executing macros
set linebreak                   " Wrap long lines at word boundaries
set list                        " Display unprintable characters
set matchtime=4                 " Blink matched brackets for 4/10ths of a second
set mouse=a                     " Enable mouse use for all modes
set nobackup                    " Do not automatically backup files
set nojoinspaces                " Do not insert 2 spaces after sentences when joining
set nomodeline                  " Do not read settings from modelines
set nostartofline               " Do not move cursor to SOL during jump commands
set nowrap                      " Do not automatically wrap long lines
set nrformats-=octal            " Consider numbers starting with a zero to still be decimal
set number                      " Precede each line with its line number
set numberwidth=1               " Use the minimal number of columns for line numbers
set relativenumber              " Show line numbers relative to the cursor's line
set ruler                       " Show the cursor position at all times
set scrolloff=2                 " Keep two lines above and below cursor when scrolling
set sessionoptions-=options     " Adjust behavior of mksession
set showcmd                     " Display incomplete commands
set showmatch                   " Highlight matching brackets
set sidescrolloff=3             " Keep three columns left and right of cursor when scrolling
set smarttab                    " Insert blanks according to shiftwidth when in front of a line
set ttimeout                    " Enable terminal timeout for key code sequences
set ttimeoutlen=100             " Time out on key codes after a tenth of a second
set viminfo^=!                  " Save and restore all-capital global variables
set virtualedit=block           " Cursor can be positioned anywhere when in blockwise Visual mode
set whichwrap+=h,l              " Allow cursor keys to line wrap
set wildmenu                    " Use enhanced command line completion
set wildmode=longest:list,full  " Set the wildchar completion mode
set winminheight=0              " Minimal height of a non-current window

" Delete comment character when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
	set formatoptions+=j
endif

" Use custom characters for window separators and whitespace
set fillchars=vert:\ ,fold:-
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
if &termencoding ==# 'utf-8' || &encoding ==# 'utf-8'
	let &fillchars = "vert:\u259a,fold:\u00b7"
	let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u00b7"
endif
autocmd InsertEnter * setlocal nolist
autocmd InsertLeave * setlocal list

" Set up default tab spacing
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Search upward for tags files
setglobal tags-=./tags tags^=./tags;


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

" Jump to the last known cursor position when opening files
" See :help restore-cursor
function! RestoreCursor()
	" don't restore the cursor position for VCS commit logs
	if line("'\"") > 0
	\  && line("'\"") <= line("$")
	\  && bufname('%') !~ '\.git\/COMMIT_EDITMSG\|svn-commit\.tmp'
		exe "normal! g`\""
	endif
endfunction
autocmd BufReadPost * call RestoreCursor()


" MAPPINGS & CUSTOM COMMANDS
" --------------------------------------

" Use spacebar as the leader key and prevent moving right after timeout
let mapleader = "\<Space>"
noremap <Space> <Nop>

" PLUGIN CONFIG: ctrl-p
nnoremap <silent> <Leader>b :CtrlPBuffer<CR>

" PLUGIN CONFIG: grepper
nnoremap <silent> <C-G> :Grepper -tool ag<CR>
nnoremap <silent> <Leader>* :Grepper -tool ag -cword -noprompt<CR>
nmap gG <plug>(GrepperOperator)
xmap gG <plug>(GrepperOperator)

" PLUGIN CONFIG: tagbar
nnoremap <silent> <Leader>t :TagbarToggle<CR>

" Exit terminal mode
tnoremap <Esc> <C-\><C-n>

" Run the make command silently
nnoremap <F5> :silent make! <Bar> redraw!<CR>

" Always use very magic regexes for search patterns
nnoremap / /\v
vnoremap / /\v

" Save a keystroke when entering command-line mode
noremap ; :

" Don't move linewise when long lines are wrapped
noremap j gj
noremap k gk

" Q formats paragraphs, instead of entering Ex mode
noremap Q gqip

" Assist with common typo when trying to quit
nnoremap q: q:iq<Esc>

" Assist with common mistake of not opening file with sudo
cnoremap w!! w !sudo tee % >/dev/null

" Move between windows using Ctrl + home row motion keys
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l

" Run the entire file through the indent filter
noremap <silent> <Leader>= :call Preserve("normal gg=G")<CR>

" Ensure that you can undo CTRL-U after inserting a line break
inoremap <C-U> <C-G>u<C-U>

" Change the CWD to where the current file is located
noremap <silent> <Leader>cd :cd %:p:h<CR>

" Quickly unload the current buffer
nnoremap <Leader>d :bd<CR>

" Remove last search pattern highlighting
nnoremap <silent> <Leader>h :nohlsearch<CR>

" Highlight lines longer than textwidth
" or column 79 if the textwidth option is not set
noremap <silent> <Leader>l m`:execute '/\%>' . (&tw ? &tw : 79) . 'v.\+'<CR>``

" Toggle paste mode
nnoremap <Leader>p :set invpaste paste?<CR>

" Copy visual area to the OS X clipboard
vnoremap <C-C> :w !pbcopy<CR><CR>gv

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

" Quickly save the current file
nnoremap <Leader>w :w<CR>

" Yank from the cursor to the end of the line
nmap Y y$


" FILETYPE SPECIFIC SETTINGS
" --------------------------------------

" preview the file without leaving the quickfix window
autocmd BufReadPost quickfix nnoremap <buffer> p <CR><C-w>w

" open the file then close the quickfix window
autocmd BufReadPost quickfix nnoremap <silent> <buffer> <M-CR> <CR>:cclose<CR>

" Use tabs for these file types
autocmd FileType fish setlocal noexpandtab
autocmd FileType gitconfig setlocal noexpandtab
autocmd FileType make setlocal noexpandtab
autocmd FileType sh setlocal noexpandtab
autocmd FileType tex setlocal noexpandtab
autocmd FileType vim setlocal noexpandtab

" Use a tab spacing of two spaces for these file types
autocmd FileType beancount setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType elixir setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType elm setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType haskell setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType nix setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 tabstop=2

" Use shellcheck for sh file types
autocmd FileType sh setlocal makeprg=shellcheck\ -f\ gcc\ %

" Automatically open the quickfix / location list window on errors
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
