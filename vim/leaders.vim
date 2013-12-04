" Strip all trailing whitespace in a file (,W)
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" Reselect text that was just pasted (,v)
nnoremap <leader>v V`]
" Open .vimrc in vsplit (,ev)
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
" Clear search
nnoremap <leader><space> :noh<cr>

nnoremap HH :silent !afplay ~/.vim/VicotryFanfare.mp3 <CR><C-l>

" Replace current selected text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" vsplit the pane
nnoremap <leader>v :vsplit<cr>
