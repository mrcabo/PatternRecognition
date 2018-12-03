%Lab2_2

syms a b c d k

v = [a c;b d];
%v = [a+k c+k;b+k d+k];
v = [a*k c*k;b*k d*k];
v = transpose(v)

mu = [mean(v(:,1)) mean(v(:,2))];

covM = sym(zeros(size(v,2)));

N = size(v,1);
for i= 1:size(v,2)
    for j= 1:size(v,2)
        for n= 1:size(v,1)
        covM(i,j) = covM(i,j) + (v(n,i)-mu(i))*(v(n,j)-mu(j));
        end
        covM(i,j) = covM(i,j)/(N-1);
    end
end

mine = simplify(covM)
matlab = simplify(cov(v));