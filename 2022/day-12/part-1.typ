#{
// Edit the variable with `sed` before compiling
let input-file = "/input"
let (..map, _) = read(input-file)
                   .split("\n")
                   .map(row => {
                     let (_, ..split-row, _) = row.split(""); split-row
                   })
map
}
