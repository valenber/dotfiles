" replace netrw with ranger
let g:rnvimr_ex_enable = 1

" don't draw surrounding border
let g:rnvimr_draw_border = 0

" close after file is selected
let g:rnvimr_pick_enable = 1

" open ranger with lead+r
nmap <leader>r :RnvimrToggle<CR>

" close buffers of the files deleted via ranger
let g:rnvimr_bw_enable = 1

" text highlighting
highlight NormalFloat ctermfg=0 ctermbg=16 guibg=#2b3038
