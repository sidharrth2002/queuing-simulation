function p = main()
    % take input to choose generator
    disp('Please select a randomiser generator:');
    disp('1-Standard Generator');
    disp('2-Linear Congruential Generator ');
    disp('3-Random Variate Generator ');
    rchooser = input('input: ');
    n = input('Number of cutomers for simulation: ');% take input n customers
    maxc = input('Max customers allowed: '); % take input max customers allowed
    
    
    %InterArrival Table:
    i=1;
    iat(i)=i;
    prob(i)= 1/5;
    cdf(i)= 1/5; 
    startrange(i) = 1;
    endrange(i) = cdf(i)*100;
    incendrange=cdf(i)*100;
    

    i=2;
    while( i<= 5)
         iat(i)=i;
         prob(i)=1/5;
         cdf(i)= cdf(i-1) + prob(i);
         startrange(i)= endrange(i-1) + 1;
         endrange(i)= endrange(i-1) +  incendrange;
         i= i+1;
    end 
    disp('j iat prob cdf startrange endrange');
    for j=1:5
        fprintf('%2.0f %10.3f %10.3f %10.3f %10.3f %10.3f\n', [j iat(j) prob(j) cdf(j) startrange(j) endrange(j)]);
    end 

    %Counter 1 service time:
    i= 1;
    st1(i)=0;
    prob1(i)=0;
    cdf1(i)= 0.25;
    startrange1(i) = 1;
    endrange1(i) = 25;
    
    x=5;
    while( i< x)
         if rchooser == 1 
             st1(i)=random(3,9);
         elseif rchooser == 2
            st1(i)= LCG(3,9);
         else 
            st1(i)= randomVariate(3,9);
         end
         prob1(i)=0.25;
         cdf1(i+1)= cdf1(i) + prob1(i);
         startrange1(i+1)= endrange1(i) + 1;
         endrange1(i+1)= endrange1(i) + 25;
         i= i+1;
    end 
        
    disp('Counter 1:');
    disp('j st prob cdf startrange endrange');
    for j=1:x-1
        fprintf('%2.0f %10.3f %10.3f %10.3f %10.3f %10.3f\n', [j st1(j) prob1(j) cdf1(j) startrange1(j) endrange1(j)]);
    end 
    
    
    %Counter 2 service time:
    i= 1;
    st2(i)=0;
    prob2(i)=0;
    cdf2(i)= 0.25;
    startrange2(i) = 1;
    endrange2(i) = 25;
    x=5;
        while( i< x)
         if rchooser == 1 
             st2(i)=random(3,9);
         elseif rchooser == 2
            st2(i)= LCG(3,9);
         else 
            st2(i)= randomVariate(3,9);
         end
         prob2(i)=0.25;
         cdf2(i+1)= cdf2(i) + prob2(i);
         startrange2(i+1)= endrange2(i) + 1;
         endrange2(i+1)= endrange2(i) + 25;
         i= i+1;
    end 
        
    disp('Counter 2:');
    disp('j st prob cdf startrange endrange');
    for j=1:x-1
        fprintf('%2.0f %10.3f %10.3f %10.3f %10.3f %10.3f\n', [j st2(j) prob2(j) cdf2(j) startrange2(j) endrange2(j)]);
    end 



    
    
    
    %Main Table:
    lastendtime1=0;
    lastendtime2=0;
    t=1;
    temp(t)=0;
    counter1check=0;
    counter2check=0;
    

    while( t<= n)
        % set zeros for all arrays:
        randomIntervalTime(t)=0;
        interarrivaltime(t)=0;
        arrivaltime(t)=0;
        customersInCenter(t)=0;
        timeEnteringCenter(t)=0;
        randomServiceTime(t)=0;
   
        %counter1
        servicetime1(t)=0;
        timeServiceB1(t)=0;
        timeServiceE1(t)=0;
    
        %counter2
        servicetime2(t)=0;
        timeServiceB2(t)=0;
        timeServiceE2(t)=0;
 
        waitingTime(t)=0;
        timeSpent(t)=0;

        %set values:
        if rchooser == 1 
             temp(t)=random(35, 42);
        elseif rchooser == 2
            temp(t)= LCG(35, 42);
        else 
            temp(t)= randomVariate(35, 42);
        end

        if rchooser == 1 
             randomIntervalTime(t)=random(1, 100);
        elseif rchooser == 2
            randomIntervalTime(t)=LCG(1, 100);
        else 
            randomIntervalTime(t)=randomVariate(1, 100);
        end
        
       
        %interarrivaltime
        for u=1:5
             if t == 1
                randomIntervalTime(t)=0;
                interarrivaltime(t) = 0;
             elseif randomIntervalTime(t) >= startrange(u) & randomIntervalTime(t) <= endrange(u)
                interarrivaltime(t) = u;
             end      
        end
         
        %arrival time
        arrivaltime(1)=0;
        if t > 1
            arrivaltime(t) =  arrivaltime(t-1) + interarrivaltime(t); % breaks
        end

        
        %temp not allowed
        if  temp(t) >= 38 
            timeEnteringCenter(t)=0;
            randomServiceTime(t)=0;
   
            %counter1
            servicetime1(t)=0;
            timeServiceB1(t)=0;
            timeServiceE1(t)=0;
    
            %counter2
            servicetime2(t)=0;
            timeServiceB2(t)=0;
            timeServiceE2(t)=0;
 
            waitingTime(t)=0;
            timeSpent(t)=0;

            
        else  %temp allowed 

            %counters switching
            if t > 1
                if arrivaltime(t) >=  timeServiceE1(t-1) 
                    counter1check=0;
                else
                    counter1check=1; 
                end
            
                if arrivaltime(t) >=  timeServiceE2(t-1) 
                    counter2check=0;
                else
                    counter2check=1;

                end
                
                %number of customers in center
                cin=0;
                carrivaltime = arrivaltime(t);
                for u=1:t-1  
                    if carrivaltime < timeServiceE1(u)
                        cin =cin +1;
                    end      
                    if carrivaltime < timeServiceE2(u)
                        cin =cin +1;
                    end   
                end
                customersInCenter(t)=cin;
                
                % check max customers
                if cin <= maxc
                     timeEnteringCenter(t)=arrivaltime(t);
                else
                    if lastendtime1 <= lastendtime2
                         timeEnteringCenter(t)=lastendtime1;
                    else
                        timeEnteringCenter(t)=lastendtime2;
                    end
                end
                                    
            end

            %random number for servicetime
            if rchooser == 1 
               randomServiceTime(t)=random(1,100);
            elseif rchooser == 2
                 randomServiceTime(t)=LCG(1, 100);
            else 
                 randomServiceTime(t)=randomVariate(1, 100);
            end
            

            
            %choosing counter
            if (counter1check == 0 & counter2check == 0) | (counter1check == 0 & counter2check == 1) %both free
                %service time:
                for u=1:x-1
                    if randomServiceTime(t) >= startrange1(u) & randomServiceTime(t) <= endrange1(u)%counter 1 is assigned
                        servicetime1(t) = u;
                    end      
                end
                servicetime2(t) = 0;
                %time service begins:
                timeServiceB1(t)=arrivaltime(t);
                timeServiceB2(t)=0;
                %time service ends:
                timeServiceE1(t)=timeServiceB1(t) + servicetime1(t); % breaks
                lastendtime1=timeServiceE1(t);
                timeServiceE2(t)=0;
                waitingTime(t)=0;
                timeSpent(t) = timeServiceE1(t) - arrivaltime(t);
                


            elseif  counter1check == 1 & counter2check == 0 %1 full 2 free
                for u=1:x-1
                    if randomServiceTime(t) >= startrange2(u) & randomServiceTime(t) <= endrange2(u) %counter 2 is assigned
                        servicetime2(t) = u;
                    end      
                end
                servicetime1(t) = 0;
                %time service begins:
                timeServiceB2(t)=arrivaltime(t);
                timeServiceB1(t)=0;
                %time service ends:
                timeServiceE2(t)=timeServiceB2(t)+ servicetime2(t); % breaks
                lastendtime2=timeServiceE2(t);
                timeServiceE1(t)=0;
                waitingTime(t)=0;
                timeSpent(t) = timeServiceE2(t) - arrivaltime(t);
                
           
            elseif  counter1check == 1 & counter2check == 1 %both full
                if lastendtime1 < lastendtime2 %counter 1 will finish first
                    for u=1:x-1
                        if randomServiceTime(t) >= startrange1(u) & randomServiceTime(t) <= endrange1(u) %counter 1 is assigned
                            servicetime1(t) = u;
                        end      
                    end
                    servicetime2(t) = 0;
                    %time service begins:
                    timeServiceB1(t)=lastendtime1;
                    timeServiceB2(t)=0;
                    %time service ends:
                    timeServiceE1(t)=lastendtime1 + servicetime1(t);
                    timeServiceE2(t)=0;
                    waitingTime(t)=lastendtime1-arrivaltime(t);
                    timeSpent(t) = timeServiceE1(t) - arrivaltime(t);
                    lastendtime1= timeServiceE1(t);
                    
    
                else %counter 2 will finish first
                    for u=1:x-1
                        if randomServiceTime(t) >= startrange2(u) & randomServiceTime(t) <= endrange2(u) %counter 2 is assigned
                            servicetime2(t) = u;
                        end      
                    end
                    servicetime1(t) = 0;
                    %time service begins:
                    timeServiceB2(t)=lastendtime2;
                    timeServiceB1(t)=0;
                    %time service ends:
                    timeServiceE2(t)=lastendtime2 + servicetime2(t);
                    timeServiceE1(t)=0;
                    waitingTime(t)=lastendtime2-arrivaltime(t);
                    timeSpent(t) = timeServiceE2(t) - arrivaltime(t);
                    lastendtime2= timeServiceE2(t);

                end

            end
       end
   
        t= t+1;
    end 

    
        disp('j temp randomit interarrivaltime arrivaltime customersincenter timeentering randomst');
    for j=1:n
        fprintf('%2.0f %10.3f %10.3f %10.3f %10.3f %10.3f %10.3f %10.3f\n', [j temp(j) randomIntervalTime(j) interarrivaltime(j)  arrivaltime(j) customersInCenter(j) timeEnteringCenter(j) randomServiceTime(j) ]);
    end 
    
            disp('j servicetime1 timeServiceB1 timeServiceE1 servicetime2 timeServiceB2 timeServiceE2  waitingTime  timeSpent');
    for j=1:n
        fprintf('%2.0f %10.3f %10.3f %10.3f %10.3f %10.3f %10.3f %10.3f %10.3f\n', [j  servicetime1(j) timeServiceB1(j) timeServiceE1(j) servicetime2(j) timeServiceB2(j) timeServiceE2(j)  waitingTime(j)  timeSpent(j) ]);
    end 
