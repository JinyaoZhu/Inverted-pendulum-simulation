function desired_state = trajectory_generator(t,current_state,params)
if t <= 1
desired_state = [0;0;-0.5;0];
else
desired_state = [0;0;0;0];
end

if (t>5) && (t<5.1)
desired_state(2) = 2.0;
end

if (t>15) && (t<15.1)
desired_state(2) = 2.0;
end

end