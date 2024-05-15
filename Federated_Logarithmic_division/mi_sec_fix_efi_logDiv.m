function MI= mi_sec_fix_efi_logDiv( X, Y, T, n_devices, n_discret, numSamples, maxY)
% Summary
%    Estimate mutual information I(X;Y) between two categorical variables X,Y
%    X,Y can be matrices which are converted into a joint variable before computation
loc_p_XY = fix_dec2binf3Dm(zeros(n_discret,maxY,n_devices),T);

for n_dev = 1:n_devices
    X_dev = X{n_dev};
    Y_dev = Y{n_dev};
    table_dim = [n_discret maxY];
    
    loc_count = accumarray([X_dev Y_dev ],1,table_dim);
    %loc_count2(:,:,n_dev) = loc_count;
    loc_p_XY(:,:,n_dev) = fix_dec2binfm((loc_count/numSamples),T);%f_d_div_INTm(fix_dec2binfm(loc_count,T),fix_dec2binfm(numSamples,T));

end
%Sum(glob_res, 3)
    [na,ma,pa] = size(loc_p_XY);
    p_XY = fix_dec2binfm(zeros(na,ma),T);

    for j = 1:ma
        for k = 1:na
            s = fix_dec2binf(0,T);
            for i = 1:pa
                s = p_add_binf(s, loc_p_XY(k,j,i));
            end % for k
            p_XY(k,j) = s;
        end
    end % for j

%Sum(p_XY,1)
[na,ma] = size(p_XY);
sum1 = fix_dec2binfm(zeros(1,ma),T);
for j = 1:ma
    s = fix_dec2binf(0,T);
    for k = 1:na
        s = p_add_binf(s, p_XY(k,j));
    end % for k
    sum1(j) = s;
end % for j

%Sum(p_XY,2)
sum2 = fix_dec2binfm(zeros(na,1),T);
for j = 1:na
    s = fix_dec2binf(0,T);
    for k = 1:ma
        s = p_add_binf(s, p_XY(j,k));
    end % for k
    sum2(j) = s;
end % for j

%p_X_p_Y= mat_prod_binf(sum2, sum1);
[na,ma] = size(sum2);
[nb,mb] = size(sum1);

p_X_p_Y = fix_dec2binfm(zeros(na,mb),T);

for i = 1:na
 for j = 1:mb
  s = fix_dec2binf(0,T);
  
  for k = 1:ma
   s = p_add_binf(s, p_mul_binf(sum2(i,k), sum1(k,j)));
  end % for k
  
  p_X_p_Y(i,j) = s;
  
 end % for j
end % for i

id_non_zero = intersect(find(p_binf2decm(p_XY)~=0),find(p_binf2decm(p_X_p_Y)~=0));
%MI = sum(sum( p_XY(id_non_zero) .* log(p_XY(id_non_zero) ./p_X_p_Y(id_non_zero)))); 

if ~isempty(id_non_zero)
    %MI = sum(sum( p_XY(id_non_zero) .* fixp(log(double(p_XY(id_non_zero)) ./  double(p_X_p_Y(id_non_zero))),T)));

    %% Division + Log
    div = fix_dec2binfm(log(p_binf2decm(p_XY(id_non_zero)) ./  p_binf2decm(p_X_p_Y(id_non_zero))),T);
    
    %% Multiplic punto a punto
    matrixMI = p_dot_binf(p_XY(id_non_zero), div);
    
    %% Sum(Sum(
    [na,ma] = size(matrixMI);
    aux1 = fix_dec2binfm(zeros(1,ma),T);
    for j = 1:ma
        s = fix_dec2binf(0,T);
        for k = 1:na
            s = p_add_binf(s, matrixMI(k,j));
        end % for k
        aux1(j) = s;
    end % for j
    
    MI = fix_dec2binf(0,T);
    for k = 1:ma
        MI = p_add_binf(MI, aux1(k)); % simple summation
    end

    MI = p_binf2dec(MI);
else
    MI = 0;
end
