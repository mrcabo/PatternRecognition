%Lab2_6

close all

P_spam = 0.9;
P_noSpam = 1-P_spam;


Word_table = transpose(["Anti-aging", "Customers", "Fun", "Groningen", "Lecture", "Money", "Vacation", "Viagra", "Watches"]);
Word_table = lower(Word_table);

Word_spamProb = [0.00062 0.000000035;
    0.005 0.0001;
    0.00015 0.0007;
 	0.00001 0.001;
 	0.000015 0.0008;
 	0.002 0.0005;
 	0.00025 0.00014;
 	0.001 0.0000003;
 	0.0003 0.000004]; % SPAM | NO-SPAM


text = lower("We offer our dear customers a wide selection of classy watches");
text = lower("Did you have fun on vacation? I sure did!");


k = zeros(size(Word_table,1),1);
index = [];
for i = 1:size(Word_table,1)
    k(i) = count(text,Word_table(i));
    if k(i)>0
        index = [index i];
    end
%     k(i) = size(strfind(text,Word_table(i)),2);
end

P_B_spam = 1;
P_B_noSpam = 1;
for i = 1:size(index,2)
    P_B_spam = P_B_spam * Word_spamProb(index(i),1);
    P_B_noSpam = P_B_noSpam * Word_spamProb(index(i),2);
end

P_B_spam = P_B_spam * P_spam
P_B_noSpam = P_B_noSpam * P_noSpam

P = P_B_spam / P_B_noSpam


