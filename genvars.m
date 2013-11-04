function [ opcell, parcell ] = genvars( op, par )
    var=0.1;
    len=1;
    center=0;
    
    kern = 'splr';
    param = [var,len,NaN,NaN; var,1,2*len,NaN; var,var,center,NaN; var,len,1,NaN]';
    
    if op=='0'
        opcell=cell(4,1);
        parcell=cell(4,1);
        
        for i=1:4
            opcell{i}=kern(i);
            parcell{i}=param(:,i);
            parcell{i}(4) = var;
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
                        parcell{count} = [ par(:,1:i) param(:,j) NaN(4,1) par(:, (i+1):end)];

                end
            end
        end
        
        for i=1:N
            for j=1:4%%
                if ismember(op(i),kern) && op(i)~=kern(j)
                    count=count+1;
                    opcell{count} = [ op(1:(i-1)) kern(j) op((i+1):end)];
                    parcell{count} = [ par(:,1:(i-1)) param(:,j) par(:,(i+1):end)];
                    if isnan(parcell{count}(4))
                        parcell{count}(4) = var;
                    end

                end
            end
        end
        
        if count~=8*N+3*M%%
            disp('ERROR: problem in count')
        end
        
        %for i=1:count
            %parcell{count}(4,2:end) = NaN;
        %end
        
    end

end

