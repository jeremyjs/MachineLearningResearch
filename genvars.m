function [ kernelCell, paramCell ] = genvars( kernel, param, initials )

    baseKernels = 'splr';

    if kernel=='0'
        kernelCell=cell(4,1);
        paramCell=cell(4,1);
        
        for i=1:4
            kernelCell{i}=baseKernels(i);
            paramCell{i} = initials(:,i);
        end
        
    else
        
        N=length(kernel); %%number of elements
        M=(N+1)/2; %%number of operands
        kernelCell=cell(8*N+3*M,1);%%
        paramCell=cell(8*N+3*M,1);%%
        
        count=0;
        for i=1:N
            for j=1:4%%
                for k='+*'
                        count=count+1;
                        kernelCell{count} = [ kernel(1:i) baseKernels(j) k kernel( (i+1):end ) ];
                        paramCell{count} = [ param(:,1:i) initials(:,j) NaN(3,1) param(:, (i+1):end)];

                end
            end
        end
        
        for i=1:N
            for j=1:4%%
                if ismember(kernel(i),baseKernels) && kernel(i)~=baseKernels(j)
                    count=count+1;
                    kernelCell{count} = [ kernel(1:(i-1)) baseKernels(j) kernel((i+1):end)];
                    paramCell{count} = [ param(:,1:(i-1)) initials(:,j) param(:,(i+1):end)];
                end
            end
        end
        
        if count~=8*N+3*M%%
            disp('ERROR: problem in count')
        end
        
    end

end

