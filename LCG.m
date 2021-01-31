function output = LCG()
    modulus = 10;
    a = 2;
    c = 3; 
    persistent previousVal; 
    if isempty(previousVal);
        previousVal = rand; 
    end; 
    newVal = mod((a*previousVal + c), modulus);
    previousVal = newVal;
    disp('Test');
    printf('The new random value is %d', newVal);
    output = newVal;