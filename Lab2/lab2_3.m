close all

mu = [3 4];
Sigma = [1 0 ; 0 2];
x1 = -10:.25:10; x2 = -10:.25:10;
[X1,X2] = meshgrid(x1,x2);
F = mvnpdf([X1(:) X2(:)],mu,Sigma);
F = reshape(F,length(x2),length(x1));
surf(x1,x2,F);

rng('default') % For reproducibility
X = mvnrnd(mu,Sigma,1000);
d2_mahal = mahal([10 10],X);
Q2= round(d2_mahal,5,'significant')

d3_mahal = mahal([0 0],X);
Q3= round(d3_mahal,5,'significant')

d4_mahal = mahal([3 4],X);
Q4= round(d4_mahal,5,'significant')

d5_mahal = mahal([6 8],X);
Q5= round(d5_mahal,5,'significant')