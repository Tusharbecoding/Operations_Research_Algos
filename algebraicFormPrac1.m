format short
clear all
clc

C = [2 3 4 7];
A = [2 3 -1 4; 1 -2 6 -7];
b = [8; -3];

m = size(A,1);
n = size(A,2);

nv = nchoosek(n,m);
t = nchoosek(1:n,m);

sol = [];
if n>=m
    for i = 1:nv
        y = zeroes(n,1);
        x = A(:,t(i,:))\b;
        