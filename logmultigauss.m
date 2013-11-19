function [ val ] = logmultigauss( y,C )
   val = -0.5 * (y'*C^-1*y + length(y)*log(2*pi) + log(det(C)) );
end

