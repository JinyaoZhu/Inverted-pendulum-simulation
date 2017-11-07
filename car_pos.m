function pos = car_pos(state,params)
% state = [theta;theta_dot;x;x_dot]
pos = zeros(2,1);
c = state(3);%center of the car
pos(:,1) = [c-params.L/2;-params.H];
end