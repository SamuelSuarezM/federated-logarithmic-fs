function binc = f_d_mat_prod(bina,binb);
%F_D_MAT_PROD floating point matrix-matrix product

% inputs are assumed to have compatible dimensions

% dependencies: f_d_dec2floatp, f_d_add, f_d_mul

%
% Author G. Meurant
% May 2020
%

[na,ma] = size(bina);
[nb,mb] = size(binb);

nbits = min(bina(1,1).nbits,binb(1,1).nbits);

% ma must be equal to na

binc = f_d_dec2floatp(zeros(na,mb),nbits);

for i = 1:na
 for j = 1:mb
  s = f_d_dec2floatp(0,nbits);
  
  for k = 1:ma
   bbina = bina(i,k);
   bbinb = binb(k,j);
   if (isempty(bbina.I) && sum(bbina.F) == 0) || (isempty(bbinb.I) && sum(bbinb.F) == 0)
    continue
   else
   s = f_d_add(s, f_d_mul(bina(i,k), binb(k,j)));
   end
  end % for k
  
  binc(i,j) = s;
  
 end % for j
end % for i

