function [ opcell, parcell ] = genvars( op, par )
    var=1;
    len=1;
    center=0;
    
    kern = 'splr';
    param = [var,len,NaN; var,1,4*len; 0,0,center; var,len,1]';
    
    if op=='0'
        opcell=cell(4,1);%%
        parcell=cell(4,1);%%
        for i=1:4%%
            opcell{i}=kern(i);
            parcell{i}=param(:,i);
        end
    else
        N=length(op);
        M=(N+1)/2;
        opcell=cell(8*N+3*M,1);%%
        parcell=cell(8*N+3*M,1);%%
        
        count=0;
        for i=1:N
            for j=1:4%%
                for k='+*'
                    count=count+1;
                    opcell{count} = [ op(1:i) kern(j) k op( (i+1):end ) ];
                    parcell{count} = [ par(:,1:i) param(:,j) NaN(3,1) par(:, (i+1):end)];

                end
            end
        end
        
        for i=1:N
            for j=1:4%%
                if ismember(op(i),kern) && op(i)~=kern(j)
                    count=count+1;
                    opcell{count} = [ op(1:(i-1)) kern(j) op((i+1):end)];
                    parcell{count} = [ par(:,1:(i-1)) param(:,j) par(:,(i+1):end)];

                end
            end
        end
        
        if count~=8*N+3*M%%
            disp('ERROR: problem in count')
        end
        
    end

end

