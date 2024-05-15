function dec = p_mbin2dec(inputarray);
%P_MBIN2DEC converts the input array of 0's and 1's to a decimal (double) number

% inputarray is a row vector containing an integer >= 1

% assume that the input array contains binary numbers. If the input array
% is empty, the returned value is zero

% for very long binary numbers with many 1's, the output is infinite if dec > realmax = 1.7977e+308

dec = 0;
linput = length(inputarray);
% for i = linput:-1:1
%  dec = dec + inputarray(1,i) * 2^(linput-i);
% end % for i

% consider only the 1's in the input

I = find(inputarray);
for i = I
 dec = dec + inputarray(1,i) * 2^(linput-i);
end % for i