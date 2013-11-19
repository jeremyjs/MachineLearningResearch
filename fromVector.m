function [param,variance] = fromVector(vector,kernel)    
    param=zeros(3,length(kernel));
    param(3,kernel=='s')=NaN;
    param(:,kernel=='*'|kernel=='+')=NaN;
    
    param( ~isnan(param(:)) ) = vector(1:(end-1));
    
    variance = vector(end);
end
    