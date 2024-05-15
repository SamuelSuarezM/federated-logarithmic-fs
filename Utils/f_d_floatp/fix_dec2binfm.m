function bincm = fix_dec2binfm(dec,nbits);
%FIX_DEC2BINFM double to binary fixed point matrix

% nbits bits in the fractional part

% dependancies: fix_dec2binf

%
% Author G. Meurant
% April 2020
%

[row,col] = size(dec);

bincm(row,col) = struct('sign',[],'I',[],'F',[],'float',[],'nbits',nbits);

for i = 1:row
 for j = 1:col
  bincm(i,j) = fix_dec2binf(dec(i,j),nbits);
 end % for j
end % for i



