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
PI_INC_RECIP =  5340353       	;;  Use reciprocal to find the table entry for a given angle 0x51 7CC1
	                        ;;              (It is easier to use than divison would be)


	;; If you need to, you can place global variables here

.CODE
;;theta <= pi, sine is +
;;theta > pi, sine is -
FixedSin PROC USES edi ebx ecx edx esi angle:FXPT
;;MODULO DIVIDE ANGLE BY 2PI
;; i = theta*256/pi
;;I'M NOT ACTUALLY GETTING MY SINE ANGLES CORRECT FOR ANYTHING > |PI/2|
  xor ecx, ecx
  xor esi, esi
  mov eax, angle ;;load angle into eax
  ;mov eax, PI_HALF
  cdq ;;sign extends eax into edx
  mov ebx, TWO_PI
  idiv ebx
  mov eax, edx
  cmp eax, 0
  jl NEG_ANGLE ;;makes the angle positive, knowing that we'll invert result
  je ZERO
  ;;DEFINITELY 100% WORKS
L0:
  cmp eax, PI
  jge PI_2PI ;;is theta > PI? If so, theta -= PI and negate output
L1:
  cmp eax, PI_HALF ;;is angle > pi/2? Great. Now we say theta = Pi - theta
  jg PI_PI_2 ;;result isn't negated.
L2:
  shl eax, 8 ;; eax *= 256
  mov edx, 0
  mov ebx, PI
  idiv ebx ;;eax now holds our index (angle/(pi/256)) = i

L3:
  lea edi, SINTAB         ;;edi now holds the address of SINTAB
  movzx eax, WORD PTR [edi + eax * 2] ;;should move array entry into eax

  cmp ecx, 0
  jne NEGATE_OUT
FIN:
  ret
NEG_ANGLE:
  not ecx
  neg eax
	jmp L0
PI_2PI:
  not ecx
  sub eax, PI
  jmp L1
NEGATE_OUT:
  neg eax
  jmp FIN
ZERO:
  mov eax, 0
  ret
PI_PI_2:
  mov ebx, PI
  sub ebx, eax
  mov eax, ebx ;;eax = Pi - eax
  jmp L2
ret
FixedSin ENDP

FixedCos PROC angle:FXPT
  mov eax, angle
  add eax, PI_HALF
  invoke FixedSin, eax
ret			; Don't delete this line!!!
FixedCos ENDP
END
