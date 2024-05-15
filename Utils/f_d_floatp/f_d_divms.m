function binc = f_d_divms(bina,binb);
%F_D_DIVMS division of a matrix by a scalar, binary floating point numbers

% bina / binb, binb is a scalar

% dependencies: f_d_div

%
% Author G. Meurant
% May 2020
%

[rowa,cola] = size(bina); % number of rows and columns
[rowb,colb] = size(binb);
if rowb ~= 1 || colb ~= 1
 error(' f_d_divms: binb must be a scalar')
end % if

% create a binary element and set its parameters
binc = bina;

for i = 1:rowa
 for j = 1:cola
  binc(i,j) = f_d_div(bina(i,j),binb);
 end % for j
end % for i

