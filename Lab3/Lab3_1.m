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


lab3_1_data = load('X:\My Documents\PatternRecognition\repo\Lab3\Data\lab3_1.mat');

binData = num2str(lab3_1_data.outcomes);
decData = bin2dec(binData);

close all

h = histogram(decData)
signal_present = h.Values(4)+ h.Values(3);
signal_notPresent = h.Values(1) + h.Values(2);
hit_rate = h.Values(4) / signal_present
fa = h.Values(2) / signal_notPresent


close all

a = []
b = [hit_rate, fa]
c = 'hit'



[X,Y] = perfcurve(a,b,c);
plot(X,Y)

