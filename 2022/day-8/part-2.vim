function! s:read_map()
    let map = []
    " Getting used to these awful tricks
    for row in readfile('/dev/stdin')
        call add(map, split(row, '\zs'))
    endfor

    return map
endfunction

function! s:scenic_score(map, x, y)
    function! s:view(trees, tree)
        let view = 1
        for tree in a:trees
            if a:tree <= tree
                return view
            endif
            let view += 1
        endfor

        " Reached a border, that need to be ignored
        return view - 1
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

    let up = reverse(a:x < 1 ? [] : column[:a:x - 1])
    let down = column[a:x + 1:]
    let left = reverse(a:y < 1 ? [] : row[:a:y - 1])
    let right = row[a:y + 1:]

    return s:view(up, tree) * s:view(down, tree) * s:view(left, tree) * s:view(right, tree)
endfunction

function! s:max_scenic_score(map)
    let scenic_score = []
    let last = len(a:map) - 1
    for x in range(0, last)
        for y in range(0, last)
            call add(scenic_score, s:scenic_score(a:map, x, y))
        endfor
    endfor

    return max(scenic_score)
endfunction

let tree_map = s:read_map()
ec s:max_scenic_score(tree_map)
