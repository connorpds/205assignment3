; #########################################################################
;
;   blit.asm - Assembly file for CompEng205 Assignment 3
;
;
; #########################################################################

      .586
      .MODEL FLAT,STDCALL
      .STACK 4096
      option casemap :none  ; case sensitive

include stars.inc
include lines.inc
include trig.inc
include blit.inc


.DATA

	;; If you need to, you can place global variables here

.CODE

DrawPixel PROC x:DWORD, y:DWORD, color:DWORD
  xor eax, eax
	ret 			; Don't delete this line!!!
DrawPixel ENDP

BasicBlit PROC ptrBitmap:PTR EECS205BITMAP , xcenter:DWORD, ycenter:DWORD
  xor eax, eax
	ret 			; Don't delete this line!!!
BasicBlit ENDP


RotateBlit PROC lpBmp:PTR EECS205BITMAP, xcenter:DWORD, ycenter:DWORD, angle:FXPT
  xor eax, eax 
	ret 			; Don't delete this line!!!
RotateBlit ENDP



END
