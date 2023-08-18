      module m knot
        type knot
          integer row, col
        end type
      end module

      subroutine move head (head, direction)
        use m knot

        type (knot) head
        character direction

        if (direction .eq. 'U') then
          head%row = head%row - 1
        else if (direction .eq. 'D') then
          head%row = head%row + 1
        else if (direction .eq. 'R') then
          head%col = head%col + 1
        else if (direction .eq. 'L') then
          head%col = head%col - 1
        end if
      end

      subroutine move tail (tail, head)
        use m knot

        type (knot) tail, head

c if touching do nothing
        if ((abs (head%col - tail%col) .le. 1) .and.
     +      (abs (head%row - tail%row) .le. 1)) return

c if they are on same row/col the other is too far
        if (.not. (tail%col .eq. head%col))
     +    tail%col = tail%col + sign (1, head%col - tail%col)
        if (.not. (tail%row .eq. head%row))
     +    tail%row = tail%row + sign (1, head%row - tail%row)
      end

      subroutine draw map (size, map, head, tail)
        use m knot

        integer size, map(size, size)
        type (knot) head, tail

        do 70 i = 1, size
          do 60 j = 1, size
            if ((head%row .eq. i) .and. (head%col .eq. j)) then
              write (*, '(a)', advance = 'no') 'H'
            else if ((tail%row .eq. i) .and. (tail%col .eq. j)) then
              write (*, '(a)', advance = 'no') 'T'
            else if (map(i, j) .eq. 0) then
              write (*, '(a)', advance = 'no') '.'
            else
              write (*, '(a)', advance = 'no') '#'
            end if
   60     continue
c break the line
          write (*, *)
   70   continue
      end

      program day9 part1
        use mknot
c variables declaration
***********************
c "512 ought to be enough"
        parameter (map size = 512)
        integer map(map size, map size), i, j

        type (knot) head, tail

c input variables
        character direction
        integer steps

        integer positions

c variables initialization
**************************
c initialize map
        do 20 i = 1, map size
          do 10 j = 1, map size
            map(i, j) = 0
   10     continue
   20   continue
c initialize head in the center of the map
        head%col = map size / 2
        head%row = head%col
c head and tail start from the same position
        tail = head

c main read loop
        do
          read (*, *, end = 30) direction, steps
          do 25 i = 1, steps
c           print *, direction
            call move head (head, direction)
c           if ((head%col .le. 0) .or. (head%col .gt. map size) .or.
c    +          (head%row .le. 0) .or. (head%row .gt. map size))
c    +        print *, 'error: head out of bounds'
            call move tail (tail, head)

c           call draw map (map size, map, head, tail)
            map(tail%row, tail%col) = 1
   25     continue
        end do

c compute result
   30   positions = 0

        do 50 i = 1, map size
          do 40 j = 1, map size
            positions = positions + map(i, j)
   40     continue
   50   continue

        write (*, '(i0)') positions

        stop
      end
