      MODULE M KNOT
        TYPE KNOT
          INTEGER ROW, COL
        END TYPE
      END MODULE

      SUBROUTINE MOVE HEAD (HEAD, DIRECTION)
        USE M KNOT

        TYPE (KNOT) HEAD
        CHARACTER DIRECTION

        IF (DIRECTION .EQ. 'U') THEN
          HEAD%ROW = HEAD%ROW - 1
        ELSE IF (DIRECTION .EQ. 'D') THEN
          HEAD%ROW = HEAD%ROW + 1
        ELSE IF (DIRECTION .EQ. 'R') THEN
          HEAD%COL = HEAD%COL + 1
        ELSE IF (DIRECTION .EQ. 'L') THEN
          HEAD%COL = HEAD%COL - 1
        END IF
      END

      SUBROUTINE MOVE TAIL (TAIL, HEAD)
        USE M KNOT

        TYPE (KNOT) TAIL, HEAD

C IF TOUCHING DO NOTHING
        IF ((ABS (HEAD%COL - TAIL%COL) .LE. 1) .AND.
     +      (ABS (HEAD%ROW - TAIL%ROW) .LE. 1)) RETURN

C IF THEY ARE ON SAME ROW/COL THE OTHER IS TOO FAR
        IF (.NOT. (TAIL%COL .EQ. HEAD%COL))
     +    TAIL%COL = TAIL%COL + SIGN (1, HEAD%COL - TAIL%COL)
        IF (.NOT. (TAIL%ROW .EQ. HEAD%ROW))
     +    TAIL%ROW = TAIL%ROW + SIGN (1, HEAD%ROW - TAIL%ROW)
      END

      SUBROUTINE DRAW MAP (SIZE, MAP, HEAD, TAIL)
        USE M KNOT

        INTEGER SIZE, MAP(SIZE, SIZE)
        TYPE (KNOT) HEAD, TAIL

        DO 70 I = 1, SIZE
          DO 60 J = 1, SIZE
            IF ((HEAD%ROW .EQ. I) .AND. (HEAD%COL .EQ. J)) THEN
              WRITE (*, '(A)', ADVANCE = 'NO') 'H'
            ELSE IF ((TAIL%ROW .EQ. I) .AND. (TAIL%COL .EQ. J)) THEN
              WRITE (*, '(A)', ADVANCE = 'NO') 'T'
            ELSE IF (MAP(I, J) .EQ. 0) THEN
              WRITE (*, '(A)', ADVANCE = 'NO') '.'
            ELSE
              WRITE (*, '(A)', ADVANCE = 'NO') '#'
            END IF
   60     CONTINUE
C BREAK THE LINE
          WRITE (*, *)
   70   CONTINUE
      END

      PROGRAM DAY9 PART1
        USE MKNOT
C VARIABLES DECLARATION
***********************
C "512 OUGHT TO BE ENOUGH"
        PARAMETER (MAP SIZE = 512)
        INTEGER MAP(MAP SIZE, MAP SIZE), I, J

        TYPE (KNOT) HEAD, TAIL

C INPUT VARIABLES
        CHARACTER DIRECTION
        INTEGER STEPS

        INTEGER POSITIONS

C VARIABLES INITIALIZATION
**************************
C INITIALIZE MAP
        DO 20 I = 1, MAP SIZE
          DO 10 J = 1, MAP SIZE
            MAP(I, J) = 0
   10     CONTINUE
   20   CONTINUE
C INITIALIZE HEAD IN THE CENTER OF THE MAP
        HEAD%COL = MAP SIZE / 2
        HEAD%ROW = HEAD%COL
C HEAD AND TAIL START FROM THE SAME POSITION
        TAIL = HEAD

C MAIN READ LOOP
        DO
          READ (*, *, END = 30) DIRECTION, STEPS
          DO 25 I = 1, STEPS
C           PRINT *, DIRECTION
            CALL MOVE HEAD (HEAD, DIRECTION)
C           IF ((HEAD%COL .LE. 0) .OR. (HEAD%COL .GT. MAP SIZE) .OR.
C    +          (HEAD%ROW .LE. 0) .OR. (HEAD%ROW .GT. MAP SIZE))
C    +        PRINT *, 'ERROR: HEAD OUT OF BOUNDS'
            CALL MOVE TAIL (TAIL, HEAD)

C           CALL DRAW MAP (MAP SIZE, MAP, HEAD, TAIL)
            MAP(TAIL%ROW, TAIL%COL) = 1
   25     CONTINUE
        END DO

C COMPUTE RESULT
   30   POSITIONS = 0

        DO 50 I = 1, MAP SIZE
          DO 40 J = 1, MAP SIZE
            POSITIONS = POSITIONS + MAP(I, J)
   40     CONTINUE
   50   CONTINUE

        WRITE (*, '(I0)') POSITIONS

        STOP
      END
