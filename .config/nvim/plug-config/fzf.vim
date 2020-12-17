" update search results in FZF when query string changes
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

" search window layout
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8}}
let $FZF_DEFAULT_OPTS='--reverse'

" start in-project search on Ctrl+Spacebar
nnoremap <leader><Space> :Rg <CR>

" start searching files in the project on Ctrl+p
nnoremap <C-p> :Files <CR>

