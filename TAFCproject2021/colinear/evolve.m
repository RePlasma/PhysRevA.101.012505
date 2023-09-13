function [rlst,ulst] = evolve(u0,a0,tsig,tnot,dt,tdim)

% charge
q = -1;

% initial position
r = [0,0,0];
u0 = [u0,0,0];

% push velocity half step backwards
[~,un12] = pusher(r,u0,0,-dt/2,q,a0,tsig,tnot);

% initial momentum n-1/2
u = un12;

rlst = zeros(tdim,3);
ulst = zeros(tdim,3);

% time evolve
t=0;
for n=1:tdim
    
    % Boris
    [r,u] = pusher(r,u,t,dt,q,a0,tsig,tnot);
    rlst(n,:) = r;
    ulst(n,:) = u;
    t = t+dt;
end