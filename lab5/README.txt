Jose Santiago jlsantia@ucsc.edu Lab5 Section 01A
The purpose of this lab was to learn the logic behind the viginere cipher. I 
believe this lab also served as a way to use functions and arrays in your lab. 
My method was to find out the algorithm behind the vigenere cipher, and from
there I would translate that into MIPS. It was tricky, but I eventually found
the formula for the encryption was (key + text)%128. Afterwards I just needed to
figure out the right order to make my MIPS program work. It is definitely 
difficult working with small pieces of memory, but I wrote down my registers and
values to make it easier. The result was satisfying after hours of work. It is
in proper working function, my code has comments and I have included neat code. 
The similarities between encode and decode are abundant, the differences though
were only in the inputs and the procedures inside my functions. The input change
from encode to decode was from "key and text" to "encription and key". From 
there the formula I described earlier changed to (encription - key)%128. 
Somethings that had to be saved were the encrypted and decripted texts. I had to
store them into an array to store my values as I encrypted bit by bit. 