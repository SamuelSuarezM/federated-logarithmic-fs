function binc = f_d_sum(bina,dim);
%F_D_SUM sum of vector or matrix binary floating point numbers

% dependencies: f_d_add, f_d_dec2floatp
%
% Author G. Meurant
% May 2020
%

[na,ma] = size(bina);
nbits = bina.nbits;
if nargin == 1
 dim = 1;
end % if

if na == 1 || ma == 1
 % vector case
 binc = f_d_dec2floatp(0,nbits);
 for k = 1:max(na,ma)
  binc = f_d_add(binc, bina(k)); % simple summation
 end % for k
 return
end % if

if dim == 1
 % sum along the columns
 binc = f_d_dec2floatp(zeros(1,ma),nbits);
 for j = 1:ma
  s = f_d_dec2floatp(0,nbits);
  for k = 1:na
   s = f_d_add(s, bina(k,j)); % simple summation
  end % for k
  binc(j) = s;
 end % for j
 
else % dim = 2
 %sum along rows
 binc = f_d_dec2floatp(zeros(na,1),nbits);
 for j = 1:na
  s = f_d_dec2floatp(0,nbits);
  for k = 1:ma
   s = f_d_add(s, bina(j,k)); % simple summation
  end % for k
  binc(j) = s;
 end % for j
 
end % if

