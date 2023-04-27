format short
clear all
clc

%if Min type then conver to Max type 
Noofvariables = 3;
C = [-1 3 -2];
Info = [3 -1 2; -2 4 0; -4 3 8];
b = [7; 12; 10];
s = eye(size(Info, 1));

A = [Info s b]

Cost = zeros(1,size(A,2));
Cost(1:Noofvariables) = C;

%Constraint BV
BV = Noofvariables+1:1:size(A,2)-1;

%Calculate Zj-Cj ROW
ZjCj = Cost(BV)*A - Cost;

%Printing table
ZCj = [ZjCj ; A];
SimpTable = array2table(ZCj);
SimpTable.Properties.VariableNames(1:size(ZCj,2)) = {'x_1', 'x_2', 'x_3', 's_1', 's_2', 's_3', 'Sol'}

RUN = true;
while RUN

if any(ZjCj<0);
    disp('Position of old basic variable = ');
    disp(BV);
    %finding the entering variable 
    ZC = ZjCj(1:end-1);
    [EnterCol, pvt_col] = min(ZC); 
    fprintf('The most -ve element in Zj-Cj row is %d Corresponding to column %d \n', EnterCol, pvt_col);
    fprintf('Entering variable is %d \n', pvt_col);
    %finding leaving variable
    sol = A(:, end);
    Column = A(:,pvt_col);
    if all(Column <=0)
        error('Lpp is unbounded');
    else    
    for i=1:size(Column,1)
        if Column(i) > 0
            ratio(i) = sol(i)./Column(i);
        else
            ratio(i) = inf;
        end
    end
    [MinRatio, pvt_row] = min(ratio); 
    fprintf('Min ratio corresponding to pivot row is %d \n',pvt_row);
    fprintf('Leaving variable is %d \n', BV(pvt_row));
    end 

    BV(pvt_row) = pvt_col;
    disp('New Basic Variables (BV) = ');
    disp(BV);

    %pivot key
    pvt_key = A(pvt_row, pvt_col);

    A(pvt_row,:) = A(pvt_row,:)./pvt_key;
    for i=1:size(A,1)
        if i ~=pvt_row
            A(i,:) = A(i,:) - A(i,pvt_col).*A(pvt_row,:);
        end
    end
        ZjCj = ZjCj - ZjCj(pvt_col).*A(pvt_row,:);

        ZCj = [ZjCj ; A];
        SimpTable = array2table(ZCj);
        SimpTable.Properties.VariableNames(1:size(ZCj,2)) = {'x_1', 'x_2', 'x_3', 's_1', 's_2', 's_3', 'Sol'}

        BFS = zeros(1,size(A,2));
        BFS(BV) = A(:,end);
        BFS(end) = sum(BFS.*Cost);
        Current_BFS = array2table(BFS);
        Current_BFS.Properties.VariableNames(1:size(Current_BFS,2)) = {'x_1', 'x_2', 'x_3', 's_1', 's_2', 's_3', 'Sol'}
    
else
    RUN = false;
    fprintf('Current BFS is optimal');
end    
end