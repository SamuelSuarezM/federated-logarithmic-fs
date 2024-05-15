function [bin,cnext]=f_d_frac2bin(f,nbits,sig);
%F_D_FRAC2BIN converts a fractional part to binary with nbits

% f must be a double, f = ...yy.xxxxx...

% dependencies: f_d_round_bin

%
% Author G. Meurant
% May 2020
%

bin = zeros(1,nbits+5);
temp = f;

for k = 1:nbits+5
 temp = 2 * temp;
 if temp >= 1
  bin(k) = 1;
  temp = temp - 1;
 end % if
end % for

% ###ENGADIDO: Comprobacion si os 5 bits extra son 0 -> non redondear ####

if nargin > 2 && sum(bin(nbits+1:k)) % Default: if nargin > 2
 [bin,cnext] = f_d_round_bin(bin,nbits,sig);
else
 bin = bin(1:nbits);
 cnext = 0;
end % if






