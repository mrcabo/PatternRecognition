rng default;

close all;

Npeople = 1000000;
Ntrials = 100;


scores = zeros(Ntrials, Npeople);
score_sum = zeros(1, Npeople);

for i = 1:Npeople
%     scores(:,i) = binornd(1, 0.5, [100,1]);
    score_sum(i) = binornd(100, 0.5);
end

h = histogram(score_sum)
xlabel('N� tails in a 100 throws')
ylabel('N� people with same score')
% plot()