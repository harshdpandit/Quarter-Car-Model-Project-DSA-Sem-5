//program to simulate ODEs with
//external arguments, in scilab you have to
//write a function and use it
clear all
global M C K ampl lamb kt ct mt mc
//
ks=40000; //suspension spring
cs=15000; //suspension damper
//
kt=200000; //tire spring
ct=35000; //tire damper
mt=25;mc=300; //tire chasis mass
v=80000/3600; //speed of car smooth road
ampl=0.006;lamb=3.0; // smooth road
//v=36000/3600; //speed of car gravel road
//ampl=0.015;lamb=1.5; // gravel road
M=[mt 0;0 mc];C=[ct+cs -cs;-cs cs];
K=[kt+ks -ks;-ks ks];
//
function ydot=ht(t,y)
A=[zeros(2,2) eye(2,2);-inv(M)*K -inv(M)*C];
B=[zeros(2,2);inv(M)];
f(1,1)=-mt*9.81+kt*ampl*sin(2*%pi*v*t/lamb)+ct*ampl*(2*%pi*v/lamb)*cos(2*%pi*v*t/lamb);
f(2,1)=-mc*9.81
ydot=A*y+B*f;
endfunction
//
//
y0=[0;0;0;0];
t0=0;
t=0:0.001:10;
y=ode(y0,t0,t,ht);
//
figure(0)
subplot(2,1,1)
plot(t',y(2,:)',[2])
xlabel('time: seconds');ylabel('states: cms');
title("$Evolution\:of\:states\:of\:EVERYONE\:CHEATS\:model$");
legends(["$Y_{1}(t)$"],[2],opt="?")
//Calculate acceleration
for i=1:10001,
f(1,i)=-mt*9.81+kt*ampl*sin(2*%pi*v*t(i)/lamb)+ct*ampl*(2*%pi*v/lamb)*cos(2*%pi*v*t(i)/lamb);
f(2,i)=-mc*9.81;
end
accn=inv(M)*(f(1:2,:)-K*y(1:2,:)-C*y(3:4,:));
subplot(2,1,2)
plot(t',accn(2,:)',[2])
xlabel('time: seconds');ylabel('accns: cms');
title("$Evolution\:of\:acceleration\:of\:EVERYONE\:CHEATS\:model$");
legends(["$An_{1}(t)$"],[2],opt="?")


