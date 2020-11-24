; Practice exercises with ASCII code conversion 

;--------------------------------------------------------------------------------------------
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

; m3 - CPCE Assembly
; 10/29/2020 Matt Koenig
INCLUDE c:\Irvine\Irvine32.inc
INCLUDELIB c:\Irvine\Irvine32.lib


.data
  addH BYTE "h", 0dh,0ah
  prompt BYTE "Enter a decimal number: ",0
  newLine BYTE " ", 0dh,0ah

.code 
	main proc


	; assignment 1
	; converts a value v of a decimal digit d into the ASCII code of the digit d

	mov al, 08h
	mov dl, 30h
	add dl, al
	mov al, dl
	call WriteChar
	mov edx, OFFSET newLine
	call WriteString


	; assignment 2
	; display in hexadecimal on the console the byte contained in the register AL
	; assume that AL contains a hexadecimal number that uses only decimal digits (i.e. 0 to 9)
	;
	; here is where we set AL - feel free to modify to test
	mov al, 94h

	; steps
	; store in the register DH the ASCII code of the most significant nibble.
	mov dh, al
	AND dh, 00F0h
	SHR dh, 4
	ADD dh, 30h

	; store in the register DL the ASCII code of the least significant nibble.
	mov dl, al
	AND dl, 000Fh
	ADD dl, 30h


	; Display (using WriteChar) on the console the character stored in DH (recall that WriteChar uses
	; AL for the character to display). 
	mov al, dh
	call WriteChar


	; Display (using WriteChar) on the console the character stored in DL.
	; Display ‘h’ to indicate that the number is a hexadecimal number.
	mov al, dl
	call WriteChar
	mov al, addH
	call WriteChar


	; ‘Display’ the ‘line feed’ character (ASCII code is 0Ah) to go to the next line.
	; ‘Display’ the ‘carriage’ character (ASCII code is 0Dh) to go to the next line.

	mov edx, OFFSET newLine
	call WriteString



	; assignment 3
	;  read a decimal digit d from the keyboard, convert the ASCII code of a digit d into the value v of d, and store v in the register DL
	mov edx, OFFSET prompt
	call WriteString
	call ReadChar
	mov dl, al
	sub dl, 30h
	mov edx, OFFSET newLine
	call WriteString

	; assignment 4
	; you must read consecutively two decimal digits from the keyboard
	; (use ReadChar for each digit). We assume that the user will enter only TWO decimal digits (i.e. ‘0’ to ‘9’).
	; The first digit entered will be set as the most significant nibble of AL and the second digit entered will be set as
	; the least significant nibble of AL
	mov edx, OFFSET prompt
	call WriteString
	call ReadChar
	mov dl, al
	mov edx, OFFSET newLine
	call WriteString

	mov edx, OFFSET prompt
	call WriteString
	call ReadChar
	sub al, 30h
	sub dl, 30h
	shl dl, 4
	add al, dl
	mov edx, OFFSET newLine
	call WriteString


	invoke ExitProcess,0

main endp
end main
