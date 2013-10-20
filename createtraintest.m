%input an a set of x's and gcov option
%output synthetic y's based off of gcov opt
function [ trainX, trainY, testX, testY ] = createtraintest(x, y, maxlen,split)
 marked=ones(maxlen,1);
 p=randperm(maxlen,split);
 trainX=zeros(split,1);
 trainY=zeros(split,1);
 
 %make training set up to the split
 for i=1:split,
    trainY(i)=y(p(i));
    trainX(i)=p(i);
    marked(p(i))=0;
 end
 
 %make test set after the split by looking at remaining marked indices
 testX=zeros(maxlen-split,1);
 testY=zeros(maxlen-split,1);
 j=1;
 for i=1:maxlen,
    if marked(i)==1,
        testX(j)=i;
        testY(j)=y(i);
        j=j+1;
    end
    
 end
 
 
 