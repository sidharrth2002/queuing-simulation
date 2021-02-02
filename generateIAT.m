function p = generateIAT(n)
    i= 1;
    iat(i)=0;
    prob(i)=0;
    cdf(i)= 0.25;
    startrange(i) = 1;
    endrange(i) = 25;

     while( i< n)
         iat(i)=random(3, 9);
         prob(i)=0.25;
         cdf(i+1)= cdf(i) + prob(i);
         startrange(i+1)= endrange(i) + 1;
         endrange(i+1)= endrange(i) + 25;
         i= i+1;
    end 
    
    
        disp('iat prob cdf startrange endrange');
    for j=1:n-1
        fprintf('%2.0f %10.3f %10.3f %10.3f %10.3f %10.3f\n', [j iat(j) prob(j) cdf(j) startrange(j) endrange(j)]);
    end 
    p= [iat,prob,cdf,startrange,endrange];