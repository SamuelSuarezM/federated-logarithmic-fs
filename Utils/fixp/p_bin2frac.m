function dec = p_bin2frac(bin);
%P_BIN2FRAC converts the input array to a fractional part

% bin contains an binary integer corresponding to the fractional part of a real number 0.xxxxx...

% 
% Author G. Meurant
% April 2020
%

% find the nonzero entries
I = find(bin);

bin = bin(I);
power = 2.^(-I);

product = bin .* power;

dec = sum(product);

