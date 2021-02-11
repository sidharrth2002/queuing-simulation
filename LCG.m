function output = LCG(min, max)
    modulus = max+1;
    a = 0;
    c = random(min,max);
    persistent previousVal; 
    if isempty(previousVal);
        previousVal =min; 
    end; 
    newVal = mod((a*previousVal + c), modulus);
    previousVal = newVal;
    output = newVal;