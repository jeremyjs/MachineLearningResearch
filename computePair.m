function [ value, partials ] = computePair( f, x, delta )
   value = f(x);
   partials = computeGradient(f,x,delta);

end