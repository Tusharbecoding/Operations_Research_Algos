format short
clear all
clc

C = [3 5];
A = [1 2; 1 1; 0 1];
b = [2000; 1500; 600];

IneqSign = [0 0 1];

s = eye(size(A,1));
ind = find(IneqSign > 0);
s(ind, :) = -s(ind,:); 

objFns = 
Constraint = array2table(Mat);array2table(C);
objFns.Properties.VariableNames(1:size(C,2)) = {'x_1','x_2'};
Mat = [A s b];

Constraint.Properties.VariableNames(1:size(Mat,2)) = {'x_1','x_2','s_1','s_2','s_3','Sol'};

objFns
Constraint
