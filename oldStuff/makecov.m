function [ C ] = makecov( X1, X2, opt, par, variance)

%x1 and x2 are two vectors. this function returns a matrix C where the ij
%entry is the covariance between x1_j and x2_i

   % X1 = repmat(x,[1 length(x)]); %make a matrix where the ij entry is x1_j
    %X2 = repmat(x',[length(x) 1]); %make a matrix where the ij entry is x2_i

    
if variance<0.001
    variance=NaN;
end
if par(1)<0.0001
    par(1)=NaN;
end
if par(2)<0.0001
    par(2)=NaN;
end
    
if opt=='s' %squared exp
    C = par(1)*exp( - (X1-X2).^2 / (2*par(2)^2));
end

if opt=='p' %periodic
    if par(3)<0.0001
        par(3)=NaN;%period must be strictly positive
    end
    C = par(1) * exp( -2*( sin( pi.*(X1-X2) / par(3)) ).^2 / par(2)^2 ) ;
end

if opt=='l' %linear
    C = par(1) + par(2)*(X1-par(3)).*(X2-par(3));
end

if opt=='r' %rational quadratic
    if par(3)<0.5 || par(3)>2
        par(3)=NaN;
    end
    %par(3) = min(2,max(0.5,par(3))); %if par(3) -> inf, approaches squared exp
    C = par(1) * (1 + (X1-X2).^2 / (2*par(3)*par(2)^2)) .^ (-par(3));
end

C = C + variance*(X1==X2);%add variance within each data point
end

