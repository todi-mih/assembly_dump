# assembly_dump

A directory that i made along the way through computer engineering with small assembly 
programs (x86 nasm mostly 32-bit).
Assembly is not the easiest language to learn so if you need help with solving a diverse 
section of programs i hope maybe you can find what you need here,I created this repo for 
educational purposes and I hope it helps others learn and experiment with low-level programming.

how to run them? do these 3 commands

nasm -f elf32 program.asm -o program.o  
gcc -m32 program.o -o program  
./program  

just replace the name program.asm with whatever i have named the file.
