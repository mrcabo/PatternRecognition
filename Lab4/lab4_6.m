clear all;
close all;
% Load image, and equalize it
filename = './Data/dogGrayRipples.png';
I = im2double(imread(filename));

f1 = figure;
f = fft2(I);
fs = fftshift(f);
f = abs(fs);
f = log(1+f);
imshow(f,[])
y = [121;181];
x = [167;167];
% [x,y] = getpts;
r = 10;
rows = size(f,1); cols = size(f,2); radius = r; center = [x';y'];
mask = zeros(size(f));
[xMat, yMat] = meshgrid(1:cols,1:rows);

for i = 1:size(center,2)
    distFromCenter = sqrt((xMat-center(1,i)).^2 + (yMat-center(2,i)).^2);
    mask(distFromCenter<=radius) = 1;
end

f2 = figure;
figure(f2)
imshow(~mask,[]);title('Mask')

fs = fs.*(~mask);
f = ifftshift(fs);
I = real(ifft2(f));

f3 = figure;
figure(f3)
imshow(I,[]);
title('S3736555')
% title('S3559734')
