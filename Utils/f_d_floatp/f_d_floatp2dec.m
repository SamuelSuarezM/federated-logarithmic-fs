function decm = f_d_floatp2dec(binm);
%F_D_FLOATP2DEC binary floating point to double matrix

% nbits bits in the fractional part

% dependencies: f_d_bin2frac

%
% Author G. Meurant
% May 2020
%

[row,col] = size(binm);
decm = zeros(row,col);

for i = 1:row
 for j = 1:col
  decm(i,j) = fl2dec(binm(i,j));
 end % for j
end % for i

end % function

function x=fl2dec(bin);
%FL2DEC converts binary floating points format to double

% bin is (1)^s 1.xxxxxx 2^e with an nbits significand
% or zero 0.00000 2^0

% bin is a structure bin.sign, bin.I = 1 or [], bin.F, bin.E

%
% Author G. Meurant
% May 2020
%

if isempty(bin.sign) && isempty(bin.I) && isempty(bin.F) && isempty(bin.E)
 x = [];
 return
end % if

if isempty(bin.I) && sum(bin.F) == 0
 x = 0;
 return
end % if

if isempty(bin.I) || isequal(bin.I,0)
 x = f_d_bin2frac(bin.F) * 2^(bin.E);
 
else
 x = (1 + f_d_bin2frac(bin.F)) * 2^(bin.E);
 
end % if

if bin.sign == 1
 x = -x;
end % if

end % function


