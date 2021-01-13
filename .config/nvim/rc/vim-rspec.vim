nnoremap <Leader>rr :call RunCurrentSpecFile()<CR>
nnoremap <Leader>rs :call RunNearestSpec()<CR>
nnoremap <Leader>rl :call RunLastSpec()<CR>
nnoremap <Leader>ra :call RunAllSpecs()<CR>

let g:rspec_command = "Dispatch dip rspec {spec}"
