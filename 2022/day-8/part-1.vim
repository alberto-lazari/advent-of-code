function! s:read_map()
    let map = []
    " Getting used to these awful tricks
    for row in readfile('/dev/stdin')
        call add(map, split(row, '\zs'))
    endfor

    return map
endfunction

function! s:visible_map(map)
    let last = len(a:map) - 1

    function! s:is_visible(x, y) closure
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

        return a:x % last == 0 || a:y % last == 0 || s:higher_than(row[:a:y-1], tree) || s:higher_than(row[a:y+1:], tree) || s:higher_than(column[a:x+1:], tree) || s:higher_than(column[:a:x-1], tree)
    endfunction

    let visible = []
    for x in range(0, last)
        call add(visible, [])
        for y in range(0, last)
            call add(visible[x], s:is_visible(x, y))
        endfor
    endfor

    return visible
endfunction

function! s:visible_trees(visible_map)
    let visible_trees = 0
    for row in a:visible_map
        for is_visible in row
            let visible_trees += is_visible
        endfor
    endfor

    return visible_trees
endfunction

function! s:print(map)
    for row in a:map
        ec join(row)
    endfor
endfunction

ec s:visible_trees(s:visible_map(s:read_map()))
