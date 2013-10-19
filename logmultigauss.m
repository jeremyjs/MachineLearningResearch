function [ val ] = logmultigauss( t,C )

    val = -0.5 * (t'*C^-1*t + length(t)*log(2*pi) + det(C) );



end

