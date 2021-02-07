function p = main(n)
    
    %InterArrival Table:
    i=1;
    iat(i)=0;
    prob(i)=0;
    cdf(i)=0.25;
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

    %Counter 1 service time:
    i= 1;
    st1(i)=0;
    prob1(i)=0;
    cdf1(i)= 0.25;
    startrange1(i) = 1;
    endrange1(i) = 25;

     while( i< n)
         st1(i)=random(3, 9);
         prob1(i)=0.25;
         cdf1(i+1)= cdf(i) + prob1(i);
         startrange1(i+1)= endrange1(i) + 1;
         endrange1(i+1)= endrange1(i) + 25;
         i= i+1;
    end 
        
    disp('Counter 1:');
    disp('st prob cdf startrange endrange');
    for j=1:n-1
        fprintf('%2.0f %10.3f %10.3f %10.3f %10.3f %10.3f\n', [j st1(j) prob1(j) cdf1(j) startrange1(j) endrange1(j)]);
    end 
    
    
    %Counter 2 service time:
    i= 1;
    st2(i)=0;
    prob2(i)=0;
    cdf2(i)= 0.25;
    startrange2(i) = 1;
    endrange2(i) = 25;

     while( i< n)
         st2(i)=random(3, 9);
         prob2(i)=0.25;
         cdf2(i+1)= cdf2(i) + prob2(i);
         startrange2(i+1)= endrange2(i) + 1;
         endrange2(i+1)= endrange2(i) + 25;
         i= i+1;
    end 
        
    disp('Counter 2:');
    disp('st prob cdf startrange endrange');
    for j=1:n-1
        fprintf('%2.0f %10.3f %10.3f %10.3f %10.3f %10.3f\n', [j st2(j) prob2(j) cdf2(j) startrange2(j) endrange2(j)]);
    end 



    
    
    
    %Main Table:
    t= 1;
    mc=2;
    cin=1;
    temp(t)=0;
    randomIntervalTime(t)=0;
    interarrivaltime(t)=0.25;
    arrivaltime(t)=1;
    customersInCenter(t)=0;
    timeEnteringCenter(t)=0;
    randomServiceTime(t)=0;

    
    %counter1
    counter1check=0;
    servicetime1(t)=0;
    timeServiceB1(t)=0;
    timeServiceE1(t)=0;
    
    %counter2
    counter2check=0;
    servicetime2(t)=0;
    timeServiceB2(t)=0;
    timeServiceE2(t)=0;
 
    waitingTime(t)=0;
    timeSpent(t)=0;

    while( t< n)
        temp(t)=random(35, 42);
        randomIntervalTime(t)=random(1, 100);
        %interarrivaltime
        for u=1:n-1
             if t == 1
                interarrivaltime(t) = 0;
             elseif randomIntervalTime(t) > startrange(u) & randomIntervalTime(t) < endrange(u)
                interarrivaltime(t) = u;
             end      
        end
         
        %arrival time
        if t == 1
            arrivaltime(t) = 0;
        else
            arrivaltime(t) =  arrivaltime(t-1) + interarrivaltime(t);
        end
         
        %time entering the center
        if cin == mc
            disp('wait');
        else
            timeEnteringCenter(t) = arrivaltime(t);
        end
        
        %random number for servicetime
        randomServiceTime(t)=random(1,100);
        

        %choosing counter
        if counter1check == 0 %counter 1 is free
           for u=1:n-1
             if randomServiceTime(t) > startrange1(u) & randomServiceTime(t) < endrange1(u)
                 servicetime1(t) = u;
             end      
             servicetime2(t) = 0;
           end
           counter1check =1;

           
        elseif counter1check == 1 %counter 1 is full
           for u=1:n-1
             if randomServiceTime(t) > startrange2(u) & randomServiceTime(t) < endrange2(u)
                 servicetime2(t) = u;
             end  
            servicetime1(t) = 0;
           end
           counter2check =1;
           
        elseif counter1check == 1 &  counter2check == 1 %both are full
           disp('wait2');
            
       end
   
        
        
        t= t+1;
    end 

    
        disp('j temp randomit interarrivaltime arrivaltime timeentering randomst');
    for j=1:n-1
        fprintf('%2.0f %10.3f %10.3f %10.3f %10.3f %10.3f %10.3f\n', [j temp(j) randomIntervalTime(j) interarrivaltime(j)  arrivaltime(j) timeEnteringCenter(j) randomServiceTime(j) ]);
    end 
    
            disp('j servicetime1 servicetime2');
    for j=1:n-1
        fprintf('%2.0f %10.3f %10.3f\n', [j  servicetime1(j) servicetime2(j) ]);
    end 
