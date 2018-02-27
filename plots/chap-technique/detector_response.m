clear
close all
sjf_defaults

ftrig=load('ft.dat');
fcuts=load('ftsom2los.dat');
loglog(ftrig(:,1),ftrig(:,2)/60,'--',fcuts(:,1),fcuts(:,2)/60)
a=axis; a(1)=ftrig(1,1); a(2)=ftrig(length(ftrig),1); a(3)=1e-6; axis(a);
legend('Trigger','Data Selection')
xlabel('Energy [TeV]');
ylabel('Differential \gamma-ray rate - dR/dE [s^{-1} TeV^{-1}]')
print -deps2 detector_response_drde.eps

loglog(ftrig(:,1),ftrig(:,1).*ftrig(:,2)/60,'--',fcuts(:,1),fcuts(:,1).*fcuts(:,2)/60)
a=axis; a(1)=ftrig(1,1); a(2)=ftrig(length(ftrig),1); a(3)=1e-6; axis(a);
legend('Trigger','Data Selection')
xlabel('Energy [TeV]');
ylabel('E dR/dE [s^{-1}]')
print -deps2 detector_response_edrde.eps

loglog(ftrig(:,1),ftrig(:,1).^2.*ftrig(:,2)/60,'--',fcuts(:,1),fcuts(:,1).^2.*fcuts(:,2)/60)
a=axis; a(1)=ftrig(1,1); a(2)=ftrig(length(ftrig),1); a(3)=1e-6; axis(a);
legend('Trigger','Data Selection')
xlabel('Energy [TeV]');
ylabel('E^2 dR/dE [TeV s^{-1}]')
print -deps2 detector_response_eedrde.eps

atrig=load('trigger20.8.dat');
acuts=load('trigger20.8+shapor+los.dat');
loglog(atrig(:,2),atrig(:,3)/1e4,'--',acuts(:,2),acuts(:,3)/1e4)
a=axis; a(1)=ftrig(1,1); a(2)=ftrig(length(ftrig),1); a(3)=1e2;axis(a);
legend('Trigger','Data Selection',1)
xlabel('Energy [TeV]');
ylabel('Effective area [m^2]')
print -deps2 detector_response_area.eps