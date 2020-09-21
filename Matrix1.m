clc,
clear,
%1.) Make a 12x12 matrix and fill in with the numbers 1-144 column-wise
A = [ 1:12; 13:24; 25:36; 37:48; 49:60; 61:72; 73:84; 85:96; 97:108; 109:120; 121:132; 133:144]
%2.) Do the same as question 1 now row-wise.
B = A.'
C = A(end:-1:1,:)
%3.) Using the matrix from question 1, create a new matrix half the
%size of the original containing the odd columns and the even rows.
D = A(2:2:end,1:2:end)  % even rows, odd Columns
%4.) Using the matrix from question 1 create a Boolean matrix (0,1)
%indicating the elements greater than 30.
Z = ones(1,12)
F = [ 1:12; 13:24; 25:30 1 1 1 1 1 1; Z ; Z; Z; Z; Z; Z; Z; Z; Z]
FF = B > 30
%5.) Solve this system:
S = [ 1 1  1;2 1 0;0 1  1];
SS = [9; 3; 5];
Solve = linsolve(S,SS)