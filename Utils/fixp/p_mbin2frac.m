function dec = p_mbin2frac(inputarray);
%P_MBIN2FRAC converts the input array to a fractional part

% inputarray contains an integer corresponding to the fractional part of a
% real number

dec = 0;
%  if it comes from a quire, there could be many trailing zeros
% find the nonzero entries
I = find(inputarray);

for i = I
 dec = dec + inputarray(1,i) * 2^(-i);
end % for i

