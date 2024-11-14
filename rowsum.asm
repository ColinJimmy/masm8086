ASSUME CS:CODE,DS:DATA
DATA SEGMENT
    MSG1 DB 0AH,0DH, "ENTER NUMBER OF ROWS: $"
    MSG2 DB 0AH,0DH, "ENTER NUMBER OF COLUMNS: $"
    MSG3 DB 0AH,0DH, "ENTER ELEMENTS: $"
    MSG4 DB 0AH,0DH,"ROWSUM IS: $"
    ARR DB 70H DUP("$")
    R DB ?
    C DB ?
DATA ENDS
CODE SEGMENT
START:
    MOV AX,DATA
    MOV DS,AX

    LEA DX,MSG1
    MOV AH,09H
    INT 21H
    MOV AH,01H
    INT 21H
    SUB AL,30H
    MOV R,AL

    LEA DX,MSG2
    MOV AH,09H
    INT 21H
    MOV AH,01H
    INT 21H
    SUB AL,30H
    MOV C,AL

    MOV CL,R
    MOV CH,C

    LEA SI,ARR
    LEA DX,MSG3
    MOV AH,09H
    INT 21H
    READ:
        MOV AH,01H
        INT 21H
        SUB AL,30H
        MOV [SI],AL
        INC SI
        DEC CH
        JNZ READ
        MOV CH,C
        DEC CL
        JNZ READ

    MOV CL,R
    MOV CH,C
    LEA SI,ARR

    LEA DX,MSG4
    MOV AH,09H
    INT 21H

    LOOP1:
        MOV AL,0H
        MOV BL,C
    
    LOOP2:
        ADD AL,[SI]
        INC SI
        DEC BL
        JNZ LOOP2
        
        CMP AL,0AH
        JB DIGIT
        ADD AL,7H
        DIGIT:
            ADD AL,'0'
            MOV DL,AL
            MOV AH,02H
            INT 21H
            DEC CL
            JNZ LOOP1

        MOV AH,4CH
        INT 21H
CODE ENDS
END START


