%Lab2_1
fv = transpose([4 6 8 7 4;5 3 7 4 6;6 9 3 8 5]);

fv_mean = [mean(fv(:,1)) mean(fv(:,2)) mean(fv(:,3))]

N = size(fv, 1);

% C_unbiased = cov(fv)

C_biased = (N-1)*C_unbiased / N % MLE biased cov



q14 = [5 5 6]
q15 = [3 5 7]
q16 = [4 6.5 1]

mvn14 = round(mvnpdf(q14,fv_mean,C_biased),6,'significant')
mvn15 = round(mvnpdf(q15,fv_mean,C_biased),6,'significant')
mvn16 = round(mvnpdf(q16,fv_mean,C_biased),6,'significant')
