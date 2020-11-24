; First comprehensive assembly program reading and writing bytes with a user 

;-----------------------------------------------------------------------------------------------------------

INCLUDE c:\Irvine\Irvine32.inc
INCLUDELIB c:\Irvine\Irvine32.lib
.386
.model flat;stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

; mkoenig 
; auburn u 

.code

; ------------------------------------------------------------------

	DigitValue2ASCII proc
	; starts process
	mov DL, AL
	cmp DL, 09h ; compare to 9 to see if it's a letter or digit
	jbe digit ; jump to digit if digit
	ja letter ; jump to letter if letter

	digit:
	add DL, 30h ; ditigs just need 30h added to get their ASCII
	jmp endTheProgram

	letter:
	sub DL, 0Ah ; letters first need digits removed (back to zero base)
	add DL, 41h ; then add 41h to letters to get their ASCII
	jmp endTheProgram

	endTheProgram:
	mov AL, DL ; put the ASCII code into AL
	ret
	DigitValue2ASCII endp

; ------------------------------------------------------------------

	WriteHexByte proc
	; most sig nib
	mov DH, AL ; put AL into DH for long term storage
	and AL, 0F0h ; isolates most sig nib
	shr AL, 4 ; shifts most sig nib into least sig nib position 
	call DigitValue2ASCII ; converts to ASCII and puts in DL
	mov AL, DL ; put DL into AL
	call WriteChar ; writes most sig nib

	; least sig nib
	mov AL, DH ; put DH into AL
	and AL, 0Fh ; isolates least sig nib
	call DigitValue2ASCII ; converts to ASCII and puts in DL
	mov AL, DL ; put DL into AL
	call WriteChar ; writes least sig nib

	; add h at the end
	mov AL, 68h
	call WriteChar
	mov AL, 0Ah 
	call WriteChar
	mov AL, 0Dh 
	call WriteChar
	ret
	WriteHexByte endp


; ------------------------------------------------------------------

	ASCII2DigitValue proc 
	mov DL, AL ; puts AL into DL for analysis
	cmp DL, 39h ; determines if digit or letter
	jbe digitBack ; if digit, move to digit method
	ja letterBack ; if letter, move to letter method

	digitBack: 
	sub DL, 30h ; subtract 30h to ASCII digits to get digit value
	jmp endTheProgram

	letterBack:
	sub DL, 41h ; subtract 41h to ASCII letters to get letter value
	add DL, 0Ah ; must add back 0Ah to surpass digits (and get to letters)

	endTheProgram: 
	ret
	ASCII2DigitValue endp

; ------------------------------------------------------------------

	ReadHexByte proc
	call ReadChar ; read character from console
	call ASCII2DigitValue ; convert it from ASCII into a digit value
	mov DH, DL ; move console input into DH

	call ReadChar ; read next character from console
	call ASCII2DigitValue ; convert it from ASCII into a digit value
	mov AL, DL ; move it into AL
	shl DH, 4 ; shift left to position adding first digit back
	add AL, DH ; add first digit back
	ret
	ReadHexByte endp

; ------------------------------------------------------------------


	SumFirstN proc
	
	mov ECX, 0h ; make sure ECX is 00
	mov CL, AL ; we will loop "AL" number of times
	mov DX, 0h ; DX is 00h to start
	mov BX, 1h ; start adding at 1

top: ; we use the loop term "top" as defined in the Irvine textbook
	add DX, BX ; each loop we add the adder to final ans
	add BX, 1h 	; each loop we add 1 to the adder
	loop top
	ret

	SumFirstN endp

; ------------------------------------------------------------------

	WriteHexByteWithoutH proc 
	; ENTIRELY DUPLICATIVE OF WRITEHEXBYTE JUST HAS FORMATTING CHANGES 
	; most sig nib
	mov DH, AL 
	and AL, 0F0h 
	shr AL, 04
	call DigitValue2ASCII
	mov AL, DL
	call WriteChar

	; least sig nib
	mov AL, DH
	and AL, 0Fh 
	call DigitValue2ASCII
	mov AL, DL
	call WriteChar
	ret
	WriteHexByteWithoutH endp

; ------------------------------------------------------------------

	main proc

	call ReadHexByte
	call SumFirstN

	mov al, dh   
	call WriteHexByteWithoutH
	mov al, dl     
	call WriteHexByte

	invoke ExitProcess,0

	main endp

end main
