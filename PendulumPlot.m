classdef PendulumPlot < handle
    % Visualization class of inverted pendulum
    
    properties(SetAccess = public)
        k = 0;
        time = 0;
        num_state = 4;
        state;%system state;
        desired_state;%desired state
        params;%parameters of the inverted pendulum system
        pos_car; %position of the car
        pos_pend;%psoition of the pendulum;
        
        state_hist;%state history
        desired_state_hist;%desired state history
        time_hist;%time history
        max_iter;%max interation
    end
    
    properties(SetAccess = private)
        h_graphic;
        h_car;%handle of the car;
        h_pend;%handle of the pendulum
        h_pend_hat;
    end
    
    methods
        %Constructor
        function P = PendulumPlot(state,params,max_iter,h_graphic)
            P.state = state;
            P.desired_state = zeros(P.num_state,1);
            P.params = params;
            P.pos_car = car_pos(state,params);
            P.pos_pend = pend_pos(state,params);
            P.max_iter = max_iter;
            P.state_hist = zeros(P.num_state,max_iter);
            P.desired_state_hist = zeros(P.num_state,max_iter);
            P.time_hist = zeros(1,max_iter);
            
            P.h_graphic = h_graphic;
            hold(P.h_graphic,'on');
%             axis(P.h_graphic,[-0.3 0.3 -P.params.H P.params.l+0.02]); 
            axis(P.h_graphic,[-1 1 -P.params.H P.params.l+0.02]); 
            P.h_car = rectangle('Position',[P.pos_car(1,1),P.pos_car(2,1),P.params.L,P.params.H],'FaceColor',[0,0.8,1]);
            P.h_pend = plot(P.h_graphic,P.pos_pend(1,:),P.pos_pend(2,:),'LineWidth',2,'Color',[1,0.2,0]);
            P.h_pend_hat = rectangle(P.h_graphic,'Position',[P.pos_pend(1,2)-0.01,P.pos_pend(2,2)-0.01,0.02,0.02],'Curvature',[1 1],'FaceColor',[0,1,0.6]);
            hold(P.h_graphic,'off');
        end
        
        %Update pendulum's state
        function UpdatePendulumState(P,state,time)
            P.state = state;
            P.time = time;
        end
        
        %Update pendulum's desired state
        function UpdateDesiredPendulumState(P,desired_state)
            P.desired_state = desired_state;
        end
        
        %Update pendulum history
        function UpdatePendulumHistory(P)
            P.k = P.k+1;
            P.time_hist(P.k) = P.time;
            P.state_hist(:,P.k) = P.state;
            P.desired_state_hist(:,P.k) = P.desired_state;
        end
        
        %Update positon the car and pendulum
        function UpdatePendulumPosition(P)
            P.pos_car = car_pos(P.state,P.params);
            P.pos_pend = pend_pos(P.state,P.params);
        end
        
        %Update pendulum plot
        function UpdatePendulumPlot(P,state,desired_state,time)
            P.UpdatePendulumState(state,time);
            P.UpdateDesiredPendulumState(desired_state);
            P.UpdatePendulumHistory();
            P.UpdatePendulumPosition()
            
            set(P.h_car,'Position',...
                [P.pos_car(1,1),P.pos_car(2,1),P.params.L,P.params.H]);
            
            set(P.h_pend_hat,...
                'Position',...
                [P.pos_pend(1,2)-0.01,P.pos_pend(2,2)-0.01,0.02,0.02]);
            
            set(P.h_pend,...
                'XData',P.pos_pend(1,:),...
                'YData',P.pos_pend(2,:));
            
            
            
            drawnow;
        end
    end
    
end