format short 
clear all
clc

Cost = [11 20 7 8; 21 16 10 12; 8 12 18 9];
A = [50 40 70];
B = [30 25 35 40];

if sum(A) == sum(B)
    fprintf("Is Balanced \n");
else
    fprintf("Is Unbalanced \n");
    if sum(A)<sum(B)
        Cost(end+1,:)=zeros(1,size(A,2));
        A(end+1)=sum(B)-sum(A);
    elseif sum(B)<sum(A)
        Cost(:,end+1) = zeros(1,size(A,2));
        B(end+1)=sum(A)-sum(B);
    end
end

ICost = Cost;
X = zeros(size(Cost));
[m,n] = size(Cost);
BFS = m+n-1;

for i=1:size(Cost,1)
    for j=1:size(Cost,2)
hh = min(Cost(:));
[rowind, colind] = find(hh==Cost);
x11 = min(A(rowind),B(colind));
[val,ind] = max(x11);
ii = rowind(ind);
jj = colind(ind);
y11 = min(A(ii),B(jj));
X(ii,jj) = y11;
A(ii) = A(ii) - y11;
B(jj) = B(jj)- y11;
Cost(ii,jj) = Inf;
    end
end


fprintf('Initial BFS \n');
IB = array2table(X);
disp(IB);

TotalBFS = length(nonzeros(X));
if TotalBFS == BFS
    fprintf('Non Deg \n');
else 
    fprintf('Deg \n');
end

InitialCost = sum(sum(ICost.*X));

fprintf('Initial BFS Cost = %d \n', InitialCost);
