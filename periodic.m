function [truePeriod ] = periodic( y )

autocov=zeros(100,1);

for p=2:100
    if (mod(p,2)==0)
        filter = [0.5; ones(p-1,1); 0.5];
    else
        filter = ones(p,1);
    end
    
    filter=filter/p;
    
    filtered=zeros(length(y)-length(filter)+1,1);
    for i=1:length(filtered)
        filtered(i)=y(i:i+length(filter)-1)'*filter;
    end
    
    filtered = y((length(filter)+1)/2:(end-(length(filter)-1)/2))-filtered;
    
    
    
    a=cov(filtered(1:(end-p+1)),filtered(p:end));
    autocov(p)=a(2)/sqrt(a(1)*a(4)) * (1 - p/length(y));
end

[~,truePeriod] = max(autocov);

end