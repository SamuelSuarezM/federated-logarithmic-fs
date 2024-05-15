function bincm = p_dec2binfm(dec,nbits);
%P_DEC2BINFM double to binary fixed point matrix

% nbits bits in the fractional part

%
% Author G. Meurant
% April 2020
%

[row,col] = size(dec);

bincm(row,col) = struct('sign',[],'I',[],'F',[],'float',[],'nbits',nbits);

for i = 1:row
 for j = 1:col
  bincm(i,j) = p_dec2binf(dec(i,j),nbits);
 end % for j
end % for i



