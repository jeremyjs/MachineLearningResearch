%remember to edit below functions to get different synthetic data
%<EDIT HERE>, parameters for user to change
%if opt== s, l, r, or p, you must edit param to match parameters given to
%gramcov
fileName='synthetic data/sample.mat';
opt='c';
param=2;
min=-5;
max=5;
by=0.1;
x=(min:by:max)';
%<EDIT HERE/>, parameters for user to change


X1 = repmat(x,[1 length(x)]); %make a matrix where the ij entry is x1_j
X2 = repmat(x',[length(x) 1]); %make a matrix where the ij entry is x2_i


%<EDIT HERE>, edit parameters to get different synthetic data
%add functions and name them appropriately
if opt=='c' %constant with noise
    C = ones(size(X1));
end

if opt=='g' %gaussian
    C = exp( - abs(X1-X2).^2);
end

if opt=='j' %exponential of different
    C = exp( - abs(X1-X2)/1000)+0.01*(X1==X2);
end

if opt=='s' || opt=='l' || opt=='r' || opt=='p'
   C=gramcov(x, x,  opt, param);
end

%<EDIT HERE/>, edit parameters to get different synthetic data
%add functions and name them appropriately


%plot the functions...
figure; 
hold on;
y=mvnrnd(zeros(size(x)),C);
plot(x,y);
y=y';

%save synthetic data to file
description=strcat('x=', num2str(min), 'to', num2str(max), ', y=', opt);
save(fileName,'x', 'y', 'opt', 'description');