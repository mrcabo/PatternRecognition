function [H,T,R] = myhough(BW)

% Initializing parameters
%we  decided to -90 to 90 degree value for theta based on the slides 
theta_arr = (-90:89);
[y,x] = find(BW);

diag_img= diag(BW);
rho_min = -length(diag_img);
rho_max = length(diag_img);
rho_array = (rho_min:rho_max);
H = zeros(length(theta_arr),length(rho_array));

% Calculating the Hough Transform
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

