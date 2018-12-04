close all;

mu1 = [3 ; 5];
trans_mu1 = transpose(mu1);
cov1 = [1 0;0 4];
inv_cov1 = inv(cov1);
diag1 = diag(cov1);
diag1_1 = diag1(1);
diag1_2 = diag1(2);
absolute1 = diag1_1*diag1_2;
ln_abs1 = log(absolute1);
p_w1=0.3;
ln_p_w1= log(p_w1);


mu2 = [2 ; 1];
trans_mu2 = transpose(mu2);
cov2=[2 0;0 1];
inv_cov2 = inv(cov2);
diag2 = diag(cov2);
diag2_1 = diag2(1);
diag2_2 = diag2(2);
absolute2 = diag2_1*diag2_2;
ln_abs2 = log(absolute2);

p_w2 = 0.7;
ln_p_w2 = log(p_w2);

syms x y 
g_x1 =  -(1/2) * [x-trans_mu1(1),y-trans_mu1(2)]* inv_cov1*[x-mu1(1) ; y-mu1(2)] -(1/2)*ln_abs1+ ln_p_w1;
lab_g_x1 = expand(vpa(g_x1,5))


g_x2 =  -(1/2) * [x-trans_mu2(1),y-trans_mu2(2)]* inv_cov2*[x-mu2(1) ; y-mu2(2)]-(1/2)*ln_abs2+ ln_p_w2;
lab_g_x2 = expand(vpa(g_x2,5))

decision_boundary = g_x1-g_x2;
lab_decision_boundary = expand(vpa(decision_boundary,5))

f(x,y) = decision_boundary;

fimplicit(f, [-10 20])
xlabel("X axis")
ylabel("Y axis")


