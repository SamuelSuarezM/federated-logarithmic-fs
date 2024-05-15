function binc = f_d_minusm(bina,binb);
%F_D_MINUSM subtraction of two matrices of binary floating point numbers

% Both inputs must have the same parameters (nbits and es). The result will also have
% the same parameters

% dependencies: f_d_minus

%
% Author G. Meurant
% May 2020
%

[rowa,cola] = size(bina); % number of rows and columns
[rowb,colb] = size(binb);
if rowa ~= rowb || cola ~= colb
 error(' f_d_minusm: incompatible dimensions of inputs')
end % if

% Create a binary element and set its parameters
binc = bina;

for i = 1:rowa
 for j = 1:cola
  binc(i,j) = f_d_minus(bina(i,j),binb(i,j));
 end % for j
end % for i

