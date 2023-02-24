format short 
clear all
clc

C = [2 -3 6];
A = [1 0 -3; 2 -8 3; 1 1 0];
b = [4; 4; -7];

IneqSign = [1; 0; 1];

s = eye(size(A,1));
ind = find(IneqSign > 0);
s(ind,:) = -s(ind,:);

objFns = array2table(C);
objFns.Properties.VariableNames(1:3) = {'x_1','x_2','x_3'};
Mat = [A s b];
Constraint = array2table(Mat);
Constraint.Properties.VariableNames(1:size(Mat,2)) = {'x_1','x_2','x_3','s_1','s_2','s_3','Sol'};

objFns
Constraint