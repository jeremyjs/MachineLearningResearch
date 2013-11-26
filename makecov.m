function [ C ] = makecov( X1, X2, kernel, param, variance)

%x1 and x2 are two vectors. this function returns a matrix C where the ij
%entry is the covariance between x1_j and x2_i

   % X1 = repmat(x,[1 length(x)]); %make a matrix where the ij entry is x1_j
    %X2 = repmat(x',[length(x) 1]); %make a matrix where the ij entry is x2_i

    
if ~(variance<0 || param(1)<=0 || param(2)<0.0001 || (kernel=='p' && param(3)<=0) || (kernel=='r' && (param(3)<0.5 || param(3)>2)) )

    if kernel=='s' %squared exp
        C = param(1)*exp( - (X1-X2).^2 / (2*param(2)^2));
    end

    if kernel=='p' %periodic
        C = param(1) * exp( -2*( sin( pi.*(X1-X2) / param(3)) ).^2 / param(2)^2 ) ;
    end

    if kernel=='l' %linear
        C = param(1) + param(2)*(X1-param(3)).*(X2-param(3));
    end

    if kernel=='r' %rational quadratic
        %par(3) = min(2,max(0.5,par(3))); %if par(3) -> inf, approaches squared exp
        C = param(1) * (1 + (X1-X2).^2 / (2*param(3)*param(2)^2)) .^ (-param(3));
    end

    C = C + variance*(X1==X2);%add variance within each data point
else
    C = NaN;
end

end

