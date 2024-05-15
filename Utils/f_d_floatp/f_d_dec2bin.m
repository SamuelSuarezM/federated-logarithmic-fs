function bin=f_d_dec2bin(x);
%F_D_DEC2BIN converts a decimal to binary

%
% Author G. Meurant
% May 2020
%

str = dec2bin(x); % this gives a string
ls = length(str);
bin = zeros(1,ls);

for k = 1:ls
 bin(k) = str2double(str(k));
end % for k