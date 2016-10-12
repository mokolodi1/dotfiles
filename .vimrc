set nocompatible
filetype off

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load Plugins via https://github.com/gmarik/Vundle.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/Dropbox/vim/plugins/Vundle.vim
call vundle#begin('~/Dropbox/vim/plugins')

Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-commentary'

Plugin 'altercation/vim-colors-solarized'
Plugin 'ctrlpvim/ctrlp.vim'
" Plugin 'ervandew/supertab'
" Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
" Plugin 'hynek/vim-python-pep8-indent'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'

Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
" Plugin 'kien/ctrlp.vim'
" Plugin 'itchyny/lightline.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Plugin 'terryma/vim-expand-region'
" Plugin 'vim-scripts/gitignore'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-markdown'
Plugin 'pangloss/vim-javascript'
" Plugin 'ingydotnet/yaml-vim'
" Plugin 'Chiel92/vim-autoformat'
" Plugin 'junegunn/goyo.vim'
" Plugin 'junegunn/rainbow_parentheses.vim'
" Plugin 'junegunn/limelight.vim'

call vundle#end()            " required
filetype plugin indent on    " required

" Automaticaly reload .vimrc when saved
autocmd! bufwritepost .vimrc source %

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8

set expandtab       " tabs are spaces
set shiftwidth=4    " number of space to shift indent with >> and <<
set tabstop=4       " number of visual spaces per TAB

set textwidth=100   " length to fold
" set smarttab        " be smart about tabs...
set smartcase

set visualbell      " turn off bell

" Disable backup and swap files
" set nobackup
set nowritebackup
set noswapfile
set ignorecase
set hidden

" Automatically reload file if changed outside of vim
set autoread

" Sets how many lines of history VIM has to remember
set history=100
set undolevels=100 "maximum number of changes that can be undone
" set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" Set to auto read when a file is changed from the outside
" set autowrite

" Make system clipboard work as expected
set clipboard=unnamed

