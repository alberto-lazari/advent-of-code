NB. need to treat stdin as a file -_-
input =: 1!:1 <'/dev/stdin'

NB. echo puts an unnecessary EOL in stdout :)
echo input
