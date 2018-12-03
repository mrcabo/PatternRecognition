mu1 = [3 5];
cov1 = [1 0;0 4];
inv_cov1 = inv(cov1);
diag1 = diag(cov1);
diag1_1 = diag1(1);
diag1_2 = diag1(2);
absolute1 = diag1_1*diag1_2;
ln_abs1 = log(absolute1)
p_w1=0.3;
ln_p_w1= log(p_w1)


mu2 = [2 1];
cov2=[2 0;0 1];
inv_cov2 = inv(cov2)
diag2 = diag(cov2);
diag2_1 = diag2(1);
diag2_2 = diag2(2);
absolute2 = diag2_1*diag2_2;
ln_abs2 = log(absolute2)

p_w2 = 0.7;
ln_p_w2 = log(p_w2)
% A =[0.5 0; 0 2];
% inv(A)
% B = [2 0;0 2];
% inv(B)
% size_mu1 = length(mu1);
% x=[];
% y = f(x,mu1,inv_cov1,ln_abs1,ln_p_w1)
% 
% function y =f(x,mu,inv_cov,ln_abs,ln_p_w)
%     y = -(1/2) .* transpose([x-mu(1),x-mu(2)]).* inv_cov*[x-mu(1),x-mu(2)]-(1/2)*ln_abs+ ln_p_w
% end
