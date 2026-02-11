{ ... }:

{
  home.file.".ideavimrc".text = ''
    set nocompatible
    set surround
    filetype off

    filetype plugin indent on

    nnoremap <space>] :action GotoImplementation<cr>
    nnoremap <space>[ :action GotoSuperMethod<cr>
    nnoremap <space>u :action FindUsages<cr>
    nnoremap <space>gt :action GotoTest<cr>
    nnoremap <space>k :action HighlightUsagesInFile<cr>

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
    set secure
    set splitbelow
    set splitright
    set clipboard=unnamed

    set listchars=tab:→\ ,trail:×
    set list

    " Clear search on Enter
    nnoremap <CR> :nohlsearch<cr>

    " Make . in visual mode work as in normal mode
    xnoremap . :norm.<CR>

    " Reselect visual block after indent/outdent
    vnoremap < <gv
    vnoremap > >gv

    " Beginning and end of line
    nnoremap H ^
    nnoremap L $
  '';
}
