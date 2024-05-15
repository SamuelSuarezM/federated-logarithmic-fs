function bin=f_d_right_shift(bina,k,sig);
%F_D_RIGHT_SHIFT shift bina to the right by k places

% bina is a nonzero normalized floating point number 1.xxxx... 2^e

% dependencies: f_d_round_bin

%
% Author G. Meurant
% May 2020
%

k = abs(k); % k must be positive

bin = bina;

if k == 0
 return
end % if

F = [zeros(1,k-1,'uint8') uint8(1) bin.F];
[F,cnext] = f_d_round_bin(F,bin.nbits,sig); % round the mantissa to nbits

if cnext == 1
 bin.I = 1;
else
 bin.I = [];
end % if

bin.F = F;
bin.E = bin.E + k;


