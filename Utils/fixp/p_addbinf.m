function binc=p_addbinf(bina,binb);
%P_ADDBINF addition of two fixed point binary numbers

% bin is a structure bin.sign, bin.I, bin.F, bin.float containing binary numbers
% representing the sign, the integer part and the fractional part as well
% as the double precision value if available

% in this function we remove the trailing zero bits

%
% Author G. Meurant
% April 2020
%

siga = bina.sign;
Ia = bina.I;
Fa = bina.F;
sigb = binb.sign;
Ib = binb.I;
Fb = binb.F;

if p_iszero_binf(bina) == 1
 binc = binb;
 return
end % if
if p_iszero_binf(binb) == 1
 binc = bina;
 return
end % if


if (siga == 0 && sigb == 0) || (siga == 1 && sigb == 1)
 % two positive or two negative numbers
 
 xf = bina.float + binb.float; % could be []

 binc = struct('sign',siga,'I',[],'F',[],'float',xf,'nbits',bina.nbits);
 
 % add the fractional parts
 nFa = length(Fa);
 nFb = length(Fb);
 
 % pad the smallest one with zeros
 nF = max(nFa,nFb);
 Fa = [Fa, zeros(1,nF - nFa)];
 Fb = [Fb, zeros(nF - nFb)];
 
 % add the two binary strings
 [Fab,cnext] = p_add_bin_carry(Fa,Fb,0);
 
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
 [Iab,cnext] = p_add_bin_carry(Ia,Ib,cnext);
 
 % remove the leading and trailing zeros
 lI = length(Iab);
 lF = length(Fab);
 
 ind = find(Iab);
 if ~isempty(ind)
  minI = ind(1);
  Iab = Iab(minI:end);
 else
  Iab = [];
 end % if
 
 ind = find(flip(Fab));
 if ~isempty(ind)
  Fab = Fab(1:length(Fab)-ind(1)+1);
 else
  % Fab is a vector of zeros or empty
  Fab = [];
 end % if
 
 binc.I = Iab;
 binc.F = Fab;
 
else
 
 % one is positive and one negative
 if siga == 0
  binc = p_minus_binf(bina,binb); % bina - binb TO BE DONE !!!!!!!!!!!!!!!
 else
  binc = p_minus_binf(binb,bina); % binb - bina
 end % if
 
end % if





