%   Freq [Hz]   Flux [Ja]
d=[ 6.17E+23 	3.88E-11     % Radio from NED
    3.68E+10 	3.40E-01
    3.68E+10 	5.90E-01
    2.22E+10 	5.80E-01
    2.22E+10 	7.50E-01
    1.07E+10 	1.06E+00
    5.00E+09 	1.22E+00
    5.00E+09 	5.80E-01
    4.85E+09 	6.68E-01
    4.85E+09 	6.68E-01
    2.70E+09 	1.09E+00
    1.41E+09 	7.80E-01
    1.41E+09 	1.30E+00
    1.40E+09 	7.26E-01
    1.40E+09 	8.47E-01
    4.08E+08 	1.05E+00
    4.08E+08 	1.05E+00
    3.65E+08 	9.30E-01
    2.4000e+14	2.69E-04     % J from 2MASS
    1.8182e+14	4.18E-04     % H from 2MASS
    1.3636e+14	4.40E-04     % K from 2MASS
    4.2857e+14	1.37E-04     % R from Halpern
%    4.2857e+14	2.87E-04     % R from Halpern
%    5.3571e+14	8.11E-04     % V from Halpern
%    5.3571e+14	2.94E-05     % V from Halpern
    1.71E17		1.76E-07     % X-ray from ROSAT
    1.4305e+22  1.6301e-10   % Gamma from EGRET
    2.0230e+22  1.4579e-10
    2.9614e+22  8.8602e-11
    5.1293e+22  4.8261e-11
    9.3648e+22  2.3880e-11
    1.7098e+23  9.3365e-12
    3.4196e+23  3.9810e-12
    1.5293e+24  7.5018e-13 ];

elec=1.602176462e-19;
elecMeV=elec*1e6;
h=6.62606876e-34;

ul = 0.13;
whip_engy = 0.35e6; % MeV
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

print -depsc2 sed0450.eps