function [H,T,R] = myhough(BW)

%% Initializing parameters
%Theta is from -90 to 89 degree based on the convention on the slides and
%also we want it to be 180 degrees
theta_arr = (-90:89);
% find the foreground pixels of the edge map
[y,x] = find(BW);
%Based on the conventions on slides rho should be between -image diag and
%image diag
diag_img= diag(BW);
rho_min = -length(diag_img);
rho_max = length(diag_img);
rho_array = (rho_min:rho_max);
H = zeros(length(theta_arr),length(rho_array));

%% Calculating the Hough Transform. 
%For each foreground pixel(x,y) in the edge map we calculate the values of
%rho based on the equasion in the assignment and create the accumulator
%array
for i = 1: numel(x)
    thetai= 0;
    for theta = theta_arr
        thetai = thetai + 1;
        rho = x(i)*cos(deg2rad(theta)) + y(i)*sin(deg2rad(theta));
        rho = floor(rho);
        rho_index = find(rho_array==rho,1);
        H(thetai,rho_index) = H(thetai,rho_index)+1;
    end
end
H = transpose(H);
T = theta_arr;
R = rho_array;
end

