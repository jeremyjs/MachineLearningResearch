function [ val ] = multigauss( t,C )

    val = exp(-(t'*C^-1*t)/2) / sqrt( (2*pi)^length(t) * det(C) );



end

