function [t,s] = simulation(trajhandle,controlhandle)
real_time = true;
video = false;
max_time = 25;
params = sys_params;

%% *****************************Figure*****************************
disp('Initialing Figure...')

if video
  video_writer = VideoWriter('test_inverted_pendulum','Uncompressed AVI');
  open(video_writer);
end

h_graphic = gca;
axis equal;
grid;
xlabel('X [m]');
ylabel('Y [m]');
set(gcf,'Renderer','opengl');
%% **************************Initial Condition*********************
disp('Setting initial conditions...')
tstep = 0.01;
cstep = 0.025;
max_iter = max_time/cstep;
time = 0;

x = trajhandle(0); %inital state

desired_state = trajhandle(0);

%% *****************************Simulation*************************
disp('Simulation running...');
for iter = 1:max_iter
    tic;
    
    timeint = time:tstep:time+cstep;
    
    if iter == 1
        PP = PendulumPlot(x,params,max_iter,h_graphic);
        PP.UpdatePendulumPlot(x,desired_state,time);
        h_title = title(sprintf('iteration:%d, time:%4.2f',iter,time));
    end
    
    %run simulation
    [~,xsave] =ode45(@(t,s) PendulumEOM(t,s,params,trajhandle,controlhandle),timeint,x);
    x = xsave(end,:)';
    
    x(1) = min(max(x(1),-pi/2),pi/2);
    x(2) = x(2)+randn()*0.001;
    x(4) = x(4)+randn()*0.001;
    
    time = time+cstep;
    
    if video
      writeVideo(video_writer, getframe(h_graphic));
    end
    
    %plot pendulum 
    desired_state = trajhandle(time,x);
    PP.UpdatePendulumPlot(x,desired_state,time);
    set(h_title, 'String', sprintf('iteration: %d, time: %4.2f', iter, time));
    
    t = toc;
    
    if t>cstep*50
        disp('Ode45 unstable!');
        break;
    end
    
    if real_time && (t < cstep)
        pause(cstep-t);
    end
    
    if(time > max_time)
        break;
    end
end

if video
  close(video_writer);
end

%% *****************************Post proccess**********************
t = PP.time_hist;
s = PP.state_hist;
des_s = PP.desired_state_hist;

figure;
plot(t,s(1,:),'r-',t,des_s(1,:),'b-');
legend('actual','desired');
title('angle');
grid;

figure;
plot(t,s(3,:),'r-',t,des_s(3,:),'b-');
legend('actual','desired');
title('position');
grid;
end