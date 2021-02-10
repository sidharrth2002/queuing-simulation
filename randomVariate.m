function output = randomVariate(min,max)
  %  lambda = 1;
   output = floor(min + (max-min)*rand); 
    
    %output = floor((-1/lambda) * log(1-rand));
   % output = floor(mod(randomNum, max-min+1) + min);