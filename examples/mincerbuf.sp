# Create buffer with length 80000 samples
'buf' 80000 zeros

# Create a sequence
'seq' '0 2 7 11 14 4 2' gen_vals

# tick can only be used once in a sporth patch, so put it in a p-register
tick 0 pset

# our maygate clock with a guaranteed start
0 p 1 metro 0.7 maytrig + 
# duplicate the clock signal for tseq and pluck
dup

# sequence through the table
0 'seq' tseq 
# bias 61 (Db major) and convert to frequency for pluck
61 + mtof 
0.5 400 pluck 1000 butlp

# delayz for dayz
dup 0.6 0.75 delay 1000 buthp 0.7 * +

# reverb 
dup dup 10 10 8000 zrev 0.5 * drop +

# duplicate our entire signal and record it in buffer
dup 0 p 'buf' tblrec 

# mincer object shuffles through recording buffer
0 'buf' tbldur 10 randi 1 1 2048 'buf' mincer 

# Sum mincer with everything else
+

