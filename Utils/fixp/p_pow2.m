function newseed = p_pow2(seed,type);
%P_POW2 power of 2 in seed 

% type = 0 positive power, = 1 negative power

if nargin <= 1
 type = 0;
end % if

newseed = 0;
p = seed;

if type == 0 % positive power
 
 while p >= 2
  p = p / 2;
  newseed = newseed + 1;
 end % while
 
else % negative power
 
 while p < 1
  p = p * 2;
  newseed = newseed + 1;
 end % while
 
%  newseed = newseed - 1;
 newseed = -newseed;
 
end % if type
