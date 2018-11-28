
close all
n = 10000;

%set S (same people)
HD_setS = zeros(n,1);
for i = 1:n

    person = randi([1 20],1);

    s = sprintf('lab1-data/person%02d.mat',person);

    person_data = load(s);

    i_row = randi([1 20],1,2);
    while i_row(1)==i_row(2)
        i_row = randi([1 20],1,2);
    end

    row1 = person_data.iriscode(i_row(1),:);
    row2 = person_data.iriscode(i_row(2),:);
    HD_setS(i) = pdist2(row1, row2,'hamming');

end

%set D (different people)
HD_setD = zeros(n,1);
for i = 1:n

    i_person = randi([1 20],1,2);
    while i_person(1)==i_person(2)
        i_person = randi([1 20],1,2);
    end
    
    s1 = sprintf('lab1-data/person%02d.mat',i_person(1));
    s2 = sprintf('lab1-data/person%02d.mat',i_person(2));

    person1_data = load(s1);
    person2_data = load(s2);

    i_row = randi([1 20],1,2);

    row_p1 = person1_data.iriscode(i_row(1),:);
    row_p2 = person2_data.iriscode(i_row(2),:);
    HD_setD(i) = pdist2(row_p1, row_p2,'hamming');

end


h1 = histogram(HD_setD)
hold on
h2 = histogram(HD_setS)
xlabel('Hamming distance')
legend('setD', 'setS')

%decision criterion
d = 0.2; %0.2007

pd_setS = fitdist(HD_setS,'Normal');
pd_setD = fitdist(HD_setD,'Normal');

sprintf('setS - mean:%2.4f; sigma:%2.4f', pd_setS.mu, pd_setS.sigma)
sprintf('setD - mean:%2.4f; sigma:%2.4f', pd_setD.mu, pd_setD.sigma)

pH0 = normcdf(d,pd_setD.mu,pd_setD.sigma)


x_values = 0:.001:1;
y_D = pdf(pd_setD,x_values);
y_S = pdf(pd_setS,x_values);

y_D_norm = (y_D/max(y_D))*max(h1.Values);
y_S_norm = (y_S/max(y_S))*max(h2.Values);

plot(x_values,y_D_norm,'LineWidth',2);
hold on
plot(x_values,y_S_norm,'LineWidth',2);

%plot norm dist

norm = normcdf(d,pd_setS.mu,pd_setS.sigma)

False_reject_rate = 1 - norm

 s2 = sprintf('lab1-data/testperson.mat');
 test_person_data = load(s2);
 test_iris = test_person_data.iriscode;
 test_without_missing = zeros(1,30);
 temp_person_iriscode = zeros(1,30);
 hist=[];
 temp_closest_person = [];
 for a = 1:20
     s1 = sprintf('lab1-data/person%02d.mat',a);
     person1_data = load(s1);
     final_HD = 0;
     for i = 1:20
         row_i = person1_data.iriscode(i,:);
         for j = 1:30
             if test_iris(j)~=2
                 test_without_missing(j) = test_iris(j);
                 temp_person_iriscode(j) = row_i(j);
             end
         end
         HD_test_person = pdist2(test_without_missing, temp_person_iriscode,'hamming');
         final_HD = final_HD + HD_test_person;
         index_of_person_of_interest= a;
         
     end
     hist(a) = final_HD/20
    
 end
 Minimun_hd = min(hist)
