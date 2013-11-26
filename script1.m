%parameters for user to change

%data is assumed to have an x and a y variable, both of which are nX1 vectors(you need to change your data
%accordingly)
fileName='synthetic data/sample.mat'; %path to your file
from=1; %beginning indice in your data
to=18; %end indice in your data

%parameters for user to change


%run our learncov function
[operation, parameter]=learncovwrapper(fileName, from, to);

%display which cov we used
disp(sprintf('%s%s', 'operation = ',operation));
