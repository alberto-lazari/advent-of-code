let map = []
" Getting used to these awful tricks
for row in readfile('/dev/stdin')
    call add(map, split(row, '\zs'))
endfor

let visible = []
let last = len(map) - 1
for x in range(0, last)
    call add(visible, [])
    for y in range(0, last)
        if x % last == 0 || y % last == 0
            call add(visible[x], 1)
        else
            call add(visible[x], 0)
        endif
    endfor
endfor

function! s:print(map)
    for row in a:map
        ec join(row)
    endfor
endfunction

call s:print(map)
ec 'Visible'
call s:print(visible)

