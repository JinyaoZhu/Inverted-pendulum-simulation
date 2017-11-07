function sdot = PendulumEOM(t,current_state,params,trajhandle,controlhandle)
% equation of motion of inverted pendulum

desired_state = trajhandle(t,current_state,params);

u = controlhandle(t,current_state,desired_state,params);

sdot = PendulumEOM_readonly(t,current_state,u,params);

end