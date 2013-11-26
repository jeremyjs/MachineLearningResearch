function [ newParam ] = paramRand( param,kernel )
    newParam = param;
    
    for col=1:size(param,2)
        for row=1:3
            if (kernel(col)=='p' && row==2) || (kernel(col)=='r' && row==3) || (kernel(col)=='l' && row==3)
                1;
            else
                newParam(row,col) = param(row,col) * 2^(2*rand()-1);
            end
        end
    end




end

