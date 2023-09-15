#{
  // Avoid unexpected linebreaks and font ligatures...
  set text(size: .01pt, font: "Arial")

  // Edit the variable with `sed` before compiling
  let input-file = "/input"
  let (..map, _) = read(input-file)
                     .split("\n")
                     .map(row => { let (_, ..split-row, _) = row.split(""); split-row })

  let find-points(row: map.len() - 1, points: (:)) = {
    if row < 0 { return points }
    let match = map.at(row).join().match(regex("[SE]"))
    if match != none {
      let (start: col, text: char) = match
      points.insert(char, (row: row, col: col))
    }
    find-points(row: row - 1, points: points)
  }
  let (S: source, E: target) = find-points()

  // Nomalize map, since coordinates are saved
  map.at(source.row).at(source.col) = "a"
  map.at(target.row).at(target.col) = "z"

  let dijkstra(directions, queue: (source,)) = {
    if queue.len() == 0 {
      return directions
    }

    let (node, ..rest) = queue
    let to-visit = (
      (row: node.row + 1, col: node.col, from: "up"),
      (row: node.row - 1, col: node.col, from: "down"),
      (row: node.row, col: node.col + 1, from: "left"),
      (row: node.row, col: node.col - 1, from: "right"),
    )
    for other in to-visit {
      let (row: row, col: col, from: direction) = other
      let steps = directions.at(node.row).at(node.col).steps + 1
      if row in range(map.len()) and col in range(map.at(0).len()) and (
        map.at(row).at(col).to-unicode() <= map.at(node.row).at(node.col).to-unicode() + 1
      ) {
        let old = directions.at(row).at(col)
        if old == none or steps < old.steps {
          rest.push( (row: row, col: col) )
          directions.at(row).at(col) = (steps: steps, from: direction)
        }
      }
    }

    dijkstra(directions, queue: (..rest))
  }

  let directions = map.map(row => row.map(char => none))
  directions.at(source.row).at(source.col) = (steps: 0, from: none)
  directions = dijkstra(directions)
  directions.at(target.row).at(target.col).steps
}
