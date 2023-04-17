close all ; clear all;
addpath C:\Users\tbrad\Documents\MATLAB\CMPE677HW6\libsvm-3.18\windows
 
load('ex6data2.mat');  %load Andrew Ng data
%convert from y=[0,1} to y={1,2} for confusion matrix indexing
y(y==1)=2;
y(y==0)=1;
 
options.method = 'SVM';
options.numberOfFolds = 5;
options.svm_t=2;
options.svm_c=3;
options.svm_g=30;
[confusionMatrix,accuracy] =  classify677_hwk6(X,y,options);
