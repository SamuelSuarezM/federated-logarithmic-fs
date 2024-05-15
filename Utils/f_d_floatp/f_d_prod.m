function binc = f_d_prod(bina,dim);
%F_D_PROD product of vector or matrix binary floating point numbers

% dependencies: f_d_dec2floatp, f_d_mul

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
 binc = f_d_dec2floatp(1,nbits);
 for k = 1:max(na,ma)
  binc = f_d_mul(binc, bina(k)); 
 end % for k
 return
end % if

if dim == 1
 % prod along the columns
 binc = f_d_dec2floatp(zeros(1,ma),nbits);
 for j = 1:ma
  s = f_d_dec2floatp(1,nbits);
  for k = 1:na
   s = f_d_mul(s, bina(k,j)); 
  end % for k
  binc(j) = s;
 end % for j
 
else % dim = 2
 % prod along rows
 binc = f_d_dec2floatp(zeros(na,1),nbits);
 for j = 1:na
  s = f_d_dec2floatp(1,nbits);
  for k = 1:ma
   s = f_d_mul(s, bina(j,k)); 
  end % for k
  binc(j) = s;
 end % for j
 
end % if

