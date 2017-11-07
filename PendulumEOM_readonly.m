function sdot = PendulumEOM_readonly(t,s,u,params)
sdot = zeros(4,1);
m = params.m;
M = params.M;
l = params.l;
g = params.g;
x1 = s(1);
x2 = s(2);
x3 = s(3);
x4 = s(4);
sdot(1) = x2;
sdot(2) = ((M+m)*m*g*l*sin(x1)-m^2*l^2*x2^2*sin(x1)*cos(x1)+m*l*cos(x1)*u)/((M+m)*m*l^2-(m*l*cos(x1))^2);
sdot(3) = x4;
sdot(4) = (m*g*sin(x1)*cos(x1)-m*l*x2^2*sin(x1)+u)/(M+m-m*cos(x1)^2);
end