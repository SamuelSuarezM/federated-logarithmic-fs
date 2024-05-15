function bincm = f_d_dec2floatp(dec,nbits);
%F_D_DEC2FLOATP double to binary floating point matrix

% nbits bits in the fractional part

% dependencies: d_float_dec2floatp

%
% Author G. Meurant
% May 2020
%

[row,col] = size(dec);

bincm(row,col) = struct('sign',[],'I',[],'F',[],'E',[],'float',[],'nbits',nbits);

for i = 1:row
 for j = 1:col
  bincm(i,j) = d_float_dec2floatp(dec(i,j),nbits);
 end % for j
end % for i



