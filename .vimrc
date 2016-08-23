"" Enables plugins if any
call pathogen#infect()

"" Rebind <Leader> key
"" I like to have it here becuase it is easier to reach than the default and
"" it is next to ``m`` and ``n`` which I use for navigating between buffers.
let mapleader = ","

"" Make Vim more useful
set nocompatible

"" Use UTF-8 without BOM
"set encoding=utf-8 nobomb

"" Show “invisible” characters
"set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
"set list

"" Always show status line
set laststatus=2

" Show the current mode
set showmode

"" Show the cursor position
set ruler

"" Set dark background
"set bg=light
set bg=dark

"" Show the (partial) command as it’s being typed
set showcmd

"" Start scrolling three lines before the horizontal window border
set scrolloff=3
set sidescrolloff=15
set sidescroll=1

"" Automatic reloading of .vimrc
"autocmd! bufwritepost .vimrc source %

"" Better copy & paste
"" When you want to paste large blocks of code into vim, press F2 before you
"" paste. At the bottom you should see ``-- INSERT (paste) --``.
set clipboard=unnamed
set pastetoggle=<F2>

"" Mouse and backspace
"set mouse=a

"" Copy to a system clipboard
vmap <Leader>y "+y
"set bs=2 " make backspace behave like normal again

"" Bind nohl, removes highlight of your last search
"" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>

"" Quick quit command
"noremap <Leader>e :quit<CR> " Quit current window
"noremap <Leader>E :qa!<CR> " Quit all windows

"" Bind Ctrl+<movement> keys to move around the windows,
"" instead of using Ctrl+w + <movement>
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h


"" Easier moving between tabs/buffers
"map <Leader>n <esc>:tabprevious<CR>
"map <Leader>m <esc>:tabnext<CR>

map <Leader>n <esc>:bprevious<CR>
map <Leader>m <esc>:bnext<CR>
map <Leader>l <esc>:buffers<CR>

"" Map sort function to a key
vnoremap <Leader>s :sort<CR>

"" Easier moving of code blocks
vnoremap < <gv " better indentation
vnoremap > >gv " better indentation

"" Color scheme
"" mkdir -p ~/.vim/colors && cd ~/.vim/colors
"" wget -O molokai.vim https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim
if &t_Co > 8 || has("gui_running")
    "" Show whitespace
    "" MUST be inserted BEFORE the colorscheme command
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
    au InsertLeave * match ExtraWhitespace /\s\+$/

    "" Show cursor line
    set cursorline

    "" Set color scheme
    "colorscheme molokai
    colorscheme solarized
endif


"" Enable syntax highlighting
"" You need to reload this file for the change to apply
filetype off
filetype plugin indent on
syntax on

"" Showing line numbers and length
"set number " show line numbers
"set tw=79 " width of document (used by gd)
"set nowrap " don't automatically wrap on load
"set fo-=t " don't automatically wrap text when typing
set colorcolumn=80
"highlight ColorColumn ctermbg=233

"" Useful settings
set history=700
set undolevels=700

"" Don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

"" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Disable backup and swap files - they trigger too many events
set nobackup
set nowritebackup
set noswapfile

"" Turn on the WiLd menu
set wildmenu

"" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*

"" Show matching brackets when text indicator is over them
set showmatch
"" How many tenths of a second to blink when matching brackets
set mat=2

" Functions ==================================================================
"" Better navigating through omnicomplete option list
"" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
"" set completeopt=longest,menuone
function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
return a:action
endfunction

inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>

"imap <C-Space> <C-x><C-o>
"imap <C-@> <C-Space>

"" If you prefer the Omni-Completion tip window to close when a selection is
"" made, these lines close it on movement in insert mode or when leaving insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"" Strip trailing whitespace (,ss)
function! StripWhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction

noremap <leader>ss :call StripWhitespace()<CR>

"" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

"" Plugins ====================================================================
map <Leader>e :NERDTreeToggle<CR>

let python_highlight_all = 1

let g:airline_left_alt_sep = ''
let g:airline_left_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_right_sep = ''

let NERDTreeIgnore = ['\.pyc$']

autocmd FileType python setlocal completeopt-=preview
"let g:jedi#show_call_signatures = 0
let g:jedi#usages_command = "<leader>u"
let g:jedi#use_tabs_not_buffers = 0
"let g:jedi#popup_on_dot = 0
