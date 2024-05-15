function b=f_d_binary(bin);
%F_D_BINARY prints the fields of a floating point structure

% dependencies: f_d_bin2str

%
% Author G. Meurant
% May 2020
%

[n,m] = size(bin);

b = cell(n,m);

for i = 1:n
 for j = 1:m
  p = bin(i,j);
  sig = p.sign;
  I = p.I;
  F = p.F;
  E = p.E;
  b(i,j) = {[ num2str(sig) ' ' f_d_bin2str(E) ' ' f_d_bin2str(I) ' ' f_d_bin2str(F) ]};
 end % for j
end % for i

