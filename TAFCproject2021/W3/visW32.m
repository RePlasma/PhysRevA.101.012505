% rejection sample from 2D distribution
gm = 1000;
chi=1.0;
dim=100;
wmin = 0.1; wmax = 0.999*gm;
thetamin = 0; thetamax = 6/gm;
wlst = linspace(wmin,wmax,dim);
thetalst = linspace(thetamin,thetamax,dim);
[X,Y] = meshgrid(wlst,thetalst);
fun = @(w,theta) getW3(w,theta,chi,gm); % function to sample from
W3lst = arrayfun(@(w,theta) fun(w,theta), X, Y );
maxW3lst = max(max(W3lst));
multc = 1.1*maxW3lst; % the c in c q(x)
%% sample
ndraws = 1e3; % number of required successful draws
W3smpl_w = zeros(1,ndraws);
W3smpl_theta = zeros(1,ndraws);
W3smpl_W3 = zeros(1,ndraws);

counts = 0;
i = 1;
while i <= ndraws
    y = (wmax-wmin)*rand+wmin; % take Y from uniform distribution [xmin,xmax]
    z = (thetamax-thetamin)*rand+thetamin; % take Y from uniform distribution [xmin,xmax]
    u = rand; % take U from uniform distribution [0,1]
    funyz = fun(y,z);
    if multc*u <= funyz % accept value only if U < c Y
        W3smpl_w(i) = y;
        W3smpl_theta(i) = z;
        W3smpl_W3(i) = funyz;
        i = i + 1;
    end
    counts = counts+1;
end

% "efficiency of the draws"
ndraws/counts

% plot
surf(X,Y,W3lst,'EdgeColor','none');
hold on
plot3(W3smpl_w, W3smpl_theta, W3smpl_W3,'.k')