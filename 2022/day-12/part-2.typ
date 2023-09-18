#{
  // Avoid unexpected linebreaks and font ligatures...
  set text(size: .01pt, font: "Arial")

  // Edit the variable with `sed` before compiling
  let input-file = "/input"
  let (..map, _) = read(input-file)
                     .split("\n")
                     .map(row => { let (_, ..split-row, _) = row.split(""); split-row })

  let rows = map.len()
  let cols = map.at(0).len()

  let find-points(row: rows - 1, points: (a: ())) = {
    if row < 0 { return points }

    for col in range(cols) {
      let char = map.at(row).at(col)
      if char.contains(regex("[SE]")) {
        points.insert(char, (row: row, col: col))
      }
      if char.contains(regex("[aS]")) {
        points.a.push((row: row, col: col))
      }
    }

    find-points(row: row - 1, points: points)
  }
  let (S: source, E: target, a: sources) = find-points()

  // Nomalize map, since coordinates are saved
  map.at(source.row).at(source.col) = "a"
  map.at(target.row).at(target.col) = "z"

  let dijkstra(directions, queue: (source,)) = {
    while queue.len() > 0 {
      let (node, ..rest) = queue
      let to-visit = (
        (row: node.row + 1, col: node.col),
        (row: node.row - 1, col: node.col),
        (row: node.row, col: node.col + 1),
        (row: node.row, col: node.col - 1),
      )
      for other in to-visit {
        let (row: row, col: col) = other
        let steps = directions.at(node.row).at(node.col) + 1
        if row in range(rows) and col in range(cols) and (
          map.at(row).at(col).to-unicode() <= map.at(node.row).at(node.col).to-unicode() + 1
        ) {
          let old = directions.at(row).at(col)
          if old == none or steps < old {
            rest.push( (row: row, col: col) )
            directions.at(row).at(col) = steps
          }
        }
      }

      queue = rest
    }

    directions
  }

  let empty-directions = map.map(row => row.map(char => none))
  let min-steps = none
  for s in sources {
    source = s
    let directions = empty-directions
    directions.at(source.row).at(source.col) = 0

    let steps = dijkstra(directions, queue: (source,)).at(target.row).at(target.col)
    if steps != none and (min-steps == none or steps < min-steps) {
      min-steps = steps
    }
  }

  min-steps
}
