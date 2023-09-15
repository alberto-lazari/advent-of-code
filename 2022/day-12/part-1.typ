#{
  // Edit the variable with `sed` before compiling
  let input-file = "/input"
  let (..map, _) = read(input-file)
                     .split("\n")
                     .map(row => { let (_, ..split-row, _) = row.split(""); split-row })

  let find-points(row, points) = {
    if row < 0 { return points }
    let match = map.at(row).join().match(regex("[SE]"))
    if match != none {
      let (start: col, text: char) = match
      points.insert(char, (row, col))
    }
    find-points(row - 1, points)
  }
  let (S: source, E: target) = find-points(map.len() - 1, (:))
}
