function s=f_d_bin2str(bin);
%F_D_BIN2STR bin to string

%
% Author G. Meurant
% May 2020
%

lbin = length(bin);
s = [];

for k = 1:lbin
 s = [s num2str(bin(k))];
end % for k

