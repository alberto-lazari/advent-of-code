function! s:read_map()
    let map = []
    " Getting used to these awful tricks
    for row in readfile('/dev/stdin')
        call add(map, split(row, '\zs'))
    endfor

    return map
endfunction

function! s:is_visible(map, x, y)
    function! s:higher_than(trees, tree)
        for tree in a:trees
            if a:tree <= tree
                return v:false
            endif
        endfor

        return v:true
    endfunction

    let tree = a:map[a:x][a:y]
    let row = a:map[a:x]

    function! s:column(map, j)
        let column = []
        for i in range(0, len(a:map) - 1)
            call add(column, a:map[i][a:j])
        endfor

        return column
    endfunction

    let column = s:column(a:map, a:y)
    let last = len(a:map) - 1

    return a:x % last == 0 || a:y % last == 0 || s:higher_than(row[:a:y-1], tree) || s:higher_than(row[a:y+1:], tree) || s:higher_than(column[a:x+1:], tree) || s:higher_than(column[:a:x-1], tree)
endfunction

function! s:visible_trees(map)
    let visible_trees = 0
    let last = len(a:map) - 1
    for x in range(0, last)
        for y in range(0, last)
            let visible_trees += s:is_visible(a:map, x, y)
        endfor
    endfor

    return visible_trees
endfunction

ec s:visible_trees(s:read_map())
