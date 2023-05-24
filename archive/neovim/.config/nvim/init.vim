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
let g:airline_highlighting_cache = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.whitespace = 'Ξ'

Plug 'pearofducks/ansible-vim'
let g:ansible_extra_keywords_highlight = 1
let g:ansible_attribute_highlight = 'n'

Plug 'google/vim-maktaba'
Plug 'bazelbuild/vim-bazel'

" Plug 'airblade/vim-gitgutter'
" let g:gitgutter_override_sign_column_highlight = 0

Plug 'mhinz/vim-grepper'
let g:grepper = {
	\ 'tools':     ['rg', 'git', 'grep'],
	\ 'open':      1,
	\ 'switch':    1,
	\ 'jump':      0,
	\ 'next_tool': '<C-G>',
	\ 'simple_prompt': 1,
	\ }

if executable("rg")
	set grepprg=rg\ --vimgrep\ --no-heading
	set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

Plug 'junegunn/limelight.vim'
let g:limelight_priority = -1

function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

Plug 'mhinz/vim-signify'
let g:signify_vcs_list = [ 'git' ]

Plug 'majutsushi/tagbar'
let g:tagbar_autoclose = 1

Plug 'hashivim/vim-terraform'
let g:terraform_align = 1
let g:terraform_fmt_on_save = 1

Plug 'janko-m/vim-test'
let test#strategy = 'neovim'

Plug 'junegunn/vim-easy-align'
Plug 'Lokaltog/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-endwise'
Plug 'terryma/vim-expand-region'
Plug 'justinmk/vim-dirvish'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'rhysd/git-messenger.vim'
Plug 'fatih/vim-go'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'mtth/scratch.vim'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
Plug 'mbbill/undotree'
Plug 'tpope/vim-unimpaired'
Plug 'maxbrunsfeld/vim-yankstack'

" File Types
Plug 'nathangrigg/vim-beancount'
Plug 'elixir-lang/vim-elixir'
Plug 'vmchale/dhall-vim'
Plug 'dag/vim-fish'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug '~/.config/nvim/vendor/nginx'
Plug 'LnL7/vim-nix'
Plug 'rodjek/vim-puppet'
Plug 'rust-lang/rust.vim'
let g:rustfmt_autosave = 1
Plug 'cespare/vim-toml'

" Color Schemes
Plug 'morhetz/gruvbox'
let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = 'hard'

call plug#end()

call yankstack#setup()


" COLORS AND FONTS
" --------------------------------------

colorscheme gruvbox
set background=dark
set termguicolors

" Highlight directories different from files in listings
highlight Directory ctermfg=Blue

" Highlight trailing whitespace characters and tabs not used for indentation
highlight WhitespaceErrors ctermbg=red guibg=red
match WhitespaceErrors /\s\+$/
augroup errors
	autocmd!
	autocmd BufWinEnter * match WhitespaceErrors /\s\+$\|[^\t]\@<=\t\+/
	autocmd InsertEnter * match WhitespaceErrors /\s\+\%#\@<!$\|[^\t]\@<=\t\+/
	autocmd InsertLeave * match WhitespaceErrors /\s\+$\|[^\t]\@<=\t\+/
	autocmd BufWinLeave * call clearmatches()
augroup end


" SETTINGS
" --------------------------------------

set ignorecase                  " Ignore case when searching
set infercase                   " Base insert mode completion based on the typed text
set smartcase                   " Override ignorecase if search has upper case characters

set breakindent                 " Preserve horizontal blocks of text when wrapping
set breakindentopt=shift:-2     " Add negative indent to the showbreak value when wrapping
set cmdheight=2                 " Use two screen lines for the command-line to avoid hit-enter prompts
set colorcolumn=+1              " Highlight the column after the current textwidth
set cursorcolumn                " Highlight the screen column of the cursor
set cursorline                  " Highlight the screen line of the cursor
set directory=/var/tmp//        " Centrally store all swap files using full path names
set expandtab                   " Convert tabs to spaces
set fileformats+=mac            " Always check for mac end-of-line formats
set foldlevel=99                " Default to no folds closed
set foldmethod=indent           " Lines with equal indent form a fold
set formatoptions+=1            " Prefer breaking before, not after, a one-letter word
set formatoptions+=n            " When formatting text with gq, recognize lists
set hidden                      " Allow the changing of buffers without saving
set inccommand=nosplit          " Show command effects incrementally
set lazyredraw                  " Do not redraw screen while executing macros
set linebreak                   " Wrap long lines at word boundaries
set list                        " Display unprintable characters
set matchtime=4                 " Blink matched brackets for 4/10ths of a second
set nobackup                    " Do not automatically backup files
set nojoinspaces                " Do not insert 2 spaces after sentences when joining
set nomodeline                  " Do not read settings from modelines
set nostartofline               " Do not move cursor to SOL during jump commands
set nowrap                      " Do not automatically wrap long lines
set number                      " Precede each line with its line number
set numberwidth=1               " Use the minimal number of columns for line numbers
set relativenumber              " Show line numbers relative to the cursor's line
set scrolloff=2                 " Keep two lines above and below cursor when scrolling
set sessionoptions-=options     " Adjust behavior of mksession
set showbreak=↪\                " String to put at the start of lines that have been wrapped
set showmatch                   " Highlight matching brackets
set sidescrolloff=3             " Keep three columns left and right of cursor when scrolling
set ttimeout                    " Enable terminal timeout for key code sequences
set ttimeoutlen=100             " Time out on key codes after a tenth of a second
set undofile                    " Preserve undo history for buffers on disk
set updatetime=100              " How long to wait after nothing is typed before updates
set virtualedit=block           " Cursor can be positioned anywhere when in blockwise Visual mode
set whichwrap+=h,l              " Allow cursor keys to line wrap
set wildmode=longest:full,full  " Set the wildchar completion mode
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
augroup list
	autocmd!
	autocmd InsertEnter * setlocal nolist
	autocmd InsertLeave * setlocal list
