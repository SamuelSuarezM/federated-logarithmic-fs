function [s,q] = f_d_dot_prod(bina,binb);
%F_D_DOT_PROD dot product of two floatp vector structures using a quire

% dependencies: f_d_dec2quire, f_d_add_floatp2quire, f_d__quire2floatp

%
% Author G. Meurant
% May 2020
%

[na,ma] = size(bina);
[nb,mb] = size(binb);

if na ~= 1 && ma ~= 1 && nb ~= 1 && mb ~= 1
 error(' f_d_dot_prod: the inputs must be vector structures')
end % if

nbitsa = bina(1).nbits;
nbitsb = binb(1).nbits;

if nbitsa ~=  nbitsb
 error(' f_d_dot_prod: the input vectors must have the same value of nbits')
end % if

la = length(bina);
lb = length(binb);
if la ~= lb
 error(' f_d_dot_prod: the two vectors must have the same length')
end % if

 q = f_d_dec2quire(0,nbitsa);
 
 for k = 1:la
  q = f_d_add_floatp2quire(f_d_mul(bina(k),binb(k)),q);
 end % for k
 
 s = f_d_quire2floatp(q);
 
 

 
 