function bin = f_d_quire2floatp(q);
%F_D_QUIRE2FLOATP convert a quire structure to a floatp structure with same nbits

% this is not always possible if the quire cannot be represented by the floatp? We must check that

% dependencies: f_d_dec2floatp, f_d_roound_bin, f_d_bin2frac

%
% Author G. Meurant
% May 2020
%

nbits = q.nbits;

sig = q.sign;
C = q.C;
I = q.I;
F = q.F;

if sum(C)+sum(I)+sum(F) == 0
 % q is zero
 bin = f_d_dec2floatp(0,nbits);
 return
end % if

% shift the C, I part to obtain 1.xxx... 2^e and compute the exponent e

I = [C I];
ind = find(I);

if ~isempty(ind)
 % we have to shift right
 ind1 = ind(1);
 F = [I(ind1+1:end) F];
 e = length(I(ind1+1:end));
 I = uint8(1);
 
else % I is zero, we have to shift F to the left
 ind = find(F); % F cannot be zero
 ind1 = ind(1);
 I = uint8(1);
 F = F(ind1+1:end);
 e = -ind1;
 
end % if

% round F
[F,cnext] = f_d_round_bin(F,nbits,sig);
if cnext == 1 % there is a carry, I = [0 1] -> [1,0]
 F = [uint8(0) F(1:nbits-1)]; % we shift right and chop F
end % if

bin = struct('sign',sig,'I',I,'F',F,'E',e,'float',0,'nbits',nbits);

x = (1 + f_d_bin2frac(F)) * 2^e;
bin.float = x;







