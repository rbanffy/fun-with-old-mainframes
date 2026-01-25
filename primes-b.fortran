C FORTRAN IV PROGRAM TO FIND FIRST 20 PRIME NUMBERS
      INTEGER C, N, D, P
      C = 0
      N = 2
   10 IF (C .GE. 20) GO TO 200
      P = 1
      D = 2
   20 IF (D .GT. N - 1) GO TO 30
      IF ((N / D) * D .NE. N) GO TO 25
      P = 0
   25 D = D + 1
      GO TO 20
   30 IF (P .NE. 1) GO TO 180
      WRITE (6, 40) N
   40 FORMAT (I3)
      C = C + 1
  180 N = N + 1
      GO TO 10
  200 STOP
      END
