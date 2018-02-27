%   Freq [Hz]   Flux [Ja]
d=[ 4.85E+09    4.98E-01     % Radio from NED
    4.85E+09    4.96E-01
    1.40E+09    1.33E+00
    1.40E+09    1.28E+00
    7.50E+08    1.52E+00
    3.65E+08    1.70E+00
    1.78E+08    4.00E+00
    2.4000e+14	6.15E-03     % J from 2MASS
    1.8182e+14	6.90E-03     % H from 2MASS
    1.3636e+14	6.75E-03     % K from 2MASS
%    4.2857e+14	4.99E-03     % R from Halpern
    1.71E17		4.69E-07     % X-ray from ROSAT
    9.3648e+21  3.7013e-09   % Gamma from 3EG catalog
    1.4305e+22  8.3242e-10
    2.9614e+22  2.4524e-10
    5.1293e+22  1.2949e-10
    9.3648e+22  8.2949e-11
    1.7098e+23  2.6333e-11
    3.4196e+23  9.3336e-12
    6.8391e+23  4.9934e-12 ];

elec=1.602176462e-19;
elecMeV=elec*1e6;
h=6.62606876e-34;

on=4499;
off=14152;
rho=0.323;
t=50495.2;
excess=on-rho*off;
dexcess=sqrt(on+rho^2*off);
sigma=excess/dexcess
ul=helene(excess,dexcess,0.99)/t/(2.56/60)

whip_engy = 0.35e6; % MeV
iful=ul*2.605e-11*(whip_engy/1e6)^(-1.5)/1.5
whip_ulim = ul * 3.2e-13*(whip_engy/1e6)^(-2.5); % ph/m^2/s/MeV
whip_freq = whip_engy*elecMeV/h;
whip_nufnu = whip_freq*(elecMeV*whip_engy)*(whip_ulim/elecMeV*h)/1e-26*1e-23;

% INSTRUCTIONS FOR CONVERTING EGRET FLUXES TO CORRECT UNITS
% Snarf the spectrum data from the fits file into vector "s"
% m=s(:,5)~=0
% e=sqrt(s(m,3).*s(m,2))
% f=s(m,5)
% elecMeV=1.602176462e-13
% h=6.62606876e-34
% [e*elecMeV/h, (elecMeV*e).*f/elecMeV*1e4*h/1e-26]

% CONVERTING X-RAY FLUXES
% units: (1.00 erg/cm^2 s)/(1.9 keV/h) --> jansky

% USEFUL MAGNITUDE CONVERTER
% http://www.stecf.org/instruments/nicmos/tools/nicmos_units_p.html

sjf_defaults
close all
set(loglog(d(:,1),d(:,1).*d(:,2)*1e-23,'x'),'MarkerSize',10); 
hold on;
ddd=0.7;

%set(line([9.3648e+21*ddd^2 6.8391e+23/ddd^2],1e-12*[1 1]),'Color','b')
%set(line(9.3648e+21*ddd^2*[1 1],1e-12*[ddd 1/ddd].^(1/2)),'Color','b')
%set(line(6.8391e+23/ddd^2*[1 1],1e-12*[ddd 1/ddd].^(1/2)),'Color','b')
%text(sqrt(9.3648e+21*6.8391e+23),8e-13,{'Uncertain' 'association'},...
%    'HorizontalAlignment','center','VerticalAlignment','top','FontSize',10);

set(line(whip_freq*[ddd 1/ddd],whip_nufnu*[1 1]),'Color','k');
set(line(whip_freq*[1 1],whip_nufnu*[1 ddd^3]),'Color','k');
set(line(whip_freq*[ddd 1],whip_nufnu*ddd^3*[1/ddd^1.5 1]),'Color','k');
set(line(whip_freq*[1/ddd 1],whip_nufnu*ddd^3*[1/ddd^1.5 1]),'Color','k');
axis([1e8 1e27 1e-15 1e-9])
xlabel('Frequency [Hz]')
ylabel('\nuF_\nu [erg cm^{-2} s^{-1}]')
labels={ '1{\mu}eV', '1meV', '1eV', '1keV', '1MeV', '1GeV', '1TeV' };
places=10.^[-6:3:12];
for i=1:length(places)
    set(text(places(i)*elec/h,1.2e-15,labels{i}),{'Rotation','FontSize'},{75,12})
end

print -depsc2 sed0628.eps