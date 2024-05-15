function [bin,binfix]=fix_float2binfb(x,nbits);
%FIX_FLOAT2BINFB  conversion of a float (double) to fixed point binary

% bin is a structure containing the sign (bin.sign), the integer part (bin.I),
% the fractional part (bin.F) and the float value (bin.float)

% the fractional part is, at most, nbits long

% uses another and simpler method than in fix_float2bin

%
% Author G. Meurant
% April 2020
%

if isempty(x)
 bin = struct('sign',[],'I',[],'F',[],'float',[],'nbits',nbits);
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


%{
% ###ENGADIDO: comprobacion bits parte enteira ###
%ibits = 3;
max_int_value = (pow2(ibits));

if in >= max_int_value
    in = max_int_value - 1;

    %parte fraccional max representable?
    f = 1 - pow2(-nbits);
end
%}

% convert the integer part
I = f_d_dec2bin(in);

% convert the fractional part with rounding
[F,cnext] = f_d_frac2bin(f,nbits,sig);

% if cnext = 1, we have a carry to I
if cnext ~= 0 
 [I,cnex] = f_d_add_bin_one_carry(I);
 if cnex == 1
  I = [1 I];
 end % if
end % if

% remove the heading and trailing zeros in bin
nq = length(F);
ind = find(I);

if ~isempty(ind)
 minI = ind(1);
 
else
 minI = 0;
end % if

ind = find(F);
if ~isempty(ind)
ind = find(F(nq:-1:1));
maxF = nq - ind(1) + 1;

else
 % F is a vector of zeros
 maxF = 1;
end % if

if minI ~= 0
II = I(minI:length(I));

else
 II = [];
end % if

FF = F(1:maxF);

bin = struct('sign',sig,'I',II,'F',FF,'float',x);

if nargout == 2
 
%  if nbits > length(I)
%   I = [zeros(1,nbits-length(I)), I];
%  end % if
 
 if nbits > length(F)
  F = [F, zeros(1,nbits - length(F))];
  
 elseif nbits < length(F)
  F = F(1:nbits);
 end % if
 
 binfix = struct('sign',sig,'I',II,'F',F,'float',x,'nbits',nbits);
 
 binfix.float = fix_binf2dec(binfix);
 
else
 binfix = 0;
 
end % if




