function p = main(n)
    i= 1;
    temp(i)=random(35, 42);
    riat(i)=random(1, 100);
    iat(i)= 0.25;
    at(i) = 1;
    ncInc(i)=0;
    tic(i)=0;
    rst(i)=random(1,100);
    
    %counter1
    st1(i)=0;
    tsb1(i)=0;
    tse1(i)=0;
    
    %counter2
    st2(i)=0;
    tsb2(i)=0;
    tse2(i)=0;
    
    wt(i)=0;
    ts(i)=0;


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
