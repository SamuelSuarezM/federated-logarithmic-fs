function newseed = p_pow(seed,u,type);
%P_POW power of u in seed 

% caution, we return a positive power, even when it is negative

% type = 0 positive power, = 1 negative power

%
% Author G. Meurant
% April 2020
%

if nargin <= 2
 type = 0;
end % if

if nargin == 1
 u = 2;
end % if

newseed = 0;
p = seed;

if type == 0 % positive power
 
 while p >= u
  p = p / u;
  newseed = newseed + 1;
 end % while
 
else % negative power
 
 while p < u 
  p = p * u;
  newseed = newseed + 1;
 end % while
 
 newseed = newseed - 1;
 
end % if type
