clear all
close all
% Getting an image
im	=	imread('Cameraman.tiff');	
%FIND	EDGES	
BW	=	edge(im,'canny');	
%COMPUTE	THE	HOUGH	TRANSFORM	
% [H,theta,rho]	=	hough(BW);	

% Initializing parameters
%we  decided to -90 to 90 degree value for theta based on the slides 
theta = (-90:90);
theta_min = min(theta)
theta_max = max(theta)
[y,x] = find(im);
% y = y - 1;
% x = x - 1;
%rho = cell(1,numel(x));
diag_img= diag(im);
rho_min = -length(diag_img)
rho_max = length(diag_img)

H = zeros(length(theta),length(rho_min:1:rho_max));
% Calculating the Hough Transform
for i = 1: numel(x)
    for theta = theta_min:1:theta_max
        rho = x(i)*cos(deg2rad(theta)) + y(i)*sin(deg2rad(theta));
        rho = round(rho);
        H(theta,rho) = H(theta,rho)+1;
    end
end
% Creating the Hough Space as an Image
for i = 1:numel(x)
    rho{i} = rho{i} + D; % mapping rho from 0 to 2*sqrt(2)
    rho{i} = floor(rho{i}) + 1;
    for j = 1:numel(rho{i})
        HS(rho{i}(j),j) = HS(rho{i}(j),j) + 1; 
    end
end
% f2=figure
% imshow(HS)
% imagesc(imadjust(rescale(HS),'XData',theta,'YData',rho))
% xlabe('\theta'),ylable('\rho');
% axis on, axis normal, hold on;