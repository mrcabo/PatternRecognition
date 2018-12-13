% Decide on a discrete set of values of rho  and theta  to use. 
% The function myhough should accept an edge map as input and output the accumulator array.
% You can follow these steps as guidelines in writing your function:  (remember to sufficiently comment your code)
% Determine which values of  theta  you are going to use.
% Find the foreground pixels of the edge map.
% For each foreground pixel left parenthesis x comma y right parenthesis  in the edge map calculate the values of rho  according to (equation 1), for all of your chosen values of theta . Round  values to the nearest integer less than or equal to the obtained rho  value.
%  Initialize a two-dimensional accumulator array. The size of the array is determined by the number of angles theta ., and values  rho . (hint: You can first find the largest positive value of the computed   rho values,  rho max, and use  rho max + 1 as one dimension of the array, to allow for  rho  = 0).
% Step through all of the values of  rho  updating the accumulator array as you go.


clear all
close all
% Creating a simple image
im = zeros(101,101);
im(1,1) = 1;
im(1,end) = 1;
im(end,1) = 1;
im(end,end) = 1;
im(floor(end/2),floor(end/2)) = 1;
figure
imshow(im)
%% Initializing other parameters
theta = ((-90:90)./180) .* pi;
D = sqrt(size(im,1).^2 + size(im,2).^2);
HS = zeros(ceil(2.*D),numel(theta));
[y,x] = find(im);
y = y - 1;
x = x - 1;
figure
rho = cell(1,numel(x));
%% Calculating the Hough Transform
for i = 1: numel(x)
    rho{i} = x(i).*cos(theta) + y(i).*sin(theta); % [-sqrt(2),sqrt(2)]*D rho interval
    plot(theta,-rho{i})
    hold on
end
%% Creating the Hough Space as an Image
for i = 1:numel(x)
    rho{i} = rho{i} + D; % mapping rho from 0 to 2*sqrt(2)
    rho{i} = floor(rho{i}) + 1;
    for j = 1:numel(rho{i})
        HS(rho{i}(j),j) = HS(rho{i}(j),j) + 1; 
    end
end
figure
imshow(HS)
