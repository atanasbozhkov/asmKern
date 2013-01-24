[BITS 16]			; 16 bit compiled code
[ORG 0x7C00]		;Origin, that's where the code will be loaded into memory

mov SI, MyString	;Store the string pointer to register si
call PrintString	;Call the PrintString Procedure
jmp $				;Infinite loop

PrintChar:			;PrintChar procedure puts a char on the screen that is in the register AL?

mov AH, 0x0E		;Tell BIOS that I need to print one char on screen
mov BH, 0x00 		;Page num 0
mov BL, 0x02		;Tell BIOS that we need GREEN text (so 1337)

int 0x10 			; call the video interrupt to print the char.

ret 				;return to calling procedure


PrintString:		;Procedure to print a string, assuming that the starting pointer is in register SI

next_character:		;Lable to fetch the next char from string.
mov AL,[SI]			;Get a byte from string and store it in AL register.
inc SI 				;Increment the SI pointer
or AL, AL 			;Check if value in AL is zero (end of string)
jz exit_function	;If end then return
call PrintChar		;Recursion. Yay
jmp next_character  ;
exit_function:		;defining the exit lable
ret 				;return


;Data
MyString db 'This is my first BootLoader. By Nasco',0 	;The string must end with 0.

Times 510 - ($-$$) db 0 									;Fill the rest of the space with zeros.
DW 0xAA55													;Add a boot signature to the end of the bootloader.