close all

data_lvq_A = load('E:\RUG\2-2\Pattern Recognition\Labs\Lab5/Data/data_lvq_A.mat');
data_lvq_B = load('E:\RUG\2-2\Pattern Recognition\Labs\Lab5/Data/data_lvq_B.mat');
data_lvq_A = data_lvq_A.matA;
data_lvq_B = data_lvq_B.matB;

n = size(data_lvq_A,1);
m = ceil(n/10);
k = 1:m:n
A_1 = data_lvq_A(k(1):k(1)+m-1,:);
A_2 = data_lvq_A(k(2):k(2)+m-1,:);
A_3 = data_lvq_A(k(3):k(3)+m-1,:);
A_4 = data_lvq_A(k(4):k(4)+m-1,:);
A_5 = data_lvq_A(k(5):k(5)+m-1,:);
A_6 = data_lvq_A(k(6):k(6)+m-1,:);
A_7 = data_lvq_A(k(7):k(7)+m-1,:);
A_8 = data_lvq_A(k(8):k(8)+m-1,:);
A_9 = data_lvq_A(k(9):k(9)+m-1,:);
A_10 = data_lvq_A(k(10):k(10)+m-1,:);

B_1 = data_lvq_B(k(1):k(1)+m-1,:);
B_2 = data_lvq_B(k(2):k(2)+m-1,:);
B_3 = data_lvq_B(k(3):k(3)+m-1,:);
B_4 = data_lvq_B(k(4):k(4)+m-1,:);
B_5 = data_lvq_B(k(5):k(5)+m-1,:);
B_6 = data_lvq_B(k(6):k(6)+m-1,:);
B_7 = data_lvq_B(k(7):k(7)+m-1,:);
B_8 = data_lvq_B(k(8):k(8)+m-1,:);
B_9 = data_lvq_B(k(9):k(9)+m-1,:);
B_10 = data_lvq_B(k(10):k(10)+m-1,:);

%train = [data_lvq_A(1:k-1,:); data_lvq_A(k+m:end,:)]
%adj=edge(train,data_lvq_A);