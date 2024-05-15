function bin=p_frac2bin(f,nbits);
%P_FRAC2BIN converts a fractional part to binary with nbits

% f must be a double, f = 0.xxxxx...

%
% Author G. Meurant
% April 2020
%

bin = zeros(1,nbits);
temp = f;

for k = 1:nbits
 temp = 2 * temp;
 if temp >= 1
  bin(k) = 1;
  temp = temp - 1;
 end % if
end % for

