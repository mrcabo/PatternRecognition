load('X:\My Documents\PatternRecognition\lab1-data\lab1_1.mat')

corrcoef = corrcoef(lab1_1)

figure(1)
s = scatter(lab1_1(:,1),lab1_1(:,3))
s.MarkerEdgeColor = 'r'
xlabel('height')
ylabel('weight')


figure(2)
s = scatter(lab1_1(:,2),lab1_1(:,3))
s.MarkerEdgeColor = 'g'
xlabel('age')
ylabel('weight')
