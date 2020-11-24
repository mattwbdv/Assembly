; Final program for assembly course, deals with writing more robust procedures while processing more complex algorithms with user input via console 

;----------------------------------------------------------------------------------------------------------------------------------------------------------

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
charToDelete BYTE "Please enter number of characters to delete: ", 0
positionToStart BYTE "Please enter the position to start deleting: ", 0
buffer BYTE 21 DUP(0) ; input buffer
promptSentence1 BYTE "Please enter a sentence S1 to insert into the next string: ", 0
promptSentence2 BYTE "Please enter a sentence S2 to be inserted into: ", 0
positionToInsert BYTE "Please enter the position where to insert: ", 0
buffer1 BYTE 512 DUP(0) ; input buffer
buffer2 BYTE 512 DUP(0) ; input buffer
concatString BYTE 512 DUP(?)


.code
	main proc
	call procedureI
	call procedureII
	
	invoke ExitProcess,0

	main endp
; ------------------------------------------------------------------

; This procedure takes a string from the user and removes parts of the string per the users input 

procedureI proc

	; robust procedure push 
	 push edx
	 push ecx
	 push eax
	 push ebx
	 push esi
	 push edi 

	; introduce assignment in console
     mov edx, OFFSET fileName    
     call WriteString
	 call Crlf
	 	 
	 ; process promptString input from the user 
	 mov edx, OFFSET promptString
     call WriteString
	 mov edx,OFFSET buffer ; point to the buffer
   	 mov ecx,SIZEOF buffer ; specify max characters
	 call ReadString ; input the string
	 call Crlf

	 ; prompt charToDelete input from the user
	 mov edx, OFFSET charToDelete
     call WriteString
	 call ReadHex
	 mov ebx, eax
	 call Crlf

	 ; prompt positionToStart input from the user
	 mov edx, OFFSET positionToStart
     call WriteString
	 call ReadHex
	 dec eax
	 add ebx, eax ; put in ebx the position to start deleting
	 call Crlf

	 ; remove charToDelete from string starting at positionToStart and print string back
	 cld
	 mov esi, OFFSET buffer
	 mov edi, OFFSET buffer
	 add edi, eax
	 add esi, ebx
	 mov ecx, SIZEOF buffer
	 sub ecx, ebx
	 rep movsb
	 mov edx, OFFSET buffer
	 call WriteString
	 call Crlf

	; robust procedure pop 
	 pop edx
	 pop ecx
	 pop eax
	 pop ebx
	 pop esi
	 pop edi 


	 ret
procedureI endp

; ------------------------------------------------------------------
; takes two strings as input and a position in the form of a hex digit, it then concatenates a string with the first string and position superimposed onto the second string

 procedureII proc
 	; robust procedure push 
     push edx
	 push eax
	 push edi
	 push ebx
     push ecx
     push esi
     push ebx

 	 ; process promptSentence1 input from the user 
	 mov edx, OFFSET promptSentence1
     call WriteString
	 mov edx,OFFSET buffer1 ; point to the buffer
   	 mov ecx,SIZEOF buffer1 ; specify max characters
	 call ReadString ; input the string
	 mov ebx, eax ; put eax length into ebx to be used later
	 call Crlf

	 ; process promptSentence2 input from the user 
	 mov edx, OFFSET promptSentence2
     call WriteString
	 mov edx,OFFSET buffer2 ; point to the buffer
   	 mov ecx,SIZEOF buffer2 ; specify max characters
	 call ReadString ; input the string
	 mov ebp, eax ; put eax length into ebp to be used later
	 call Crlf

     ; prompt positionToInsert input from the user
	 mov edx, OFFSET positionToInsert
     call WriteString
	 call ReadHex ; procedd position to be inserted (stored in eax)
	 dec eax ; decrement due to 0-based indexing
	 call Crlf

	 ; insert s1 into s2 at the specified position
	 cld 
	 mov esi, OFFSET buffer2
	 mov edi, OFFSET concatString
	 mov ecx, eax ; will add to concat string until position reached
	 rep movsb
	 mov esi, OFFSET buffer1
	 mov ecx, ebx ; will add to concat string string 1
	 rep movsb
	 mov esi, OFFSET buffer2
	 add esi, eax
	 mov ecx, ebp ; will add to concat string string 2
	 sub ecx, eax
	 rep movsb
	 mov edx, OFFSET concatString ; write back concatenated string
	 call WriteString
	 call Crlf

	 ; robust procedure pop 
     pop edx
	 pop eax
	 pop edi
	 pop ebx
     pop ecx
     pop esi
     pop ebx

   ret
 procedureII endp

end main
