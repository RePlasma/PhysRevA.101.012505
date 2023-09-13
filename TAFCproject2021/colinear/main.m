%% add some description

% setup
w0 = 1.88e15; %[fs-1]
a0 = 20; %[]
dt = 0.01; %[w0^-1]
tsig = 3;
tmax = 7.2*tsig;
tdim = floor(tmax/dt);
%lbd = 2*pi; %[c w0^-1]

% initial velocity distribution
g0 = 3000;
u0 = sqrt(g0^2-1);

% evolve
[rlst,ulst] = evolve(u0,a0,tsig,0,dt,tdim);

thetay = g0*atan(ulst(:,2)./ulst(:,1));
thetaz = g0*atan(ulst(:,3)./ulst(:,1));
% plot
plot3(linspace(0,tmax,tdim),thetaz,thetay,'LineWidth',3)
set(gca,'Color','k')
set(gcf, 'color', 'none');    
set(gca, 'color', 'none');
% style
fnt = 24;
ax = gca;
ax.Box = 'on';
ax.BoxStyle = 'full';
ax.FontSize = fnt;
ax.TickLabelInterpreter = 'latex';
set(ax, {'XColor', 'YColor', 'ZColor'}, {'white', 'white', 'white'});
box off
xlabel('$t$','FontSize', fnt, 'Interpreter','latex','Color','white')
ylabel('$r_x$','FontSize', fnt, 'Interpreter','latex','Color','white')
zlabel('$r_y$','FontSize', fnt, 'Interpreter','latex','Color','white')
%print(gcf,'cover.pdf','-dpdf','-r400')