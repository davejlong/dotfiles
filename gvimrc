if has("gui_gtk2") " Linux
  set guifont=Inconsolata\ 12
elseif has("gui_win32") " Windows
  set guifont=Inconsolata:h16
elseif has("gui_macvim") " Mac
  set guifont=Inconsolata:h14
endif

set background=light

" No toolbar
set guioptions-=T

" Use console dialogs
set guioptions+=c

" Local config
if filereadable($HOME . "/.gvimrc.local")
  source ~/.gvimrc.local
endif
