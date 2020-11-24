; This is a hello world file for my first assembly project - 

; ---------------------------------------------------------------
; m3 - CPCE Assembly
; 10/29/2020 Matt Koenig
INCLUDE c:\Irvine\Irvine32.inc
INCLUDELIB c:\Irvine\Irvine32.lib
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	myString BYTE "Hello World",0dh,0ah
	
.code
main proc
	; assignment 1
	; converts a value v of a decimal digit d into the ASCII code of the digit d

	mov al,04h
	mov dl,30h
	add al, dl
	WriteChar dl

	invoke ExitProcess,0

main endp
end main
