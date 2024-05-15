function dec = f_d_bin2frac(inputarray);
%F_D_BIN2FRAC converts the input array to a double fractional part

% inputarray contains an integer corresponding to the fractional part of a real number

% no dependencies

%
% Author G. Meurant
% May 2020
%

I = find(inputarray);

bin = double(inputarray(I));
power = 2.^(-I);

product = bin .* power;

dec = sum(product);