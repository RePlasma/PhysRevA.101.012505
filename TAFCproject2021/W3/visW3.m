% confirm W3 with Mathematica plots
%{
theta = 0;
gm = 1000;
chi1=0.1;chi2=0.5;chi3=1;
wlst = linspace(0.1,gm);
W3lst1 = arrayfun(@(w) getW3(w,theta,chi1,gm), wlst );
W3lst2 = arrayfun(@(w) getW3(w,theta,chi2,gm), wlst );
W3lst3 = arrayfun(@(w) getW3(w,theta,chi3,gm), wlst );
% plot
plot(wlst,W3lst1)
hold on
plot(wlst,W3lst2)
hold on
plot(wlst,W3lst3)
%}

gm = 1000;
chi=1.0;
dim=20;
wlst = linspace(0.1,0.999*gm,dim);
thetalst = linspace(0.,4/gm,dim);
[X,Y] = meshgrid(wlst,thetalst);
W3lst = arrayfun(@(w,theta) getW3(w,theta,chi,gm), X, Y );
% plot
surf(X,Y,W3lst,'EdgeColor','none');