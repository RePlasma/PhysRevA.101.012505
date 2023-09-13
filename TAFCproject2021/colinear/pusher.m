% um12 -> um -> upr -> up -> up12
% n-1/2 -> - -> ' -> + -> n+1/2
function [r,u] = pusher(rn,um12,t,dt,q,a0,tsig,tnot)

% Evec, Bvec
[Evec,Bvec] = getFields(rn(1),t,a0,tsig,tnot);

% u- = un-1/2 + q E dt/2
um = um12 + q*Evec*dt/2;

% gn
gn = sqrt(1+norm(um12)^2);

% t
tvec = q*Bvec*dt/(2*gn);

% u' = u- + u- x t
upr = um + cross(um,tvec);

% s
svec = 2*tvec/(1+norm(tvec)^2);

% u+ = u- + u' x s
up = um + cross(upr,svec);

% un+1/2 = u+ + q E dt/2
up12 = up + q*Evec*dt/2;

% 
u = up12;
v = u/sqrt(1+norm(u)^2);
r = rn + dt*v;