format short
clear all
clc

C = [1 -3 2];
A = [3 -1 2; -2 4 0; -4 3 8];
b = [7; 12; 10];

IneqSign = [0 0 0];

s = eye(size(A,1));
ind = find(IneqSign > 0);
s(ind,:) = -s(ind,:);

optFns = array2table(C);
optFns.Properties.VariableNames(1:3) = {'x_1','x_2','x_3'};
Mat = [A s b];
Constraint = array2table(Mat);
Constraint.Properties.VariableNames(1:size(Mat,2)) = {'x_1','x_2','x_3','s_1','s_2','s_3','Sol'};

optFns
Constraint