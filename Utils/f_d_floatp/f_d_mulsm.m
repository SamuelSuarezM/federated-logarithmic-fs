function bincm = f_d_mulsm(bina,binbm);
%F_D_MULSM scalar-matrix product for floating point binary numbers

% bina is a scalar and binbm is a matrix

% bina and binbm must have the same parameters

% dependencies: f_d_mul

%
% Author G. Meurant
% May 2020
%

nbitsa = bina.nbits;
nbitsb = binbm.nbits;
if nbitsa ~= nbitsb
 error(' f_d_mulsm: the two binary elements must have the same parameters')
end % if

bincm = binbm;
[row,col] = size(binbm);

for i = 1:row
 for j = 1:col
  bincm(i,j) = f_d_mul(bina,binbm(i,j));
 end % for j
end % for i



