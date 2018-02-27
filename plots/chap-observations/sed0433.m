%   Freq [Hz]   Flux [Ja]
d=[ 8.08E+09    3.60E-01     % Radio from NED
    4.85E+09    4.77E-01
    4.85E+09 	4.81E-01
    2.70E+09 	3.70E-01
    1.40E+09 	2.20E-01
    1.40E+09 	3.99E-01
    1.40E+09 	3.89E-01
    2.4000e+14	3.21E-03     % J from 2MASS
    1.8182e+14	4.52E-03     % H from 2MASS
    1.3636e+14	6.19E-03     % K from 2MASS
    4.2857e+14	1.51E-03     % R from Halpern
%    4.2857e+14	4.99E-05     % R from Halpern
    5.3571e+14	8.11E-04     % V from Halpern
%    5.3571e+14	2.94E-05     % V from Halpern
    1.71E17		3.86E-07     % X-ray from ROSAT
    9.3648e+21  4.8354e-10   % Gamma from EGRET
    2.0230e+22  1.2870e-10
    2.9614e+22  1.2462e-10
    5.1293e+22  5.2146e-11
    9.3648e+22  3.8150e-11
    1.7098e+23  1.7850e-11
    3.4196e+23  1.2481e-11
    6.8391e+23  5.5446e-12
    1.5293e+24  2.8457e-12 ];

elec=1.602176462e-19;
elecMeV=elec*1e6;
h=6.62606876e-34;

on=8675;
off=27468;
rho=0.312;
t=114001.3;
excess=on-rho*off;
dexcess=sqrt(on+rho^2*off);
sigma=excess/dexcess
ul=helene(excess,dexcess,0.99)/t/(2.56/60)

whip_engy = 0.35e6; % MeV
iful=ul*3.2e-11*(whip_engy/1e6)^(-1.5)/1.5
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
set(line(whip_freq*[ddd 1/ddd],whip_nufnu*[1 1]),'Color','k');
set(line(whip_freq*[1 1],whip_nufnu*[1 ddd^3]),'Color','k');
set(line(whip_freq*[ddd 1],whip_nufnu*ddd^3*[1/ddd^1.5 1]),'Color','k');
set(line(whip_freq*[1/ddd 1],whip_nufnu*ddd^3*[1/ddd^1.5 1]),'Color','k');
axis([1e8 1e27 1e-15 1e-10])
xlabel('Frequency [Hz]')
ylabel('\nuF_\nu [erg cm^{-2} s^{-1}]')
labels={ '1{\mu}eV', '1meV', '1eV', '1keV', '1MeV', '1GeV', '1TeV' };
places=10.^[-6:3:12];
for i=1:length(places)
    set(text(places(i)*elec/h,1.2e-15,labels{i}),{'Rotation','FontSize'},{75,12})
end

print -depsc2 sed0433.eps