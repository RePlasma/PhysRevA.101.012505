function [Evec,Bvec] = getFields(x,t,a0,tsig,tnot)
delta = 1; % 0-linear, 1-circular
phi = x+t-tsig;

if (phi<0)
    env = 0;
elseif (phi<4*pi*tsig)
    env = sin(0.25*phi/tsig)^2;
else
    env = 0;
end

efld = a0 * env;
Evec = [0, cos(phi), delta*sin(phi)]*efld;
Bvec = [0, delta*sin(phi), -cos(phi)]*efld;