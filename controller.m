function u = controller(t,current_state,desired_state,params)

persistent K

if t == 0
    M = params.M;
    m = params.m;
    g = params.g;
    
    
    A = [0 1 0 0;(M+m)*g/M 0 0 0;0 0 0 1;m*g/M 0 0 0];
    B = [0;1/M;0;1/M];
    
    Q = [50 0 0 0;
        0 0 0 0;
        0 0 20 0;
        0 0 0 0];
    
    R = 1;
    
    K=lqr(A,B,Q,R);
end


u = K*(desired_state-current_state);

end