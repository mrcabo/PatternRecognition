close all

mu1 = 5;
mu2 = 7;
sigma = sqrt(4);

pd1 = makedist('Normal','mu',mu1,'sigma',sigma);
pd2 = makedist('Normal','mu',mu2,'sigma',sigma);

x_values = 0:.1:14;
pdf_normal1 = pdf(pd1,x_values);
pdf_normal2 = pdf(pd2,x_values);
plt1 = plot(x_values,pdf_normal1,'LineWidth',2)
hold on
plt2 = plot(x_values,pdf_normal2,'LineWidth',2)



x_decisionCrit = 10

p_fa = 1-normcdf(x_decisionCrit,mu1,sigma)
p_hit = 1-normcdf(x_decisionCrit,mu2,sigma)

discriminability = abs(mu2-mu1)/sigma