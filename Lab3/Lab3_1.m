close all

mu1 = 5;
mu2 = 7;
sigma = sqrt(4);

pd1 = makedist('Normal','mu',mu1,'sigma',sigma);
pd2 = makedist('Normal','mu',mu2,'sigma',sigma);

x_values = 0:.1:16;
pdf_normal1 = pdf(pd1,x_values);
pdf_normal2 = pdf(pd2,x_values);
plt1 = plot(x_values,pdf_normal1,'LineWidth',2)
hold on
plt2 = plot(x_values,pdf_normal2,'LineWidth',2)



x_decisionCrit = 10

p_fa = 1-normcdf(x_decisionCrit,mu1,sigma)
p_hit = 1-normcdf(x_decisionCrit,mu2,sigma)

discriminability = abs(mu2-mu1)/sigma

lab3_1_data = load('./Data/lab3_1.mat');

binData = num2str(lab3_1_data.outcomes);
decData = bin2dec(binData);

close all

h = histogram(decData)
signal_present = h.Values(4)+ h.Values(3);
signal_notPresent = h.Values(1) + h.Values(2);
hit_rate = h.Values(4) / signal_present
fa = h.Values(2) / signal_notPresent
scatter(fa,hit_rate)
hold on

% labels = []
% rocs = []
% mu2 = mu2 + 2;
% for i = 1:10
%     p_fa_test = 1-normcdf(x_values,mu1,sigma);
%     p_hit_test = 1-normcdf(x_values,mu2,sigma);
%     rocs = [rocs; plot(p_fa_test, p_hit_test)];
%     discriminability = abs(mu2-mu1)/sigma
%     roc_name = sprintf('d=%1.2f',discriminability)
%     labels = [labels;roc_name];
%     mu2 = mu2 + 0.05
%     hold on
% end

mu2 = 9.25
p_fa_test = 1-normcdf(x_values,mu1,sigma);
p_hit_test = 1-normcdf(x_values,mu2,sigma);
discriminability = abs(mu2-mu1)/sigma
plot(p_fa_test, p_hit_test)
rocs = 'HIT/FA value';
labels = sprintf('d=%1.3f',discriminability);
xlabel('False positive rate')
ylabel('True positive rate')


legend(rocs,labels)
