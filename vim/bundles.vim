"NeoBundle Scripts-----------------------------
if has('vim_starting')
set nocompatible               " Be iMproved

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

let g:neobundle#install_process_timeout = 1500

" My Bundles here:
NeoBundle 'danro/rename.vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'thoughtbot/vim-rspec'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-vinegar'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-scripts/ctags.vim'
NeoBundle 'vim-scripts/tComment'
NeoBundle 'bling/vim-airline'
" NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'valloric/YouCompleteMe', {
\   'build': {
\     'mac': './install.py --clang-completer --tern-completer',
\     'unix': './install.py --clang-completer --tern-completer'
\   }
\ }
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'rizzatti/dash.vim'
NeoBundle 'endel/vim-github-colorscheme'
NeoBundle 'arecarn/crunch'
NeoBundle 'tpope/vim-rails'
NeoBundle 'burnettk/vim-angular'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'eraserhd/vim-ios'
NeoBundle 'msanders/cocoa.vim'
NeoBundle 'toyamarinyon/vim-swift'
NeoBundle 'terryma/vim-expand-region'
NeoBundle 'elixir-lang/vim-elixir'
NeoBundle 'ekalinin/Dockerfile.vim'
NeoBundle 'cyphactor/vim-open-alternate'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'Quramy/tsuquyomi'
NeoBundle 'Shougo/vimproc.vim', {
\   'build' : {
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\   }
\ }
NeoBundle 'hashivim/vim-terraform'

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

if filereadable(expand("~/.vimrc.bundles.local"))
  source ~/.vimrc.bundles.local
endif

filetype on
