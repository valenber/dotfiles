" escape key alternative
inoremap jk <ESC>
vnoremap jk <ESC>

" INPUT HELPERS
" close curly bracket and indent inside
inoremap ,{ {}<Left><CR><Esc><S-O>
" arrow function
inoremap ,( () => {}<Left><CR><Esc><S-O>
" async arrow function
inoremap ,a( async () => {}<Left><CR><Esc><S-O>
" console.log
inoremap ,l console.log()<Left>
" data-test-id=""
inoremap ,ti data-test-id=""<Left>
" templat literal inserts
inoremap ,$ ${}<Left>
" add test.todo
inoremap ,td test.todo('')<Left><Left>
" test.todo => test
map ,do  0f.d2wf)i, ,(

" restarting coc to fix stuck errors
inoremap ,cr :CocRestart<CR><CR>
nnoremap ,cr :CocRestart<CR><CR>

" replace all
nnoremap S :%s//g<Left><Left>

" Navigating buffers
nnoremap gb :ls<CR>:buffer<Space>
nnoremap <C-a> :bprevious<CR>
nnoremap <C-s> :bnext<CR>
" don't force me to save buffers when switching between them
set hidden

" move selected fragment
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
