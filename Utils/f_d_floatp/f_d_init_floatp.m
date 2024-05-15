function binc=f_d_init_floatp(sig,I,F,E,fl,nbits);
%F_D_INIT_FLOATP construction a floatp structure from its elements

% I and F are array of doubles containing 0s and 1s, E is a double that must be a signed integer
% fl is the floating point value and nbits is the number of bits in F

% no dependencies

%
% Author G. Meurant
% May 2020
%


binc = struct('sign',sig,'I',I,'F',F,'E',E,'float',fl,'nbits',nbits);


