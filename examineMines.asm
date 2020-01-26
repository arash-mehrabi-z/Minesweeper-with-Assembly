.386
.model flat, C
.stack 4096

countMines PROTO,
	array : PTR DWORD, i : DWORD, m : DWORD, n : DWORD


.data
	counter DWORD ? ; stores number of bomb in adjacent elements
	nhelp DWORD ? ; ; if we want to modify the variable "n", we do it by help of this.
	adr DWORD ? ; stores the address of a element of the array.
.code

;----------------------------------------------------------------
;Calculates and returns (in eax) the address fo j elements before or after this a[i].
;if proceed = 1 then it will return &a[i + j] otherwise it will return &a[i - j].
; arr is the address of a[i].
;----------------------------------------------------------------
Address PROC uses ebx,
	a : DWORD, j : DWORD, proceed : DWORD
	
	mov eax, j
	mov ebx, TYPE a
	mul ebx ; eax = 4*j
	mov ebx, a ; ebx = &a = &a[i]
	cmp proceed, 1
	je AFTER
	sub ebx, eax; now eax = &a[i - j]
	mov eax, ebx
	jmp EXIT
AFTER:
	add eax, ebx; now eax = &a[i + j]
EXIT:
	ret
Address ENDP

;----------------------------------------------------------------
; Recieves the adrress of a element of the array as a parameter
; Adds 1 to the counter if it is.
;----------------------------------------------------------------
isItBomb PROC uses ebx,
	adrs : DWORD
	mov ebx, adrs
	mov eax, [ebx]
	cmp eax, -1
	je BOMB
	jmp EXIT
BOMB:
	add counter, 1
EXIT:
	ret
isItBomb ENDP
;----------------------------------------------------------------
; Counts the number of mines in adjacent elements of matrix(array)
; and stores it in arr[i] .
;----------------------------------------------------------------
countMines PROC uses edx ebx, 
	array : PTR DWORD, i : DWORD, m : DWORD, n : DWORD
	mov counter, 0 ; counter will stores number of adjacent bombs and initialized with 0

	;in this section we examine if it is bomb or not and if it is
	; we just exit from procedure.
	mov edx, array
	mov ebx, [edx] ; ebx = array[i]
	cmp ebx, -1 ; if array[i] is bomb
	je EXIT

	;if it is not a bomb count # of bombs in adjacent elements.
	
	;examining element of north west.
	mov eax, n
	add eax, 3
	mov nhelp, eax
	INVOKE Address, array, nhelp, 0
	mov adr,eax ; adrs = the address of north west element
	INVOKE isItBomb, adr

	;examining element of north .
	mov eax, n
	add eax, 2
	mov nhelp, eax
	INVOKE Address, array, nhelp, 0
	mov adr,eax ; adrs = the address of north element
	INVOKE isItBomb, adr

	;examining element of north east .
	mov eax, n
	add eax, 1
	mov nhelp, eax
	INVOKE Address, array, nhelp, 0
	mov adr,eax ; adrs = the address of north east element
	INVOKE isItBomb, adr

	;examining element of west .
	mov eax, 1
	mov nhelp, eax
	INVOKE Address, array, nhelp, 0
	mov adr,eax ; adrs = the address of west element
	INVOKE isItBomb, adr

	;examining element of east .
	mov eax, 1
	mov nhelp, eax
	INVOKE Address, array, nhelp, 1
	mov adr,eax ; adrs = the address of east element
	INVOKE isItBomb, adr

	;examining element of south west .
	mov eax, n
	add eax, 1
	mov nhelp, eax
	INVOKE Address, array, nhelp, 1
	mov adr,eax ; adrs = the address of south west element
	INVOKE isItBomb, adr

	;examining element of south .
	mov eax, n
	add eax, 2
	mov nhelp, eax
	INVOKE Address, array, nhelp, 1
	mov adr,eax ; adrs = the address of south element
	INVOKE isItBomb, adr

	;examining element of south east .
	mov eax, n
	add eax, 3
	mov nhelp, eax
	INVOKE Address, array, nhelp, 1
	mov adr,eax ; adrs = the address of south east element
	INVOKE isItBomb, adr

	mov eax, array ; eax = &a[i]
	mov ebx, counter
	mov [eax], ebx ; a[i] = counter
EXIT:
	ret
countMines ENDP
END