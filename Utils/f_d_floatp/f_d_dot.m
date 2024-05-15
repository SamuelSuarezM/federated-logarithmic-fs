function s = f_d_dot(binav,binbv);
%F_D_DOT dot product of two binary floating point vectors

% the result may not be accurate. If not use an accumulator (quire)

% binav and binbv must have the same parameters

% dependencies: f_d_mul, f_d_add

%
% Author G. Meurant
% March 2020
%

na = length(binav);
nb = length(binbv);
if na ~= nb
 error(' f_d_dot: the two binary vectors must have the same length')
end % if

nbitsa = binav.nbits;
nbitsb = binbv.nbits;
if nbitsa ~= nbitsb
 error(' f_d_dot: the two binary vectors must have the same parameters')
end % if

s = f_d_dec2floatp(0,nbitsa); % s = 0

for k = 1:na
 product = f_d_mul(binav(k),binbv(k));
 s = f_d_add(s,product);
end % for k

% we could have use f_d_mulm to do the product of binav and binbv and then f_d_sum