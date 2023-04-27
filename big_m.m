format short
clear all
clc

%Always convert Minimization to Maximization
%multiply z by -1 to do that

Variables = {'x_1', 'x_2', 's_2', 's_3', 'A_1', 'A_2', 'Sol'};
M = 1000;
Cost = [-2 -1 0 0 -M -M 0];
A = [3 1 0 0 1 0 3; 4 3 -1 0 0 1 6; 1 2 0 1 0 0 3];
s = eye(size(A, 1));

%Starting BFS
BV=[];
for j = 1:size(s,2)
    for i=1:size(A,2)
        if A(:,i) == s(:,j)
            BV = [BV i];
        end
    end
end

%Computing value of table
B = A(:, BV);
A = inv(B)*A;
ZjCj = Cost(BV)*A-Cost;

ZCj = [ZjCj; A];
SimpTable = array2table(ZCj);
SimpTable.Properties.VariableNames(1:size(ZCj, 2)) = Variables

RUN = true;
while RUN

    %Finding the entering variable
    ZC = ZjCj(:, 1:end-1);
    if any(ZC < 0);
        fprintf("Current BFS is not Optimal \n");
        [Entval, pvt_col] = min(ZC);
        fprintf('Entering Column = %d \n', pvt_col);
        sol = A(:, end);
        Column = A(:, pvt_col);
        if all(Column) <= 0
            fprintf('Solution is Unbounded \n');
        else
            for i = 1:size(Column, 1)
                if Column(i) > 0
                    ratio(i) = sol(i)./Column(i);
                else
                    ratio(i) = inf;
                end
            end

            [minR, pvt_row] = min(ratio);
            fprintf('Leaving row = %d \n', pvt_row);

            BV(pvt_row) = pvt_col;
            B = A(:, BV);
            A = inv(B)*A;
            ZjCj = Cost(BV)*A - Cost;

            ZCj = [ZjCj; A];
            TABLE = array2table(ZCj);
            TABLE.Properties.VariableNames(1:size(ZCj, 2)) = Variables
        end
    else
        RUN = false;
        fprintf('Current BFS is optimal \n');
    end
end
FINAL_BFS = zeros(1, size(A,2));
FINAL_BFS(BV) = A(:,end);
FINAL_BFS(end) = sum(FINAL_BFS.*Cost);

OptimalBFS = array2table(FINAL_BFS);
OptimalBFS.Properties.VariableNames(1:size(OptimalBFS,2)) = Variables