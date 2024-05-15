function qc = f_d_add_floatp2quire(bina,qb);
%F_D_ADD_FLOATP2QUIRE addition of a floatp bina and a quire qb towards a quire

% this works on structures

% dependencies: f_d_add_quire, f_d_floatp2quire

%
% Author G. Meurant
% May 2020
%

qa = f_d_floatp2quire(bina);
 
qc = f_d_add_quire(qa,qb);



