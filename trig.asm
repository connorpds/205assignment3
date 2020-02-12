; #########################################################################
;
;   trig.asm - Assembly file for CompEng205 Assignment 3
;
;
; #########################################################################

      .586
      .MODEL FLAT,STDCALL
      .STACK 4096
      option casemap :none  ; case sensitive

include trig.inc

.DATA

;;  These are some useful constants (fixed point values that correspond to important angles)
PI_HALF = 102943           	;;  PI / 2 0x1 921F
PI =  205887	                ;;  PI
TWO_PI	= 411774                ;;  2 * PI
PI_INC_RECIP =  5340353        	;;  Use reciprocal to find the table entry for a given angle 0x51 7CC1
	                        ;;              (It is easier to use than divison would be)


	;; If you need to, you can place global variables here

.CODE

FixedSin PROC angle:FXPT
;;MODULO DIVIDE BY ANGLE (USING REMAINDER FROM DIV)
  mov eax, angle ;;load angle into eax
                ;;now we must ensure the angle is less than pi/2
  mov edx, PI_INC_RECIP
  imul edx
  shr eax, 16             ;;eax now holds our index (angle/(pi/256)) = i
  lea edi, SINTAB         ;;edi now holds the address of SINTAB
  movzx eax, WORD PTR [edi + eax] ;;should move array entry into edx
	ret			; Don't delete this line!!!
FixedSin ENDP

FixedCos PROC angle:FXPT
mov eax, angle ;;load angle into eax
shr eax, 16
              ;;now we must ensure the angle is less than pi/2
;mov edx, PI_INC_RECIP
;imul edx
;shr ecx, 16             ;;eax now holds our index (angle/(pi/256)) = i
;lea edi, SINTAB         ;;edi now holds the address of SINTAB
;movzx eax, WORD PTR [edi + 128 - ecx]        ; Replace this with your own crazy code

	ret			; Don't delete this line!!!
FixedCos ENDP
END
