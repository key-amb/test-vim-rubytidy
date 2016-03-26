"=============================================================================
" File: vim-rubytidy.vim
" Author: yasutake.kiyoshi
" Created: 2016-03-26
"=============================================================================

scriptencoding utf-8

if !exists('g:loaded_rubytidy')
  finish
endif
let g:loaded_rubytidy = 1

let s:save_cpo = &cpo
set cpo&vim

function! rubytidy#Align() range
  let pos = getpos(".")

  let topp   = a:firstline
  let bottom = a:lastline
  if topp == bottom
    let topp   = 0
    let bottom = line("$")
  endif
  let lines = range(topp, bottom)

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
      continue
    endif

    let pairs = matchlist(line, "^\\(\\s*\\)\\([\'\":a-zA-Z_]\\+\\)\\s*=>\\s*\\(.*\\)$")
    if len(pairs) > 1
      let pairs[4] = i
      let pairs[3] = '=> ' . pairs[3]
      " echo printf("%d matched. %s %s", pairs[4], pairs[2], pairs[3])
      if len(pairs[2]) > max_field_l
        let max_field_l = len(pairs[2])
      endif
      call add(new_list, pairs)
      continue
    endif
  endfor

  let format = "%-" . max_field_l . "s %s"
  for pairs in new_list
    call setline(pairs[4], printf(format, pairs[2], pairs[3]))
  endfor
  normal gg=G

  call setpos(".", pos)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
