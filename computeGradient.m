function [ gradient ] = computeGradient( f, x, delta )
   gradient=zeros(size(x));
   baseline = f(x);    
   for i=1:length(x)
       x(i)=x(i)+delta;
       gradient(i) = (f(x) - baseline)/delta;
       x(i)=x(i)-delta;
   end

end