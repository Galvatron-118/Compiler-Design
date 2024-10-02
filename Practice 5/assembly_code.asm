;start -1
.686
.model flat, c
include C:\masm32\include\msvcrt.inc
includelib C:\masm32\lib\msvcrt.lib

.stack 100h
printf PROTO arg1:Ptr Byte, printlist:VARARG
scanf PROTO arg2:Ptr Byte, inputlist:VARARG

.data
output_integer_msg_format byte "%d", 0Ah, 0
output_msg_format byte "%s", 0

output_msg byte "ENTER NUMBER:",0
output_positive_msg byte "NUMBER IS POSITIVE", 0Ah, 0
output_negative_msg byte "NUMBER IS NEGATIVE", 0Ah, 0

input_integer_format byte "%d",0

number sdword ?

.code

main proc
	push ebp
	mov ebp, esp
	sub ebp, 100
	mov ebx, ebp
	add ebx, 4


;scan_int_value 0
	push eax
	push ebx
	push ecx
	push edx
	push [ebp-12]
	push [ebp-8]
	push [ebp-4]
	push [ebp-0]
	push ebp
	INVOKE scanf, ADDR input_integer_format, ADDR number
	pop ebp
	pop [ebp-0]
	pop [ebp-4]
	pop [ebp-8]
	pop [ebp-12]
	mov eax, number
	mov dword ptr [ebp-0], eax
	pop edx
	pop ecx
	pop ebx
	pop eax


;print_int_value 0
	push eax
	push ebx
	push ecx
	push edx
	push [ebp-12]
	push [ebp-8]
	push [ebp-4]
	push [ebp-0]
	push [ebp+4]
	push ebp
	mov eax, [ebp-0]
    ;printf("%d\n", number);
	INVOKE printf, ADDR output_integer_msg_format, eax
	pop ebp
	pop [ebp+4]
	pop [ebp-0]
	pop [ebp-4]
	pop [ebp-8]
	pop [ebp-12]
	pop edx
	pop ecx
	pop ebx
	pop eax


;print_msg
	push eax
	push ebx
	push ecx
	push edx
	push [ebp-12]
	push [ebp-8]
	push [ebp-4]
	push [ebp-0]
	push [ebp+4]
	push ebp
	INVOKE printf, ADDR output_msg_format, ADDR output_msg
	pop ebp
	pop [ebp+4]
	pop [ebp-0]
	pop [ebp-4]
	pop [ebp-8]
	pop [ebp-12]
	pop edx
	pop ecx
	pop ebx
	pop eax


;ld_var 0
	mov eax, [ebp-0]
	mov dword ptr [ebx], eax
	add ebx, 4


;ld_int 0
	mov eax, 0
	mov dword ptr [ebx], eax
	add ebx, 4

;direct_ld_int 0
	mov eax, 0
	mov dword ptr [ebp-0], eax


;store 0
	mov dword ptr [ebp-0], eax


;add -1
	sub ebx, 4
	mov eax, [ebx]
	sub ebx, 4
	mov edx, [ebx]
	add eax, edx
	mov dword ptr [ebx], eax
	add ebx, 4


;sub -1
	sub ebx, 4
	mov eax, [ebx]
	sub ebx, 4
	mov edx, [ebx]
	sub edx, eax
	mov dword ptr [ebx], edx
	add ebx, 4


;mul -1
    sub ebx, 4           
	mov eax, [ebx]       
	sub ebx, 4           
	mov edx, [ebx]       
	imul eax, edx        
	mov dword ptr [ebx], eax  
	add ebx, 4   


;for loop
    mov eax, 0      ;initial value
    mov ebx, 10     ;terminal value
    mov ecx,0       ;result
    
LOOP_:
    cmp eax,ebx
    jge EXIT_

    ;if-else

    jmp increment

;other labels
    
increment:
    add eax, 1
    jmp LOOP_


EXIT_:        
;store result
    mov dword ptr [ebp-0],ecx

;halt -1
	add ebp, 100
	mov esp, ebp
	pop ebp
	ret
main endp
end