function q=f_d_dec2quire(x,nbits);
%F_D_DEC2QUIRE  conversion of a float (double) to a quire

% q is a structure containing the sign (q.sign), the carry space (q.C), the integer part (q.I),
% the fractional part (q.F), the float value (q.float), the length of I and F (q.nq),
% the length of C (q.nc) and the value of nbits (q.nbits)

% dependencies: f_d_dec2bin, f_d_frac2bin

%
% Author G. Meurant
% May 2020
%

nq = ceil(nbits^2 / 4 - nbits / 2); % this is the standard
nc = nbits - 1;

if isempty(x)
 q = struct('sign',0,'C',zeros(1,nc),'I',zeros(1,nq),...
  'F',zeros(1,nq),'float',0,'nq',nq,'nc',nc,'nbits',nbits);
 return
end % if

x = double(x);

if x > 0
 sig = 0;
else
 sig = 1;
end % if

xa = abs(x);

% integer part
in = floor(xa);
% fractional part
f = xa - in;

% convert the integer part
I = f_d_dec2bin(in);
lI = length(I);

if lI < nq 
 % pad with zeros
 I = [zeros(1,nq-lI) I];
 C = zeros(1,nc);
 
else
 % a part of I goes to C
 C = I(1:lI-nq);
 I = I(lI-nq+1:end);
 lC = length(C);
 if lC > nc
  error(' f_d_dec2quire: the number of bits needed for the input is too large for the quire')
 else
  C = [zeros(1,nc-lC) C];
 end % if lC
end % if lI

% convert the fractional part (no rounding)
F = f_d_frac2bin(f,nq);

 q = struct('sign',sig,'C',C,'I',I,'F',F,'float',x,'nq',nq,'nc',nc,'nbits',nbits);





