close all

h = 1;

u = [0.5 1.0 0.0];
v = [0.31 1.51 -.50];
w = [-1.7 -1.7 -1.7];

cat1 = load('./Data/lab3_3_cat1.mat');
cat2 = load('./Data/lab3_3_cat2.mat');
cat3 = load('./Data/lab3_3_cat3.mat');


result_u = calcPhi(h, u, cat1.x_w1, cat2.x_w2, cat3.x_w3);
result_v = calcPhi(h, v, cat1.x_w1, cat2.x_w2, cat3.x_w3);
result_w = calcPhi(h, w, cat1.x_w1, cat2.x_w2, cat3.x_w3);




% scatter3(cat1.x_w1(:,1),cat1.x_w1(:,2),cat1.x_w1(:,3))



function result = calcPhi(h, vector, cat1, cat2, cat3)
    result = zeros(1,3);
    phi = zeros(10,1);
    
    %cat 1
    for j = 1:10
        phi(j) = exp(-1*((vector(1)-cat1(j,1))^2 + (vector(2)-cat1(j,2))^2 + (vector(3)-cat1(j,3))^2) / (2*h^2));
    end
    sumPhi = sum(phi);
    aux = sumPhi / (h*sqrt(2*pi))^3;
    result(1) = aux / 10;
    
    %cat 2
    for j = 1:10
        phi(j) = exp(-1*((vector(1)-cat2(j,1))^2 + (vector(2)-cat2(j,2))^2 + (vector(3)-cat2(j,3))^2) / (2*h^2));
    end
    sumPhi = sum(phi);
    aux = sumPhi / (h*sqrt(2*pi))^3;
    result(2) = aux / 10;
    
    %cat 3
    for j = 1:10
        phi(j) = exp(-1*((vector(1)-cat3(j,1))^2 + (vector(2)-cat3(j,2))^2 + (vector(3)-cat3(j,3))^2) / (2*h^2));
    end
    sumPhi = sum(phi);
    aux = sumPhi / (h*sqrt(2*pi))^3;
    result(3) = aux / 10; 
    
end