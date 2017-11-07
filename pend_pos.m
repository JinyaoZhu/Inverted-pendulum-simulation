function pos = pend_pos(state,params)
% state = [theta;theta_dot;x;x_dot]
pos = zeros(2,2);
l = params.l;%length of the pendulum
x = state(3);
theta = state(1);
pos(:,1) = [state(3),0];
pos(:,2) = [x-l*sin(theta);l*cos(theta)];
end