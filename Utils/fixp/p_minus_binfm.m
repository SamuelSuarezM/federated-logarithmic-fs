function binc = p_minus_binfm(bina,binb);
%P_MINUS_BINFM subtraction of two matrices of binary fixed point numbers

% Both inputs must have the same parameters (nbits and es). The result will also have
% the same parameters

[rowa,cola] = size(bina); % number of rows and columns
[rowb,colb] = size(binb);
if rowa ~= rowb || cola ~= colb
 error(' p_minus_binfm: incompatible dimensions of inputs')
end % if

% Create a binary element and set its parameters
binc = bina;

for i = 1:rowa
 for j = 1:cola
  binc(i,j) = p_minus_binf(bina(i,j),binb(i,j));
 end % for j
end % for i

