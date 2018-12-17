close all;
% Load image, and equalize it
filename = './Data/HeadTool0002.bmp';
img_d = im2double(imread(filename));
J = adapthisteq(img_d);

imshow(J)

radiusRange = [20 40];
sensitivity = 0.9;
% Find circles  with radius within the range 20-40, and sensitivity 0.9
[centers, radii, metric] = imfindcircles(J,radiusRange,'Sensitivity',sensitivity);
% Overlay image and circles
nCircles = length(centers);
centersStrong = centers(1:nCircles,:); 
radiiStrong = radii(1:nCircles);
metricStrong = metric(1:nCircles);
viscircles(centersStrong, radiiStrong,'EdgeColor','b');
title('S3736555 & S3559734');
% Display only 2 circles
N_circles = 2;
f2 = figure;
imshow(J)
viscircles(centersStrong(1:N_circles,:), radiiStrong(1:N_circles,:),'EdgeColor','b');
title('S3736555 & S3559734');

