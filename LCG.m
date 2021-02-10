function output = LCG(min, max)
    modulus = max + 1;
    a = 2;
    c = 0;
    persistent previousVal; 
    if isempty(previousVal);
        previousVal = rand; 
    end; 
    newVal = mod((a*previousVal + c), modulus);
    previousVal = newVal;
    output = mod(newVal, (max-min + 1)) + min;