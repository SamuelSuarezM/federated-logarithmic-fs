function qc=f_d_minus_quire(qa,qb);
%F_D_MINUS_QUIRE subtraction of two quires, bina - binb

% q is a structure bin.sign, bin.C, bin.I, bin.F, bin.float containing binary numbers
% representing the sign, the integer parts and the fractional part as well
% as the double precision value if available

% in this function qa and qb must have the same nbits 

% dependencies: f_d_add_quire, f_d_minus_bin, f_d_isge_bin, f_d_quire2dec

%
% Author G. Meurant
% May 2020
%

if qa.nbits ~= qb.nbits
 error(' f_d_minus_quire: the two inputs must have the same value of nbits')
end % if

nq = qa.nq;
nc = qa.nc;

siga = qa.sign;
Ca = qa.C;
Ia = qa.I;
Fa = qa.F;
sigb = qb.sign;
Cb = qb.C;
Ib = qb.I;
Fb = qb.F;

if sum(Ca)+sum(Ia)+sum(Fa) == 0 % qa is zero
 qc = qb;
 qc.sign = ~qb.sign;
 qc.float = -qb.float;
 return
end % if

if sum(Cb)+sum(Ib)+sum(Fb) == 0 % qb is zero
 qc = qa;
 return
end % if

% we have to look at the signs and the absolute values

qc = qa;

if siga == 0 && sigb == 1 % binc = bina + | binb |
 qb.sign = 0;
 qb.float = -qb.float;
 qc = f_d_add_quire(qa,qb);
 return
end % if

if siga == 1 && sigb == 0 % binc = -( | bina | + binb)
 qa.sign = 0;
 qa.float = -qa.float;
 qc = f_d_add_quire(qa,qb);
 qc.sign = 1;
 qc.float = -qc.float;
 return
end % if

if siga == 0 && sigb == 0 % two positive quires
 ba = [Ca Ia Fa];
 bb = [Cb Ib Fb];
  
 if f_d_isge_bin(ba,bb) % a > b
  qc = qa;
  [bin,cnext] = f_d_minus_bin(ba,bb,0);
  % F = last nq bits of bin
  ls = length(bin);
  qc.F = bin(ls-nq+1:end);
  Iab = bin(1:ls-nq);
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
     error(' f_d_minus_quire: the result is too large for the quire')
    end % if
    Iab = II(lII-nq+1:end);
   end % if lII
   
  end % if isempty
 
  qc.C = C;
  qc.I = Iab;
  qc.sign = 0;
  qc.float = f_d_quire2dec(qc);
  
  return
  
 else % a < b
  qc = f_d_minus_quire(qb,qa);
  qc.sign = ~qc.sign;
  qc.float = - qc.float;

  return
  
 end % if fix_isge
 
end % if siga

if siga == 1 && sigb == 1
 qa.sign = 0;
 qa.float = -qa.float;
 qb.sign = 0;
 qb.float = -qb.float;
 ba = [Ca Ia Fa];
 bb = [Cb Ib Fb];
 
 if f_d_isge_bin(ba,bb) % | a | >= | b |, binc = -(| a | - | b |)
  qc = f_d_minus_quire(qa,qb);
  qc.sign = ~qc.sign;
  qc.float = -qc.float;
  return
  
 else % | a | < | b |, binc = | b | - | a |
  qc = f_d_minus_quire(qb,qa);
  return
  
 end % if isge
 
end % if siga



