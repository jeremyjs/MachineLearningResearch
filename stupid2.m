len=50;
operation='ll*';
parameter=[0.1 0.1 0 0.01; 0.1 0.1 0 NaN]';
x=(-len:len)';

X1 = repmat(x,[1 length(x)]); %make a matrix where the ij entry is x1_j
    
X2 = repmat(x',[length(x) 1]); %make a matrix where the ij entry is x2_i

C = gramcov(X1,X2,operation,parameter); %set the covariance matrix

t=mvnrnd(zeros(size(x)),C)';


-logmultigauss(t,gramcov(X1,X2,operation,parameter))
-logmultigauss(t,gramcov(X1,X2,'s',[0.1 2 NaN 0.1]'))


