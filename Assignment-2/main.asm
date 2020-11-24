; basic register practice - moving the value 2 into reister EAX

; ----------------------------------------------------------------
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword


.code
	main proc

		MOV EAX,2
		invoke ExitProcess,0

	main endp
end main
