function bincm = fix_dec2binf3Dm(dec,nbits);
%FIX_DEC2BINFM double to binary fixed point 3D matrix

% nbits bits in the fractional part

% dependancies: fix_dec2binf

[x,y,z] = size(dec);

bincm(x,y,z) = struct('sign',[],'I',[],'F',[],'float',[],'nbits',nbits);

for i = 1:x
 for j = 1:y
     for k = 1:z
        bincm(i,j,k) = fix_dec2binf(dec(i,j,k),nbits);
     end
 end % for j
end % for i
