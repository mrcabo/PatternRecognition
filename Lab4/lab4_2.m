% clear all
close all
% Getting an image
filename = './Data/Cameraman.tiff';
im = imread(filename);
%FIND	EDGES	
BW = edge(im,'canny');
f1 = figure;
imshow(BW)
%COMPUTE	THE	HOUGH	TRANSFORM	
[HS,TS,RS] = hough(BW);	

[H,T,R] = myhough(BW);

f2 = figure;
sgtitle("S3736555 , S3559734")
subplot(1,2,1);
imagesc(imadjust(rescale(H)),'XData',T,'YData',R)
title("myhough.m");
xlabel('\theta'),ylabel('\rho');
subplot(1,2,2);
imagesc(imadjust(rescale(HS)),'XData',TS,'YData',RS)
title("Matlab's hough");
xlabel('\theta'),ylabel('\rho');
axis on, axis normal, hold on;