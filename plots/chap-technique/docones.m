clear

sjf_defaults

E = 1e11;  % particle energy in eV
m = 105e6; % particle rest mass in eV

H0 = 2.3;  % observatory altitude [km]
H1 = 20;   % top of highest cone altitude bin [km]
N  = 10;   % number of cones

gamma = E/m;
v     = sqrt(1-1/gamma^2);

H=exp(log(H0)+(log(H1)-log(H0))/N*((1:N)-0.5));
dH=H-H0;

atmH = [ 0 11.01907 32.16191 53.44562 ];       % Atmospheric model: density exponential 
atmR = [ 1.2250 0.36391 0.012721 0.00071881];  % in elevation, with three regions.
%atmR = [ 1.2250 0.46391 0.022721 0.00071881];  % in elevation, with three regions.
rho = exp(interp1(atmH,log(atmR),H,'linear')); % The model is from kaslite by GHS.

lambda=300; % Representative wavelength
etasea=1.e-7*(2726.43+12.288/(lambda^2*1.e-6)+0.3555/(lambda^4*1.e-12)); % From kaslite

etarho = etasea*rho/atmR(1);    % For a gas: n = 1 + eta*rho   (with eta very small)
theta=acos(1./(1+etarho)./v);

mask = v*(1+etarho) >= 1;

x=[-dH(mask)'.*sin(theta(mask))' zeros(size(dH(mask)))' dH(mask)'.*sin(theta(mask))']*1000;
y=[zeros(size(dH(mask)))' dH(mask)' zeros(size(dH(mask)))']+H0;

plot(x',y','k')
set(line([0 0],[H1 H0]),'Color','k')
axis([-150 150 0 H1])
set(gca,'PlotBoxAspectRatio',[0.85 1 1]);
xlabel('Distance on ground [m]')
ylabel('Height [km]')

hh=line([-150 150],[H0 H0]);
set(hh,'Color','k','LineStyle','--');
text(0,H0-0.1,'Ground Level','VerticalAlignment','top','HorizontalAlignment','center');

print -depsc2 cones.eps