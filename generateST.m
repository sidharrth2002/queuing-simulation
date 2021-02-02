function p = generateST(n)
    i= 1;
    st(i)=0;
    prob(i)=0;
    cdf(i)= 0.25;
    startrange(i) = 1;
    endrange(i) = 25;

     while( i< n)
         st(i)=random(3, 9);
         prob(i)=0.25;
         cdf(i+1)= cdf(i) + prob(i);
         startrange(i+1)= endrange(i) + 1;
         endrange(i+1)= endrange(i) + 25;
         i= i+1;
    end 
    
    
        disp('st prob cdf startrange endrange');
    for j=1:n-1
        fprintf('%2.0f %10.3f %10.3f %10.3f %10.3f %10.3f\n', [j st(j) prob(j) cdf(j) startrange(j) endrange(j)]);
    end 
