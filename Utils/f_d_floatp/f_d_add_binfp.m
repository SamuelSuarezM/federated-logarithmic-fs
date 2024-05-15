function binc=f_d_add_binfp(bina,binb);
%F_D_ADD_BINFP addition of two fixed point binary numbers

% bin is a structure containing binary numbers representing the sign, the integer part
% and the fractional part as well as the double precision value if available

% in this function bina and binb must have the same nbits and we do not
% remove the trailing zero bits

% dependencies: f_d_add_bin_carry, f_d_minus_binfp, f_d_bin2dec, f_d_bin2frac

%
% Author G. Meurant
% May 2020
%

if bina(1,1).nbits ~= binb(1,1).nbits
 error(' f_d_add_binfp: the two inputs must have the same value of nbits')
end % if

nbitsa = bina.nbits;
siga = bina.sign;
Ia = bina.I;
Fa = bina.F;
sigb = binb.sign;
Ib = binb.I;
Fb = binb.F;

if sum(Ia) == 0 && sum(Fa) == 0
 binc = binb;
 return
end % if
if sum(Ib) == 0 && sum(Fb) == 0
 binc = bina;
 return
end % if


if (siga == 0 && sigb == 0) || (siga == 1 && sigb == 1)
 % two positive or two negative numbers
 
 % add the fractional parts
 nFa = length(Fa);
 nFb = length(Fb);
 
 % pad the smallest one with zeros
 nF = max(nFa,nFb);
 Fa = [Fa, zeros(1,nF - nFa)];
 Fb = [Fb, zeros(1,nF - nFb)];
 
 % add the two binary strings
 [Fab,cnext] = f_d_add_bin_carry(Fa,Fb,0); 
 
 % is there a carry out? if yes remove it, it goes to I
 if cnext == 1
  Fab = Fab(2:end);
 end % if
 
 % add the integer parts
 nIa = length(Ia);
 nIb = length(Ib);
 
 % pad the smallest one with zeros
 nI = max(nIa,nIb);
 Ia = [zeros(1,nI - nIa), Ia];
 Ib = [zeros(1,nI - nIb), Ib];
 
 % add the two binary strings (with the carry in from F)
 [Iab,cnext] = f_d_add_bin_carry(Ia,Ib,cnext); 
 
 % remove the leading zeros 
 ind = find(Iab);
 if ~isempty(ind)
  minI = ind(1);
  Iab = Iab(minI:end);
 else
  Iab = [];
 end % if
 
 x = f_d_bin2dec(Iab) + f_d_bin2frac(Fab); % double floating point value 
 if siga == 1
  x = -x;
 end % if
 
 binc = struct('sign',siga,'I',Iab,'F',Fab,'float',x,'nbits',nbitsa);
 
else % if siga == 0 ....
 
 % one is positive and one negative
 if siga == 1 % bina < 0, binb > 0
  bina.sign = 0;
  bina.float = abs(bina.float);
  binc = f_d_minus_binfp(binb,bina); % binb - | bina | 
  return
 end % if
 
 if sigb == 1 % bina > 0, binb < 0
  binb.sign = 0;
  binb.float = abs(binb.float);
  binc = f_d_minus_binfp(bina,binb); % bina - | binb | 
  return
 end % if
 
end % if siga == 0 ...





