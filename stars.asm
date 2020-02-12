; #########################################################################
;
;   stars.asm - Assembly file for CompEng205 Assignment 1
;   Connor Selna
;   CPS7865
; #########################################################################

      .586
      .MODEL FLAT,STDCALL
      .STACK 4096
      option casemap :none  ; case sensitive


include stars.inc

.DATA

	;; If you need to, you can place global variables here

.CODE

DrawStarField proc

	invoke DrawStar, 150, 200
      invoke DrawStar, 200, 200
      invoke DrawStar, 200, 150
      invoke DrawStar, 150, 150 
      
      invoke DrawStar, 250, 200
      invoke DrawStar, 200, 250
      invoke DrawStar, 250, 250

      invoke DrawStar, 50, 100
      invoke DrawStar, 100, 50
      invoke DrawStar, 100, 100
      invoke DrawStar, 50, 50

      invoke DrawStar, 150,100
      invoke DrawStar, 100, 150

      invoke DrawStar, 200, 50
      invoke DrawStar, 300, 50
      invoke DrawStar,  400,50
      invoke DrawStar, 265, 350
      
     

	ret  			; Careful! Don't remove this line
DrawStarField endp



END
