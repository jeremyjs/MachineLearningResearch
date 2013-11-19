function [ minX, minF ] = minimizeWrapper( x,f )
    f2= @(x)computePair(f,x,1/10^6);
    minX = minimize(x,f2,-100);
    minF=f(minX);

end