function bin=fix_dec2binf(x,nbits);
%FIX_DEC2BINF converts a double float to binary fixed point

% the mantissa of bin has nbits bits

% dependancies: fix_float2binfb

%
% Author G. Meurant
%

[b,bin] = fix_float2binfb(x,nbits);

