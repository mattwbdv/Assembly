INCLUDE c:\Irvine\Irvine32.inc
INCLUDELIB c:\Irvine\Irvine32.lib
.386
.model flat;stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

; mkoenig 
; auburn u 


.data 
fileName BYTE "mkoenig - auburn university - 2020", 0
promptString BYTE "Please enter a sentence: ", 0
promptChar BYTE "Please enter a character: ", 0
promptSentenceOne BYTE "Please enter the first sentence: ", 0
promptSentenceTwo BYTE "Please enter the second sentence: ", 0
buffer BYTE 21 DUP(0) ; input buffer
buffer2 BYTE 21 DUP(0) ; input buffer
byteCount DWORD ? ; holds counter
concatString BYTE 42 DUP(0) 



.code
; ------------------------------------------------------------------

	main proc
	call procedureI
	call procedureII
	call procedureIII
	
	invoke ExitProcess,0

	main endp
; ------------------------------------------------------------------

procedureI proc
	; introduce assignment in console
     mov edx, OFFSET fileName    
     call WriteString
	 call Crlf
	 
	 ; prompt input from the user
	 mov edx, OFFSET promptString
     call WriteString

	 ; process input from the user 
	 mov edx,OFFSET buffer ; point to the buffer
   	 mov ecx,SIZEOF buffer ; specify max characters
	 call ReadString ; input the string
	 mov byteCount,eax ; number of characters
	 mov eax, byteCount
	 call WriteDec ; prints dec value of number of chars in string
	 call Crlf
	 mov eax,byteCount
	 call WriteHex ; prints hex value of number of chars in string 
	 call Crlf
	 mov edx, OFFSET buffer 
	 call WriteString ; prints full string entered back to console
	 call Crlf

	 ret
procedureI endp

; ------------------------------------------------------------------


procedureII proc 
	 ; prompt string input from the user
	 mov edx, OFFSET promptString
     call WriteString

	 ; process input from the user 
	 mov edx,OFFSET buffer ; point to the buffer
   	 mov ecx,SIZEOF buffer ; specify max characters
	 call ReadString ; input the string

	; prompt char input from the user
	 mov edx, OFFSET promptChar
	 call WriteString
     call ReadChar
	 call Crlf

	; loop to determine number of times char occurs in string
	 mov esi,OFFSET buffer ; where to start
	 mov dh, 0 ; initialize dh as 0
	 mov ecx,SIZEOF buffer ; number of elements to scan


myLoop:
	 cmp al, [esi]
	 jnz keepGoing
	 inc dh

keepGoing:
	 inc esi
	 loop myLoop

	 movzx eax, dh
	 call WriteDec
	 call Crlf

	 ret

procedureII endp

procedureIII proc
	 mov byteCount, 0000 ; set bytecount back to 0
	 ; INPUT FOR STRING I
	 ; prompt string input from the user
	 mov edx, OFFSET promptSentenceOne
     call WriteString

	 ; process input from the user 
	 mov edx,OFFSET buffer ; point to the buffer
   	 mov ecx,SIZEOF buffer ; specify max characters
	 call ReadString ; input the string
	 add byteCount, eax ; add string value to bytecount
	 mov ebx, eax ; will need in loop later

	 ; INPUT FOR STRING II
	 ; prompt string input from the user
	 mov edx, OFFSET promptSentenceTwo
     call WriteString

	 ; process input from the user 
	 mov edx,OFFSET buffer2 ; point to the buffer
   	 mov ecx,SIZEOF buffer2 ; specify max characters
	 call ReadString ; input the string
	 add byteCount, eax ; add string value to bytecount


	 ; WRITE HEX AND DEC VALUE TO CONSOLE 
	 mov eax, byteCount
	 call WriteDec ; prints dec value of number of chars in string
	 call Crlf
	 mov eax,byteCount
	 call WriteHex ; prints hex value of number of chars in string 
	 call Crlf

	 cld
	 mov esi, OFFSET buffer ; moving first string into esi
     mov edi, OFFSET concatString ; moving final string into edi
	 mov ecx, ebx ; moving size of fist string only into ecx
	 rep movsb ; loop, moving esi into edi (concatinating to new string)
	 mov esi, OFFSET buffer2 ; moving second string into esi
     mov ecx, eax ; moving size of second string only into ecx
	 rep movsb ; loop moving esi into edi (concatinating to new string)
	 mov edx, OFFSET concatString 
     call WriteString
	 call Crlf
	 ret
procedureIII endp

end main