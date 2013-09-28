%x=[-3 -2 -1 0 1 2 3]';
%t=[3 2 1 0 -1 -2 -3]';

op='0';
par=[];
currBIC=Inf;

while 1
    
    [opcell,parcell] = genvars(op,par);
    
    bestpar=[];
    bestindex=0;
    minBIC = Inf;
    
    for i=1:length(opcell)
        [bic,newpar] = BIC(x,t,opcell{i},parcell{i});
        if bic<minBIC
            minBIC=bic;
            bestindex=i;
            bestpar=newpar;
        end
    end
    
    if minBIC < currBIC
        op = opcell{bestindex};
        par = bestpar;
        currBIC=minBIC;
    else
        break
    end
end
    
op
par