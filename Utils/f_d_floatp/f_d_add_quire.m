function qc=f_d_add_quire(qa,qb);
%F_D_ADD_QUIRE addition of two quires qa + qb

% q is a structure bin.sign, bin.C, bin.I, bin.F, bin.float containing binary numbers
% representing the sign, the integer parts and the fractional part as well
% as the double precision value if available

% in this function qa and qb must have the same nbits 

% dependencies: f_d_add_bin_carry, f_d_minus_quire

%
% Author G. Meurant
% May 2020
%

if qa(1,1).nbits ~= qb(1,1).nbits
 error(' f_d_add_quire: the two quires must have the same value of nbits')
end % if

siga = qa.sign;
Ia = [qa.C qa.I];
Fa = qa.F;
sigb = qb.sign;
Ib = [qb.C qb.I];
Fb = qb.F;
nq = qa.nq;
nc = qa.nc;

if sum(Ia) + sum(Fa) == 0
 qc = qb;
 return
end % if
if sum(Ib) + sum(Fb) == 0
 qc = qa;
 return
end % if

qc = qa;

if (siga == 0 && sigb == 0) || (siga == 1 && sigb == 1)
 % two positive or two negative numbers
  
 % add the fractional parts
 
 % add the two binary strings
 [Fab,cnext] = f_d_add_bin_carry(Fa,Fb,0);

 % was there a carry out? if yes remove it, it goes to I
 if cnext == 1
  Fab = Fab(2:end);
 end % if
 lF = length(Fab);
 if lF < nq
  Fab = [Fab zeros(1,nq-lF)];
 end % if
 
 % add the integer parts
 
 % add the two binary strings (with the carry in from F)
 [Iab,cnext] = f_d_add_bin_carry(Ia,Ib,cnext); % the carry out was already added to Iab
 
 % look for C and I
 ind = find(Iab);
 if isempty(ind)
  C = zeros(1,nc);
  Iab = zeros(1,nq);
  
 else
  ind1 = ind(1);
  II = Iab(ind1:end);
  lII = length(II);
  if lII <= nq
   Iab = [zeros(1,nq-lII), II];
   C = zeros(1,nc);
  else % a part goes to C
   C = [zeros(1,nc-(lII-nq)) II(1:lII-nq)];
   if length(C) > nc
    error(' f_d_add_quire: the result is too large for the quire')
   end % if
   Iab = II(lII-nq+1:end);
  end % if lII
  
 end % if isempty
 
 qc = qa;
 qc.sign = siga;
 qc.C = C;
 qc.I = Iab;
 qc.F = Fab;
 qc.float = f_d_quire2dec(qc);
  
else
 
 % one is positive and one negative
 if siga == 1
  qa.sign = 0;
  qa.float = abs(qa.float);
  qc = f_d_minus_quire(qb,qa); 
  return
 end % if
 
 if sigb == 1
  qb.sign = 0;
  qb.float = abs(qb.float);
  qc = f_d_minus_quire(qa,qb);
  return
 end % if

end % if siga








