"=============================================================================
" File: vim-rubytidy.vim
" Author: yasutake.kiyoshi
" Created: 2016-03-26
"=============================================================================

scriptencoding utf-8

"if exists('g:loaded_rubytidy')
    "finish
"endif
"let g:loaded_rubytidy = 1

let s:save_cpo = &cpo
set cpo&vim

command! -range RubytidyAlign call rubytidy#Align()

let &cpo = s:save_cpo
unlet s:save_cpo
