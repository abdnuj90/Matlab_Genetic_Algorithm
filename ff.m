% function to evaluate the binary value of a number and convert it into
% string

function [f,x1,x2] = ff(x)
    x1 = binaryVectorToDecimal(x([1:4]));
    x2 = binaryVectorToDecimal(x([5:8]));
    f = (x1-2)^2+(x2-5)^2;
end