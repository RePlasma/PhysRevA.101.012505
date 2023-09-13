%% add some description
addpath 'qed'
addpath 'W3'

% setup
w0 = 1.88e15; %[fs-1]
a0 = 20; %[] CP-20, LP-25
dt = 0.01; %[w0^-1]
tsig = 3;
tmax = 3*pi*tsig;
tdim = floor(tmax/dt);
nparts = 1e5;

% initial velocity distribution
g0 = 3000; % [] CP-3000, LP-1e4
u0 = sqrt(g0^2-1);
thetax=[]; thetay=[];

% sample from independent electrons
for i=1:nparts
    % evolve
    [thetax1, thetay1] = evolve(u0,a0,tsig,0,dt,tdim);
    thetax = [thetax thetax1(thetax1~=-1)'];
    thetay = [thetay thetay1(thetay1~=-1)'];
end
% number of emitted photons per electron
%numel(thetax)/nparts;
% rescale angles
thetax = thetax*g0;
thetay = thetay*g0;
% swap (LP)
%{
thetaz = thetax;
thetax = thetay;
thetay = thetaz;
%}

%{
%% no beaming
plot(thetax,thetay,'.k') % scatter
% style
pbaspect([1 1 1])
fnt = 22;
ax = gca;
ax.Box = 'on';
ax.BoxStyle = 'full';
ax.FontSize = fnt;
ax.TickLabelInterpreter = 'latex';
xlabel('$r_x$','FontSize', fnt, 'Interpreter','latex')
ylabel('$r_y$','FontSize', fnt, 'Interpreter','latex')
title('Collinear emission','FontSize', fnt, 'Interpreter','latex')
xlim([-22,+22])
ylim([-22,+22]) % CP
%ylim([-5,+5]) % LP
%}

%% finite beaming
% edges
nbins = 140;
edgesx = linspace(min(thetax),max(thetax),nbins);
edgesy = linspace(min(thetay),max(thetay),nbins);
% plot histogram2d
[X,Y]=meshgrid(linspace(min(thetax),max(thetax),nbins-1),linspace(min(thetay),max(thetay),nbins-1));
[plt]=histogram2(thetay,thetax,edgesy,edgesx);
histval = plt.Values;
surf(X,Y,histval,'EdgeColor','none')
zlim([0,max(max(histval))])
colormap(flipud(spring))
view(0,90)
% style
pbaspect([1 1 1])
fnt = 22;
ax = gca;
ax.Box = 'on';
ax.BoxStyle = 'full';
ax.FontSize = fnt;
ax.TickLabelInterpreter = 'latex';
xlabel('$r_x$','FontSize', fnt, 'Interpreter','latex')
ylabel('$r_y$','FontSize', fnt, 'Interpreter','latex')
title('Finite beaming','FontSize', fnt, 'Interpreter','latex')
xlim([-22,+22])
ylim([-22,+22]) % CP
%ylim([-5,+5]) % LP
% colorbar
clrbr1 = colorbar;
clrbr1.TickLabelInterpreter = 'latex';
caxis([0,max(max(histval))])
hL = ylabel(clrbr1,'$d^2N_\gamma/dr_x dr_y$','FontSize', fnt, 'Interpreter','latex');
set(hL,'Rotation',90);
ax = gca;
ax.XColor = 'black';
ax.YColor = 'black';
%print(gcf,'CP.pdf','-dpdf','-r400')
return

%% outline rx=0
thetax0 = max(thetax)/50;
[histN,histedges] = histcounts(thetay(abs(thetax) < thetax0),60);
[thetaysmpl,dNdg] = histline(histedges, histN);
plot(thetaysmpl,dNdg)
% style
pbaspect([3.2400 1 1])
fnt = 22;
ax = gca;
ax.Box = 'on';
ax.BoxStyle = 'full';
ax.FontSize = fnt;
ax.TickLabelInterpreter = 'latex';
xlabel('$r_y$','FontSize', fnt, 'Interpreter','latex')
ylabel('$dN_\gamma/dr_y$','FontSize', fnt, 'Interpreter','latex')
title('LP $r_x=0$','FontSize', fnt, 'Interpreter','latex')
xlim([-22,+22]) % CP
%xlim([-30,+30]) % LP
%print(gcf,'CP_ry.pdf','-dpdf','-r400')
return

%% outline ry=0
thetay0 = max(thetay)/100;
[histN,histedges] = histcounts(thetax(abs(thetay) < thetay0),60);
[thetaxsmpl,dNdg] = histline(histedges, histN);
plot(thetaxsmpl,dNdg)
% style
pbaspect([3.2400 1 1])
fnt = 22;
ax = gca;
ax.Box = 'on';
ax.BoxStyle = 'full';
ax.FontSize = fnt;
ax.TickLabelInterpreter = 'latex';
xlabel('$r_x$','FontSize', fnt, 'Interpreter','latex')
ylabel('$dN_\gamma/dr_x$','FontSize', fnt, 'Interpreter','latex')
title('LP $r_y=0$','FontSize', fnt, 'Interpreter','latex')
xlim([-22,+22]) % CP
%xlim([-30,+30]) % LP
%print(gcf,'CP_rx.pdf','-dpdf','-r400')