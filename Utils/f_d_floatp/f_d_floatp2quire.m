function q=f_d_floatp2quire(bin)
%F_D_FLOATP2QUIRE converts a floatp structure to a quire

% dependencies: f_d_quire2dec

%
% Author = G. Meurant
% May 2020
%

nbits = bin.nbits;
nq = ceil(nbits^2 / 4 - nbits / 2); % this is the standard
nc = nbits - 1;

sig = bin.sign;

q = struct('sign',sig,'C',zeros(1,nc),'I',zeros(1,nq),'F',zeros(1,nq),'float',0,'nq',nq,'nc',nc,'nbits',nbits);

I = bin.I;
F = bin.F;
texp = bin.E;

if texp ~= 0
 % we have to shift
 if texp < 0 % shift right
  F = [I F];
  I = 0;
  F = [zeros(1,abs(texp)-1) F];
 else % shift left
  lF = length(F);
  if lF < texp
   F = [F zeros(1,texp+1-lF)];
  end % if
  I = [I F(1:texp)];
  F = F(texp+1:end);
 end % if
end % if texp

lI = length(I);

if lI < nq 
 % pad with zeros
 I = [zeros(1,nq-lI) I];
 
else
 % a part of I goes to C
 C = I(1:lI-nq);
 I = I(lI-nq+1:end);
 lC = length(C);
 if lC > nc
  error(' f_d_floatp2quire: the number of bits needed for the input is too large for the quire')
 else
  C = [zeros(1,nc-lC) C];
 end % if lC
end % if lI

F = [F zeros(1,nq-length(F))];

q.I = I;
q.F = F;
q.float = f_d_quire2dec(q);
 
 