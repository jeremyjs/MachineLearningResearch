kernelCell=cell(15,1);
paramCell=cell(15,1);
initKernelCell=cell(15,1);
initParamCell=cell(15,1);
resultCell=cell(25,1);

kernelCell = { 's','p','l','sp+','sp+','lp+','ls+','pp+','ps*','ll*','ls*','lp*'};
paramCell = { [0.1 0.1 0]', [0.1 1 8]', [0.1 0.1 0]', [1 1 NaN; 3 1 15; NaN NaN NaN]', [1 1 NaN; 5 1 5; NaN NaN NaN]',...
    [0.1 0.1 0; 3 1 10; NaN NaN NaN]', [0.1 0.1 0; 2 2 NaN; NaN NaN NaN]'};
initKernelCell={'0','0','0','0','0','0','0'};
initParamCell={[],[],[],[],[],[],[]};

x=(-50:50)';
numRepeats=5;
for i=1:1
    for j=1:numRepeats
        i
        kernel = kernelCell{i};
        param = paramCell{i};
        variance=0.1;
        y=gensyndata(x,kernel,param,variance);
        [o,p]=learncov(x,y,initKernelCell{i},initParamCell{i});
        resultCell{numRepeats*i-numRepeats+j}=o;
    end
end

for i=1:1
    fprintf('%s ==> \n', kernelCell{i});
    for j=1:numRepeats
        fprintf('%s\n',resultCell{numRepeats*i-numRepeats+j});
    end
end