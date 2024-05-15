function decm = p_binf2decm(binm);
%P_BINF2DECM  binary fixed point to double matrix

% nbits bits in the fractional part

%
% Author G. Meurant
% April 2020
%

[row,col] = size(binm);
decm = zeros(row,col);

for i = 1:row
 for j = 1:col
  decm(i,j) = p_binf2dec(binm(i,j));
 end % for j
end % for i



