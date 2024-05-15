function bcv = p_div_binfv(bav,bbv);
%P_DIV_BINFV componentwise division of two binary fixed point vectors bav / bbv

% this is done component by component

% bav and bbv must have the same parameters

%
% Author G. Meurant
% April 2020
%

na = length(bav);
nb = length(bbv);
if na ~= nb
 error(' p_div_binfv: the two binary vectors must have the same length')
end % if

nbitsa = bav.nbits;
nbitsb = bbv.nbits;
if nbitsa ~= nbitsb
 error(' p_div_binfv: the two binary vectors must have the same parameters')
end % if

bcv = bav;

for k = 1:na
 bcv(k) = p_div_binf(bav(k),bbv(k));
end % for k

