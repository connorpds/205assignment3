; #########################################################################
;
;   lines.asm - Assembly file for CompEng205 Assignment 2
;   Connor Selna, CPS7865
;
; #########################################################################

      .586
      .MODEL FLAT,STDCALL
      .STACK 4096
      option casemap :none  ; case sensitive

include stars.inc
include lines.inc

.DATA

	;; If you need to, you can place global variables here

.CODE


;; Don't forget to add the USES the directive here
;;   Place any registers that you modify (either explicitly or implicitly)
;;   into the USES list so that caller's values can be preserved

;;   For example, if your procedure uses only the esi and ebx registers
;;      DrawLine PROC USES esi ebx x0:DWORD, y0:DWORD, x1:DWORD, y1:DWORD, color:DWORD
DrawLine PROC USES esi edi eax ebx ecx edx x0:DWORD, y0:DWORD, x1:DWORD, y1:DWORD, color:DWORD
;;uses directive makes assembler handle callee saving for you
	;; Feel free to use local variables...declare them here
	;; For example:
	;; 	LOCAL foo:DWORD, bar:DWORD
  LOCAL inc_x:DWORD, inc_y: DWORD, error: DWORD, delta_x: DWORD, delta_y: DWORD
  mov esi, x0 ;preserved for curr_x
  mov ebx, x1; delta_x
  mov edi, y0 ;preserved for curr_ y
  mov edx, y1; delta_y
  sub ebx, esi ; x1 - x0, ebx now holds deltax
  jl XNEG ;diff is negative, need to take abs
  mov inc_x, 1
XDONE:
  sub edx, edi
  jl YNEG
  mov inc_y, 1
YDONE:
	cmp ebx, edx ;cmp delta_x delta_y
  mov delta_x, ebx
  mov delta_y, edx
  jg XG
  neg edx
  mov error, edx
  jmp DIV_ERR
XG:
  mov error, ebx
DIV_ERR:
  sar error, 1
  ;mov idk why this is here lol
  INVOKE DrawPixel, x0, y0, color

  mov ebx, x1 ; x1 -> ebx
  mov ecx, y1 ; y1 -> ecx

  ;; esi, edi are curr_x, curr_y. ebx, ecx are x1, y1
  ;; eax,edx are free for use
  mov eax, error
  cmp esi, ebx
  jne L1
  cmp edi, ecx
  je FIN


L1:
  INVOKE DrawPixel, esi, edi, color

  mov edx, eax; prev_error = error, now only eax is free
  cmp edx, delta_x

  jg PEDY ;jump to prev_error < delta_y condition
  sub eax, delta_y
  add esi, inc_x
PEDY:
  cmp edx, delta_y
  jge LTEST
  add eax, delta_x
  add edi, inc_y

LTEST:

  cmp esi, ebx
  jne L1
  cmp edi, y1
  ;jne L1
  jmp FIN



XNEG:
  neg ebx
  mov inc_x, -1
  jmp XDONE
YNEG:
  neg edx
  mov inc_y, -1
  jmp YDONE


FIN:
	ret        	;;  Don't delete this line...you need it
DrawLine ENDP




END
