function s = p_dot_binf(binav,binbv);
%P_DOT_BINF dot product of two binary fixed point vectors

% the result may not be accurate. If not use quires

% binav and binbv must have the same parameters

%
% Author G. Meurant
% March 2020
%

na = length(binav);
nb = length(binbv);
if na ~= nb
 error(' p_dot_binf: the two binary vectors must have the same length')
end % if

nbitsa = binav.nbits;
nbitsb = binbv.nbits;
if nbitsa ~= nbitsb
 error(' p_dot_binf: the two binary vectors must have the same parameters')
end % if

s = p_dec2binf(0,nbitsa); % s = 0

% We could have use mulv for the product and then sum

for k = 1:na
 product = p_mul_binf(binav(k),binbv(k));
 s = p_add_binf(s,product);
end % for k

