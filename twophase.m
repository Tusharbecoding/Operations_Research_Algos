format short
clear all
clc

%Convert Min to Max
Variables = {'x_1', 'x_2', 'x_3', 's_1', 's_2', 'A_1', 'A_2','Sol'};
OVariables = {'x_1','x_2', 'x_3', 's_1', 's_2', 'Sol'};
OrigC = [-7.5 3 0 0 0 -1 -1 0];
Info = [3 -1 -1 -1 0 1 0 3; 1 -1 1 0 -1 0 1 2];
b = [3; 2];
BV = [6 7];

%Phase 1 of Method
Cost = [0 0 0 0 0 -1 -1 0];
A = Info;
StartBV = find(Cost<0);

ZjCj = Cost(BV)*A - Cost;
InitialTable = array2table([ZjCj;A]);
InitialTable.Properties.VariableNames(1:size(A,2)) = Variables;



fprintf('Phase 1 \n');
[BFS,A] = simp(A,BV,Cost,Variables);

%Phase 2
fprintf('Phase 2 \n');
A(:,StartBV) = [];
OrigC(:,StartBV) = [];
[OptBFS,OptA] = simp(A,BFS,OrigC,OVariables);


%Final Optimal Solution
FINAL_BFS = zeros(1,size(A,2));
FINAL_BFS(OptBFS) = OptA(:,end);
FINAL_BFS(end)=sum(FINAL_BFS.*OrigC);

OptimalBFS = array2table(FINAL_BFS);
OptimalBFS.Properties.VariableNames(1:size(OptimalBFS, 2)) = OVariables


