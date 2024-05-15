function binc=f_d_abs(bina);
%F_D_ABS absolute value of a binary floating point number

%
% Author G. Meurant
% May 2020
%

binc = bina;

[na,ma] = size(bina);

for i = 1:na
 for j = 1:ma
  binc(i,j).sign = 0;
 end % for j
end % for j



