function [ C ] = gramcov( x1,x2, op, par,variance )

    stack = cell(100,1);
    pointer = 1;
    op;
    for i=1:length(op)
        if ismember(op(i),['s','p','l','r'])
            stack{pointer} = makecov(x1,x2,op(i),par(:,i),variance);
            pointer=pointer+1;
        elseif op(i)=='+'
            stack{pointer-2} = stack{pointer-2} + stack{pointer-1};
            pointer=pointer-1;
        elseif op(i)=='*'
            if pointer<3
                print('ERROR: invalid rpn');
            end
            stack{pointer-2} = stack{pointer-2} .* stack{pointer-1};
            pointer=pointer-1;
        else
            print('ERROR: unrecognized character');
        end
    end
    if pointer~=2
        print('ERROR: invalid rpn')
    end
    C = stack{1};
    
                
end