augroup end

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
augroup cursor
	autocmd!
	autocmd BufReadPost * call RestoreCursor()
augroup end


" MAPPINGS & CUSTOM COMMANDS
" --------------------------------------

" Use spacebar as the leader key and prevent moving right after timeout
let mapleader = "\<Space>"
noremap <Space> <Nop>

" PLUGIN CONFIG: easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" PLUGIN CONFIG: expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" PLUGIN CONFIG: fugitive
command! Gstaged :Git! diff --staged
nnoremap <silent> <Leader>gc :Gcommit<CR>
nnoremap <silent> <Leader>gd :Gdiff<CR>
nnoremap <silent> <Leader>ge :Gedit<CR>
nnoremap <silent> <Leader>gp :Git pp<CR>
nnoremap <silent> <Leader>gs :Gstatus<CR>
nnoremap <silent> <Leader>gw :Gwrite<CR><CR>
nnoremap <silent> <Leader>gg :Gstaged<CR><CR>

" PLUGIN CONFIG: fzf
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>gl :Commits<CR>
nnoremap <silent> <Leader>gs :Gfiles?<CR>

" PLUGIN CONFIG: git-messenger
nmap <Leader>gb <Plug>(git-messenger)

" PLUGIN CONFIG: grepper
nnoremap <silent> <C-G> :Grepper -tool rg<CR>
nnoremap <silent> <Leader>* :Grepper -tool rg -cword -noprompt<CR>
nmap gG <plug>(GrepperOperator)
xmap gG <plug>(GrepperOperator)

" PLUGIN CONFIG: limelight
nnoremap <silent> <Leader>l :Limelight!!<CR>

" PLUGIN CONFIG: tagbar
nnoremap <silent> <Leader>t :TagbarToggle<CR>

" Run the make command silently
nnoremap <F5> :silent make! <Bar> redraw!<CR>

" Always use very magic regexes for search patterns
nnoremap / /\v
vnoremap / /\v

" Save a keystroke when entering command-line mode
noremap ; :

" Don't move linewise when long lines are wrapped; but, do so when preceded by
" a count; also add to jumplist if the count is larger than 5
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

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

" Toggle paste mode
nnoremap <Leader>p :set invpaste paste?<CR>

" Copy visual area to the system clipboard
vnoremap <C-C> "+ygv

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

augroup lint
	autocmd!
	" Set custom make commands for various file types
	autocmd FileType bzl setlocal makeprg=buildifier\ %
	autocmd FileType sh setlocal makeprg=shellcheck\ -f\ gcc\ %
	autocmd FileType yaml setlocal makeprg=yamllint\ -f\ parsable\ %
augroup end

augroup quickfix
	autocmd!
	" preview the file without leaving the quickfix window
	autocmd BufReadPost quickfix nnoremap <buffer> p <CR><C-w>w

	" open the file then close the quickfix window
	autocmd BufReadPost quickfix nnoremap <silent> <buffer> <M-CR> <CR>:cclose<CR>

	" Automatically open the quickfix / location list window on errors
	autocmd QuickFixCmdPost [^l]* nested cwindow
	autocmd QuickFixCmdPost    l* nested lwindow
augroup end

augroup terraform
	autocmd!
	" treat HCL files as Terraform
	autocmd BufNewFile,BufRead *.hcl setlocal filetype=terraform
	autocmd BufWritePre,FileWritePre *.hcl :TerraformFmt
augroup end

augroup whitespace
	autocmd!
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
augroup end
