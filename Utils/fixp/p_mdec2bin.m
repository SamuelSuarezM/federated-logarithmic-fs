function bin = p_mdec2bin(input,bsize);
%P_MDEC2BIN converts a decimal integer to binary (with digits in the array bin of length bsize)

% see p_dec2bin for a better implementation

if (2^bsize <= input)
 fprintf(' p_mdec2bin: the output array size is too small, the output could be wrong\n'); 
 % it must be at least ceil(log2(input))+1 ?
 bsize = 2 * bsize;
end % if

bin = zeros([1 bsize]);

for i = 1:bsize
 rmod = mod(input, 2^(bsize-i));
 
 if (rmod < input)
  input = rmod;
  bin(i) = 1;
 end % if
 
end % for i

% better implementation?

% str = dec2bin(input);
% ls = length(str);
% bin = zeros(1,ls);
% for k = 1:ls
%  bin(k) = str2double(str(k));
% end % for k





