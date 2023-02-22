format short
clear all
clc


%%% Phase 1: Input parameters
C = [2 3 4 7];
A = [2 3 -1 4; 1 -2 6 -7];
b = [8 ; -3];

% n = number of columns
% m = number of rows

%%% Phase 2: No. of Constraints & Variables
m = size(A, 1);
n = size(A, 2);

%%% Phase 3: Compute the nC_m BFS
nv = nchoosek(n,m);
t = nchoosek(1:n,m);

%%% Phase 4: Construct the basic solution
sol=[];
if n>=m
    for i = 1:nv
        y = zeros(n,1);
        x = A(:,t(i,:))\b;
        if all(x>=0 & x~=inf & x~=-inf)
            y(t(i,:)) = x; %replacing 0 with x values
            sol = [sol y];
        end
    end
else
    error('Equations larger than variables')
end

%%% Phase 5: Optimal Solution
Z = C*sol;
[Zmax, Zind] = max(Z);
BFS = sol(:,Zind);

optval = [BFS' Zmax];
OPTIMAL_BFS = array2table(optval);
OPTIMAL_BFS.Properties.VariableNames(1:size(OPTIMAL_BFS,2)) = {'x_1','x_2','x_3','x_4','Value_of_Z'}
