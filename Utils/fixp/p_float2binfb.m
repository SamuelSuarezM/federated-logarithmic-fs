function [bin,binfix]=p_float2binfb(x,nbits);
%GM_FLOAT2BINFB  conversion of a float (double) to fixed point binary

% bin is a structure containing the sign (bin.sign), the integer part (bin.I),
% the fractional part (bin.F) and the float value (bin.float)

% the fractional part is, at most, nbits long

% uses another and simpler method than in p_float2bin

%
% Author G. Meurant
% April 2020
%

bin = 0;
binfix = 0;
xa = abs(x);

% integer part
in = floor(xa);
% fractional part
f = xa - in;

% convert the integer part
I = p_mdec2bin(in,nbits);

% convert the fractional part
F = p_frac2bin(f,nbits);

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

if x > 0
 sig = 0;
else
 sig = 1;
end % if

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
 
 binfix.float = p_binf2dec(binfix);
 
else
 binfix = 0;
 
end % if




