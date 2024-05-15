function bin=d_float_dec2floatp(x,nbits);
%D_FLOAT_DEC2FLOATP converts a double x to binary floating point format

% bin is (-1)^s 1.xxxxxx 2^e with an nbits significand
% or zero 0.00000 2^0

% bin is a structure bin.sign, bin.I = 1 or [], bin.F, bin.E
% I anf F are binary strings, E is a signed integer

% if E > 1023, 2^E = Inf, so the largest positive number is roughly 1e308
% the smallest non zero number is roughly 5e-324

% Note that this is not the same as IEEE floating point since here the
% exponent is a decimal integer and not a binary number
% It can be as large as it could

% no subnormal numbers

% dependencies: f_d_frac2bin, f_d_round_bin, f_d_floatp2dec

%
% Author G. Meurant
% May 2020
%

global round_mode

global bits_expo min_expo max_expo

if isempty(round_mode)
 round_mode = 1;
end % if

if isempty(bits_expo)
 bits_expo = 0;
end % if

if isempty(x)
 bin = struct('sign',[],'I',[],'F',[],'E',[],'float',[],'nbits',nbits);
 return
end % if

x = double(x);

if x == 0
 sig = 0;
 I = [];
 F = zeros(1,nbits,'uint8');
 e = 0;

else
 if x <0
  sig = 1;
  y = -x;
 else
  sig = 0;
  y = x;
 end % if
 
 if y > 1e308
  error(' float_dec2floatp: the number is too large')
 end % if
 
 [f,ex] = log2(y); % x = f 2^ex, 0.5 <= f <1, y < 1e308!!
 [fb,cnext] = f_d_frac2bin(f,2*nbits,sig); 
 ind = find(fb); % find the position of the first 1
 
 if ~isempty(ind)
  I = 1;
  F = fb(ind(1)+1:end);
  [F,cnext] = f_d_round_bin(F,nbits,sig); % round F to nbits 
  e = ex - ind(1);
 else
  F = zeros(1,nbits,'uint8');
  e = ex;
 end % if
 
end % if

if bits_expo ~= 0
 % check the expopnent for over(under)flow
 if e > max_expo % overflow
  I = Inf(1,length(I)); 
  F = Inf(1,length(F));
 end % if
 if e < min_expo % underflow
  I = zeros(1,length(I));
  F = zeros(1,length(F));
 end % if
end % if bits_expo
 
bin = struct('sign',sig,'I',I,'F',F,'E',e,'float',x,'nbits',nbits);

bin.float = f_d_floatp2dec(bin); 



