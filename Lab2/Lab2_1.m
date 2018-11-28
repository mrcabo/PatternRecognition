%Lab2_1
fv = transpose([4 6 8 7 4;5 3 7 4 6;6 9 3 8 5]);

fv_mean = [mean(fv(:,1)) mean(fv(:,2)) mean(fv(:,3))]

N = size(fv, 1);

C_unbiased = cov(fv)

C_biased = (N-1)*C_unbiased / N % MLE biased cov

mvn = mvnpdf(%this is probably the vector they give ..fv,fv_mean,C_biased)