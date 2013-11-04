function [ C ] = makecov( x1 ,x2, opt, par, variance)

%x1 and x2 are two vectors. this function returns a matrix C where the ij
%entry is the covariance between x1_j and x2_i

X1 = repmat(x1,[1 length(x2)]); %make a matrix where the ij entry is x1_j
X2 = repmat(x2',[length(x1) 1]); %make a matrix where the ij entry is x2_i
if variance<0.001
    variance=0.001;
end
if par(1)<0
    par(1)=0;
end
if par(2)<0.001
    par(2)=0.001;
end
    
if opt=='s' %squared exp
    C = par(1)*exp( - (X1-X2).^2 / (2*par(2)^2));
end

if opt=='p' %periodic
    if par(3)<0.001
        par(3)=0.001;%period must be strictly positive
    end
    C = par(1) * exp( -2*( sin( pi.*(X1-X2) / par(3)) ).^2 / par(2)^2 ) ;
end

if opt=='l' %linear
    C = par(1) + par(2)*(X1-par(3)).*(X2-par(3));
end

if opt=='r' %rational quadratic
    par(3) = min(2,max(0.5,par(3))); %if par(3) -> inf, approaches squared exp
    C = par(1) * (1 + (X1-X2).^2 / (2*par(3)*par(2)^2)) .^ (-par(3));
end

C = C + variance*(X1==X2);%add variance within each data point
end

