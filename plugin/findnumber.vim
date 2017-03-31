" vim: set ts=2 sw=2 sts=2 tw=78 et :
"
if exists("g:loaded_findnumber_plugin")
  finish
endif

let g:loaded_findnumber_plugin = 1

command! -range=% -nargs=1 FindSmallerHex call FindSmallerHex(<line1>,<line2>,<f-args>) | normal n

" credit for this function goes to
" http://vim.wikia.com/wiki/Copy_search_matches
" Return list of matches for given pattern in given range.
" This only works for matches within a single line.
" Empty hits are skipped so search for '\d*\ze,' is not stuck in '123,456'.
" If omit match() 'count' argument, pattern '^.' matches every character.
" Using count=1 causes text before the 'start' argument to be considered.
function GetMatches(line1, line2, pattern)
  let hits = []
  for line in range(a:line1, a:line2)
    let text = getline(line)
    let from = 0
    while 1
      let next = match(text, a:pattern, from, 1)
      if next < 0
        break
      endif
      let from = matchend(text, a:pattern, from, 1)
      if from > next
        call add(hits, strpart(text, next, from - next))
      else
        let char = matchstr(text, '.', next)
        if empty(char)
          break
        endif
        let from = next + strlen(char)
      endif
    endwhile
  endfor
  return hits
endfunction

function! FindSmallerHex(line1, line2, number)
  let hits = GetMatches(a:line1, a:line2, '0x\x\+')
  let sorted = sort(hits,'N')
  let smaller = 0
  for cur in sorted
    if str2nr(cur,16) > str2nr(a:number,16)
      break
    endif
    let smaller = cur
  endfor
  call cursor(a:line1,1)
  let @/ = smaller
endfunction
