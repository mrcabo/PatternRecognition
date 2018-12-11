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



mu1 = mean(cat1.x_w1);
mu2 = mean(cat2.x_w2);
mu3 = mean(cat3.x_w3);

l = h/2;

count = 0;
for i = 1:10
    if abs(mu1(1)-cat1.x_w1(i,1)) < l && abs(mu1(2)-cat1.x_w1(i,2)) < l && abs(mu1(3)-cat1.x_w1(i,3)) < l
        count = count + 1;
    end
end
prior1 = count / 10

count = 0;
for i = 1:10
    if abs(mu2(1)-cat2.x_w2(i,1)) < l && abs(mu2(2)-cat2.x_w2(i,2)) < l && abs(mu2(3)-cat2.x_w2(i,3)) < l
        count = count + 1;
    end
end
prior2 = count /10

count = 0;
for i = 1:10
    if abs(mu3(1)-cat3.x_w3(i,1)) < l && abs(mu3(1)-cat3.x_w3(i,2)) < l && abs(mu3(1)-cat3.x_w3(i,3)) < l
        count = count + 1;
    end
end
prior3 = count / 10

% for i = 1:10
%     aux = cat1.x_w1(i,1)*cat1.x_w1(i,2)*cat1.x_w1(i,3);
%     if aux <= 1
%         count = count + 1;
%     end        
% end
% prior1 = count / 10




scatter3(cat1.x_w1(:,1),cat1.x_w1(:,2),cat1.x_w1(:,3))
hold on 
scatter3(mu1(1),mu1(2),mu1(3),'MarkerFaceColor',[0 .75 .75])
% scatter3(cat2.x_w2(:,1),cat2.x_w2(:,2),cat2.x_w2(:,3))



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