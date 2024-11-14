ASSUME CS:CODE,DS:DATA
DATA SEGMENT
    MSG1 DB 0AH,0DH, "ENTER STRING: $"
    MSG2 DB 0AH,0DH, "VOWELS COUNT: $"
    INPUT DB 50 DUP("$")
DATA ENDS
CODE SEGMENT
START:
    MOV AX,DATA
    MOV DS,AX
    LEA DX,MSG1
    MOV AH,09H
    INT 21H
    LEA DX,INPUT
    MOV AH,0AH
    INT 21H
    MOV CL,[INPUT+1]
    MOV SI, OFFSET [INPUT+2]
    XOR BL,BL
    LABEL1:
        MOV AL,[SI]
        AND AL,5FH
        CMP AL,'A'
        JE IS_VOWEL
        CMP AL,'E'
        JE IS_VOWEL
        CMP AL,'I'
        JE IS_VOWEL
        CMP AL,'O'
        JE IS_VOWEL
        CMP AL,'U'
        JE IS_VOWEL
        JMP NEXT

    IS_VOWEL:
        INC BL
    NEXT:
        INC SI
        LOOP LABEL1
    LEA DX,MSG2
    MOV AH,09H
    INT 21H
    CMP BL,0AH
    JB DIGIT
    ADD BL,07H
    DIGIT:
        ADD BL,'0'
        MOV DL,BL
        MOV AH,02H
        INT 21H
    MOV AH,4CH
    INT 21H
CODE ENDS
END START