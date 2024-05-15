function dec = f_d_bin2dec(inputarray);
%F_D_BIN2DEC converts the binary input array to a decimal (double) number

% inputarray is a row vector containing an integer >= 1

% assume that the input array contains binary numbers. If the input array
% is empty, the returned value is zero

% for very long binary numbers with many 1's, the output is infinite if dec > realmax = 1.7977e+308

% no dependencies

%
% Author G. Meurant
% May 2020
%

% consider only the 1's in the input

I = find(inputarray);
I = length(inputarray) - I + 1;

power = 2.^(I-1);

dec= sum(power);

