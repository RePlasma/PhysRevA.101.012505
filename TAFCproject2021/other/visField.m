% test polarization
tlst = linspace(0,20);
a0=1;
delta = 1;
phi = tlst'-2;
efld = a0;
Evec = [0*phi, cos(phi), delta*sin(phi)]*efld;
Bvec = [0*phi, delta*sin(phi), -cos(phi)]*efld;
kvec = cross(Evec,Bvec);
plot(kvec)
return

plot3(tlst, Evec(:,2),Evec(:,3))
hold on
plot3(tlst, Bvec(:,2),Bvec(:,3))
