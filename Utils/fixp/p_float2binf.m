function [bin,binfix]=p_float2binf(x,nbits);
%P_FLOAT2BINF  conversion of a float (double) to fixed point binary

% bin is a structure containing the sign (bin.sign), the integer part (bin.I),
% the fractional part (bin.F) and the float value (bin.float)

% the fractional part is, at most, nbits long

% binfix is similar to bin with the trailing zeros not removed
% it is not a real quire

% xstr is a character string

bin = 0;

shortfixedpoint = 1;
lb = 's'; % or 'h' ?????;
Precision = nbits; % ??????
UnderFlow = 'g';
Emin = -1022;
Ebias = -Emin + 1;
Emax = 1023;

iv = 0;
iv = iv + 1;

[f,e] = log2(x);
f = f * 2;
e = e - 1;

if e < Emin
 f = pow2(f,e-Emin);
 e = Emin;
end % if

if e > Emax
 f = pow2(f,e-Emax);
 e = Emax;
end % if

if isequal(f,0)
 e = Emin;
end % if

xstr = '';
fa = abs(f);
% sign !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
if x >= 0
 xstr = '+';
 sig = 0;
else
 xstr = '-';
 sig = 1;
end % if

if isnan(fa)
 xstr = [xstr,'NaN'];
 
elseif ~isfinite(fa)
 xstr = [xstr,'Inf'];
 
else
 blength = Precision;
 
 for ii = 1:blength
  
  if ii == Precision + 1
   xstr = [xstr,' ('];
  elseif (ii > 4) && (rem(ii,4) == 2)
   xstr = [xstr,' '];
  end % if ii
  
  if ii == 1
   
   if fa > 0
    excessintbits = floor(log2(fa));
   else
    excessintbits = 0;
   end % if fa
   
   blmod = 0;
   
   for ib = 1:excessintbits
    if strcmp(lb,'h')
     error(' Mantissa >= 2 with hidden leading bit')
    end % if
    xstr = [xstr,num2str(fa >= pow2(excessintbits - ib + 1))];
    fa = fa - pow2(excessintbits - ib + 1);
    blmod = blmod + 1;
   end % for ib
   
   if strcmp(lb,'h')
    xstr = [xstr,'('];
   end % if
   
  end % if ii
  
  if fa >= pow2(1 - ii)
   xstr = [xstr,'1'];
   fa = fa - pow2(1 - ii);
   if ii==1
    ebin = e;
   end % if
   
  else
   xstr = [xstr,'0'];
   if (ii==1) && strcmp(UnderFlow,'g')
    ebin = e - 1;
   end % if
   
  end % if fa

  if ii == 1
   
   if strcmp(lb,'h')
    xstr = [xstr,')'];
   end % if
   
   %if strcmp(lb,'s'), xstr=[xstr,'(']; end
   xstr = [xstr,'('];
   xstr = [xstr,'.'];
   xstr =[ xstr,')'];
  end % if ii
  
  if isequal(ii,blength-blmod)
   break
  end % if
  
 end % for ii
 
 % end of significand
 
 if shortfixedpoint
  
  ind = [strfind(xstr,'('), strfind(xstr,' '), strfind(xstr,')')];
  
  if ~isempty(ind)
   xstr(ind) = '';
  end % if
  
  ind = strfind(xstr,'.');
  
  if ebin > 0
   if length(xstr) - ind < ebin
    xstr = [xstr, char('0' * ones(1,ebin - length(xstr) + ind))];
   end % if length
   
   xstr = [xstr(1:ind-1), xstr(ind+1:ind+ebin), '.', xstr(ind+ebin+1:end)];
   
  elseif ebin < 0
   xstr = [xstr(1), char('0' * ones(1,-ebin-1)), xstr(2:end)];
   ind = strfind(xstr,'.');
   xstr = [xstr(1),'.', xstr(2:ind-1), xstr(ind+1:end)];
  end % if ebin
  
  while strcmp(xstr(end),'0') && ((length(xstr) > 3) || any(strfind(xstr,'1')))
   xstr(end) = '';
  end % while
  
  if strcmp(xstr(end),'.')
   xstr(end) = '';
  end % if
  
 else % if shortfixed point
  % Exponent:
  ebin = ebin + Ebias;
  
  if isequal(Emin,Emax)
   Ebits=0;
   ebits=0;
   
  else
   Ebits = ceil(log2(abs(Emin))) + 1;
  end % if isequal
  
  if ebin ~= 0
   Ebits = max(ceil(log2(abs(ebin))),Ebits);
  end % if
  
  xstr = sprintf([xstr,' (*2^)']);
  
  if ebin < -1
   warning(' p_float2binf: biased exponent is negative')
   xstr = [xstr,'-'];
   ebin = -ebin;
  end % if ebin
  
  for ii = 1:Ebits
   
   if (ii > 4) && (rem(ii,4) == 1)
    xstr = [xstr,' '];
   end % if
   
   if ebin >= pow2(Ebits-ii)
    xstr = [xstr,'1'];
    ebin = ebin - pow2(Ebits - ii);
    
   else
    xstr = [xstr,'0'];
   end % if ebin
   
  end % for ii
  
%   xstr = sprintf([xstr,' [%.0fd]'],e);

 end % if shortfixedpoint
 
end % if isnan

if shortfixedpoint
 
 while any(find(xstr=='.')) && strcmp(xstr(end),'0') && (length(xstr) > 3)
  xstr(end) = '';
 end %while
 
 if strcmp(xstr(end),'.')
  xstr(end) = '';
 end % if
 
end % if shortfixedpoint

% decode the string
I = [];
F = [];
ind = strfind(xstr,'.');

if ~isempty(ind)
 Itemp = xstr(2:ind-1);
 Ftemp = xstr(ind+1:end);
 
else
 Itemp = xstr(2:end);
 Ftemp = [];
end % if

for k = 1:length(Itemp)
 
 if strcmp(Itemp(k),'0') == 1
  I = [I 0];
  
 else
  I = [I 1];
 end % if
 
end % for k

if ~isempty(Ftemp)
 
 for k = 1:length(Ftemp)
  if strcmp(Ftemp(k),'0') == 1
   F = [F 0];
   
  else
   F = [F 1];
  end % if
  
 end % for k
 
end % if ~isempty

% remove the heading and trailing zeros (this is useless???)
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
FF = F(1:maxF);

else
 % F is a vector of zeros
 maxF = 1;
 FF = [];
end % if

if minI ~= 0
II = I(minI:length(I));
else
 II = [];
end % if

bin = struct('sign',sig,'I',II,'F',FF,'float',x);

bin.float = p_binf2dec(bin);

if nargout == 2
 
% we remove the leading zeros
%  if nbits > length(I)
%   I = [zeros(1,nbits-length(I)), I];
%  end % if
 
 if nbits > length(F)
  F = [F, zeros(1,nbits - length(F))];
  
 elseif nbits < length(F)
  F = F(1:nbits);
 end % if
 
 binfix = struct('sign',sig,'I',I,'F',F,'float',x,'nbits',nbits);
 
else
 binfix = 0;
end % if



