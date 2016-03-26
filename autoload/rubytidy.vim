"=============================================================================
" File: vim-rubytidy.vim
" Author: yasutake.kiyoshi
" Created: 2016-03-26
"=============================================================================

scriptencoding utf-8

"if !exists('g:loaded_rubytidy')
  "finish
"endif
"let g:loaded_rubytidy = 1

let s:save_cpo = &cpo
set cpo&vim

function! rubytidy#Align() range
  normal `<
  let begin = line(".")
  normal `>
  let end   = line(".")
  " echo a:firstline
  " echo a:lastline
  " let lines = getline(a:firstline, a:lastline)
  let lines = range(begin, end)

  let max_field_l = 0
  let new_list = []
  for i in lines
    let line = getline(i)
    let pairs = matchlist(line, '^\(\s*\)\(\w\+:\)\s*\(.*\)$')
    if len(pairs) > 1
      let pairs[4] = i
      " echo printf("%d matched. %s %s", pairs[4], pairs[2], pairs[3])
      if len(pairs[2]) > max_field_l
        let max_field_l = len(pairs[2])
      endif
      call add(new_list, pairs)
    else
      " echo "Not matched."
    endif
  endfor

  let format = "%-" . max_field_l . "s %s"
  for pairs in new_list
    call setline(pairs[4], printf(format, pairs[2], pairs[3]))
  endfor
  normal gg=G
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
