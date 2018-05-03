set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'bling/vim-airline.git'
Plugin 'cespare/vim-toml'
Plugin 'elixir-lang/vim-elixir'
Plugin 'elmcast/elm-vim'
Plugin 'fatih/vim-go'
Plugin 'groenewege/vim-less'
Plugin 'guns/vim-clojure-static'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'isRuslan/vim-es6'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'othree/html5.vim'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-fugitive.git'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-sensible.git'
Plugin 'vim-ruby/vim-ruby'
Plugin 'vim-scripts/paredit.vim'
Plugin 'wting/rust.vim'
Plugin 'rhysd/vim-rustpeg'
Plugin 'terryma/vim-multiple-cursors'

call vundle#end()
filetype plugin indent on

let mapleader=","
noremap \ ,

set rnu
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set hlsearch
set noswapfile
set nobackup
set hidden
set ignorecase
set smartcase
set smarttab
set incsearch
set visualbell
set noerrorbells
set exrc " enable per-directory .vimrc files
set secure " disable unsafe commands in local .vimrc files
" default splits to right and bottom
set splitbelow
set splitright
set clipboard=unnamed

set listchars=tab:→\ ,trail:×
set list

let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 0

syntax on

set t_Co=256q
colorscheme mustang
highlight clear SignColumn
highlight VertSplit    ctermbg=236
highlight ColorColumn  ctermbg=237
highlight LineNr       ctermbg=236 ctermfg=240
highlight CursorLineNr ctermbg=236 ctermfg=240
highlight CursorLine   ctermbg=236
highlight StatusLineNC ctermbg=238 ctermfg=0
highlight StatusLine   ctermbg=240 ctermfg=12
highlight IncSearch    ctermbg=3   ctermfg=1
highlight Search       ctermbg=1   ctermfg=3
highlight Visual       ctermbg=3   ctermfg=0
highlight Pmenu        ctermbg=240 ctermfg=12
highlight PmenuSel     ctermbg=3   ctermfg=1
highlight SpellBad     ctermbg=0   ctermfg=1

hi SpecialKey ctermfg=59 ctermbg=235 cterm=bold
hi Search guifg=NONE guibg=NONE gui=underline ctermfg=NONE ctermbg=NONE cterm=underline

" highlight current line
set cursorline
hi CursorLine term=none cterm=none

" mouse clicks
set mouse=a
set ttymouse=xterm

" Clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>
"
" " Make . in visual mode work as in normal mode
xnoremap . :norm.<CR>

"CtrlP stuff
nnoremap <leader>t :CtrlP<CR>

" reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Begenning and end of line
nnoremap H ^
nnoremap L $

" safe paste
map <Leader>p :set invpaste<CR>i

" disable paste when leaving insert mode
au InsertLeave * set nopaste

" Allow macros over visual range
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

let g:ctrlp_working_path_mode = 'ra'
let g:path_to_matcher = "matcher"
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files . -co --exclude-standard']
let g:ctrlp_match_func = { 'match': 'GoodMatch' }

function! GoodMatch(items, str, limit, mmode, ispath, crfile, regex)
  " Create a cache file if not yet exists
  let cachefile = ctrlp#utils#cachedir().'/matcher.cache'
  if !( filereadable(cachefile) && a:items == readfile(cachefile) )
    call writefile(a:items, cachefile)
  endif
  if !filereadable(cachefile)
    return []
  endif

  " a:mmode is currently ignored. In the future, we should probably do
  " something about that. the matcher behaves like "full-line".
  let cmd = g:path_to_matcher.' --limit '.a:limit.' --manifest '.cachefile.' '
  if !( exists('g:ctrlp_dotfiles') && g:ctrlp_dotfiles )
    let cmd = cmd.'--no-dotfiles '
  endif
  let cmd = cmd.a:str

  return split(system(cmd), "\n")
endfunction

nmap <Leader>a yiw:Ag --ignore '*.a' <C-r>"<cr>

autocmd BufWritePre * :%s/\s\+$//e
" resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

map <Leader>1 :tabn 1<CR>
map <Leader>2 :tabn 2<CR>
map <Leader>3 :tabn 3<CR>
map <Leader>4 :tabn 4<CR>
map <Leader>5 :tabn 5<CR>
map <Leader>6 :tabn 6<CR>
map <Leader>7 :tabn 7<CR>
map <Leader>8 :tabn 8<CR>
map <Leader>9 :tabn 9<CR>
map <Leader>0 :tab split<CR>

" auto complete
function! SuperTab()
    if (strpart(getline('.'),col('.')-2,1)=~'^\W\?$')
        return "\<Tab>"
    else
        return "\<C-P>"
    endif
endfunction
imap <Tab> <C-R>=SuperTab()<CR>

" Ruby
autocmd BufNewFile,BufRead *.mrb set filetype=ruby


" Go
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=2 shiftwidth=2 softtabstop=2

autocmd FileType go nmap <Leader>s <Plug>(go-implements)
autocmd FileType go nmap <Leader>i <Plug>(go-info)

autocmd FileType go nmap <Leader>gd <Plug>(go-doc)
autocmd FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
autocmd FileType go nmap <Leader>gb <Plug>(go-doc-browser)

autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>b <Plug>(go-build)
" autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>c <Plug>(go-coverage)

autocmd FileType go nmap <Leader>ds <Plug>(go-def-split)
autocmd FileType go nmap <Leader>dv <Plug>(go-def-vertical)

" JS
let g:syntastic_javascript_checkers = ['eslint']

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" NERDTree
nmap <leader>n :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeQuitOnOpen=1
let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg']

" Clojure

autocmd FileType clojure setlocal lispwords+=go-loop

autocmd FileType clojure :RainbowParenthesesToggle
autocmd FileType clojure :RainbowParenthesesLoadRound
autocmd FileType clojure :RainbowParenthesesLoadSquare
autocmd FileType clojure :RainbowParenthesesLoadBraces
let g:rbpt_colorpairs = [
  \ ['brown',       'RoyalBlue3'],
  \ ['Darkblue',    'SeaGreen3'],
  \ ['darkgray',    'DarkOrchid3'],
  \ ['darkgreen',   'firebrick3'],
  \ ['darkcyan',    'RoyalBlue3'],
  \ ['darkred',     'SeaGreen3'],
  \ ['brown',       'firebrick3'],
  \ ['gray',        'RoyalBlue3'],
  \ ['black',       'SeaGreen3'],
  \ ['darkmagenta', 'DarkOrchid3'],
  \ ['Darkblue',    'firebrick3'],
  \ ['darkgreen',   'RoyalBlue3'],
  \ ['darkcyan',    'SeaGreen3'],
  \ ['darkred',     'DarkOrchid3'],
  \ ['red',         'firebrick3'],
  \ ]

" Markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Live it

noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

inoremap kj <Esc>
