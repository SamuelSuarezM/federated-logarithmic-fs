function bin=p_dec2binf(x,nbits);
%P_DEC2BINF converts a double float to binary fixed point

% the mantissa of bin has nbits bits

%
% Author G. Meurant
%

[b,bin] = p_float2binfb(x,nbits);

