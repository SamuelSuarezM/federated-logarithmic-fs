function binc = f_d_addm(bina,binb);
%F_D_ADDM addition of two matrices of binary floating point numbers

% Both inputs must have the same parameters (nbits). The result will also have
% the same parameters

% dependencies: f_d_add

%
% Author G. Meurant
% May 2020
%

[rowa,cola] = size(bina); % number of rows and columns
[rowb,colb] = size(binb);
if rowa ~= rowb || cola ~= colb
 error(' f_d_addm: incompatible dimensions of inputs')
end % if

% create a binary element and set its parameters
binc = bina;

for i = 1:rowa
 for j = 1:cola
  binc(i,j) = f_d_add(bina(i,j),binb(i,j));
 end % for j
end % for i