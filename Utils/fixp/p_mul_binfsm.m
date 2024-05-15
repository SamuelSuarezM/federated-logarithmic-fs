function bincm = p_mul_binfsm(bina,binbm);
%P_MUL_BINFSM scalr-matrix product for fixed point binary

% bina is a scalar and binbm is a matrix

% bina and binbm must have the same parameters

%
% Author G. Meurant
% April 2020
%

nbitsa = bina.nbits;
nbitsb = binbm.nbits;
if nbitsa ~= nbitsb
 error(' p_mul_binfsm: the two binary elements must have the same parameters')
end % if

bincm = binbm;
[row,col] = size(binbm);

for i = 1:row
 for j = 1:col
  bincm(i,j) = p_mul_binf(bina,binbm(i,j));
 end % for j
end % for i



