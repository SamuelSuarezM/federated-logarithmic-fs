function f_d_init_bits_expo(nbits);
%F_D_INIT_BITS_EXPO initializes the number of bits of the exponents for floatp

% nbits = number of bits in the exponent
% 5 for half precision, 8 for single, 11 for double, 15 for quad

% min expo corresponds to subnormal numbers

% no dependencies

%
% Author G. Meurant
% May 2020
%

global bits_expo min_expo max_expo

if isempty(nbits) || nbits == 0
 bits_expo = 0;
 min_expo = -Inf;
 max_expo = Inf;
 return
end % if

bits_expo = nbits;
n = 2^(nbits-1);
max_expo = n - 1;
min_expo = -max_expo + 1;