" Ignore binary and other files when file name matching
set wildmode=list:longest
set wildmenu
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*   " for Linux/MacOSX
set wildignore+=*/env/**,*.pyc  " Python 
set wildignore+=*/node_modules/** " nodejs libraries

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Appearance
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on               " show syntax coloring
colorscheme solarized   " low strain theme
set background=dark     " use dark background
set antialias           " use antalias fonts if exists
let python_highlight_all=1

let g:airline_powerline_fonts=1
" let g:airline#extensions#tabline#enabled = 1

set nostartofline       " don't go to start of line when moving rows
set nonumber            " don't show line numbers
set showcmd             " show command in bottom bar
set cursorline          " highlight current line

set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]
set incsearch           " search as characters are entered
set hlsearch            " highlight matches

" Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[


" set foldenable          " enable folding
" set foldmethod=indent   " fold based on indent level, see :help foldmethod
" set foldlevel=99
" let g:SimpylFold_docstring_preview=1 " Display the docstrings for folded code


" nnoremap <silent> <Space> @=(foldlevel('.')?'zA':"\<Space>")<CR>
" vnoremap <Space> zf
" nnoremap <space> za     " Enable folding with the spacebar

" Goyo
" let g:limelight_conceal_ctermfg = 245  " Solarized Base1
" let g:limelight_conceal_guifg = '#8a8a8a'  " Solarized Base1
" let g:limelight_conceal_ctermfg = 254  " Solarized Base2
" let g:limelight_conceal_guifg = '#eee8d5'  " Solarized Base2
"
" function! s:goyo_enter()
"   silent !tmux set status off
"   set noshowmode
"   set noshowcmd
"   set scrolloff=999
"   " Limelight
" endfunction

" function! s:goyo_leave()
"   silent !tmux set status on
"   set showmode
"   set showcmd
"   set scrolloff=5
"   " Limelight!
" endfunction

" autocmd! User GoyoEnter nested call <SID>goyo_enter()
" autocmd! User GoyoLeave nested call <SID>goyo_leave()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Bindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","
noremap \ ,

nnoremap Q <nop> " Get rid of ex mode

" v selects and expands regions
" vmap v <Plug>(expand_region_expand)
" vmap <C-v> <Plug>(expand_region_shrink)

" spelling dropdown me
nnoremap <leader>s ea<C-X><C-S>

" Make a simple "search" text object i.e. ys yanks search, cs changes search
" http://vim.wikia.com/wiki/Copy_or_change_search_hit
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
    omap s :normal vs<CR>

" Jump to the end of pasted text
" vnoremap <silent> y y`]
" vnoremap <silent> p p`]
" nnoremap <silent> p p`]

" Delete then paste from default buffer when in visual select mode
xnoremap p "_dP

" nerdtree
map <silent> <C-t> :NERDTreeToggle<CR>

" enter after autocomplete just selects word instead of inserting a CR
" let g:SuperTabCrMapping=1

" select last paste in visual mode
" nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" stop that stupid window from popping up
" map q: :q

" Make ctrlp run faster by using git index
" let g:ctrlp_use_caching = 0
" if executable('ag')
"     set grepprg=ag\ --nogroup\ --nocolor

"     let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" else
"   let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
"   let g:ctrlp_prompt_mappings = {
"     \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
"     \ }
" endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Customization
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ctrlp 
nnoremap <leader>f :CtrlPMixed<CR> " Search from current working directory
nnoremap <leader>b :CtrlPBuffer<CR> " Buffer list

" syntastic
let g:syntastic_mode_map={ 'mode': 'active',
                     \ 'active_filetypes': ['python', 'javascript', 'html'],
                     \ 'passive_filetypes': [''] }

let g:syntastic_html_tidy_ignore_errors = [
    \ '<link> proprietary attribute "integrity"',
    \ '<link> proprietary attribute "crossorigin"', 
    \ '<script> proprietary attribute "integrity"',
    \ '<script> proprietary attribute "crossorigin"' ]


set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


let g:syntastic_python_checkers=['flake8']
" let g:syntastic_python_checker_args="--max-line-length=100"
" let g:syntastic_python_checker_args='--ignore=E501,C901'
let g:syntastic_python_flake8_args = "--max-line-length=100"
" let g:syntastic_python_flake8_args = "--ignore=E501 --max-complexity 17"
" let g:syntastic_python_checker_args="--ignore=E501"
" let g:syntastic_python_flake8_args = "--ignore=E501"
" let g:syntastic_python_pylint_post_args="--max-line-length=120"

let g:syntastic_javascript_checkers = ['eslint']

" YouCompleteMe
" let g:ycm_autoclose_preview_window_after_completion=1
" map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Color whitespace so its obvious
" au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Setup tabs for various file types
" au BufNewFile,BufRead *.py set tabstop=4
" au BufNewFile,BufRead *.py set softtabstop=4
" au BufNewFile,BufRead *.py set shiftwidth=4
" au BufNewFile,BufRead *.py set textwidth=79
" au BufNewFile,BufRead *.py set expandtab
" au BufNewFile,BufRead *.py set autoindent
" au BufNewFile,BufRead *.py set fileformat=unix


" au BufNewFile,BufRead *.py
"     \ set tabstop=4
"     \ set softtabstop=4
"     \ set shiftwidth=4
"     \ set textwidth=79
"     \ set expandtab
"     \ set autoindent
"     \ set fileformat=unix

" au BufNewFile,BufRead *.js, *.html, *.css
"     \ set tabstop=2
"     \ set softtabstop=2
"     \ set shiftwidth=2

au BufNewFile,BufRead *.cwl set filetype=yaml

autocmd Filetype python setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=100 expandtab autoindent fileformat=unix
autocmd Filetype html setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype css setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
" autocmd Filetype javascript setlocal tabstop=2 shiftwidth=2 expandtab
" autocmd Filetype css setlocal tabstop=2 shiftwidth=2 expandtab


" Turn on spell checking for markdown files
autocmd BufRead,BufNewFile *.markdown setlocal spell
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.txt setlocal spell
autocmd BufRead,BufNewFile *.html setlocal spell
autocmd BufRead,BufNewFile *.py setlocal spell

" au BufNewFile,BufReadPost *.py set shiftwidth=4 softtabstop=4 expandtab

" vp doesn't replace paste buffer
" must be at end of .vimrc
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()
