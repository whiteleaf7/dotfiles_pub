let g:deoplete#enable_at_startup=1
call deoplete#custom#option({
      \ 'auto_complete_delay': 0,
      \ 'refresh_always': v:true,
      \ 'smart_case': v:true,
      \ 'max_list': 200,
      \ 'on_insert_enter': v:true,
      \ 'on_text_changed_i': v:true,
      \ 'ignore_case': v:true,
      \ 'skip_chars': ['(', ')', '[', ']', '{', '}'],
      \ })

" call deoplete#custom#option({
"       \ 'auto_complete_delay': 350,
"       \ 'refresh_always': v:true,
"       \ 'smart_case': v:true,
"       \ 'max_list': 200,
"       \ 'on_insert_enter': v:true,
"       \ 'on_text_changed_i': v:false,
"       \ 'skip_chars': ['(', ')', '[', ']', '{', '}'],
"       \ })


      " \ 'auto_refresh_delay': 500,
