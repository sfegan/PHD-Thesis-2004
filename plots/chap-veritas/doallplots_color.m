clear
load rawdata

close all

set(0,'DefaultLineLineWidth',2.0);
set(0,'DefaultAxesFontName','Times');
set(0,'DefaultAxesFontSize',24);
set(0,'DefaultAxesFontWeight','Bold');
set(0,'DefaultTextFontName','Times');
set(0,'DefaultTextFontSize',24);
set(0,'DefaultTextFontWeight','Bold');

set(0,'DefaultFigurePaperOrientation','landscape');
paper = get(0,'factoryFigurePaperSize');
margin = 0.8;
set(0,'DefaultFigurePaperPosition',[margin,margin,paper(2)-2*margin,paper(1)-2*margin]);
view = get(0,'factoryAxesPosition');
set(0,'DefaultAxesPosition',view+[0.05,0.05,0,-0.03]);

%set(0,'DefaultAxesMinorGridLineStyle','none')

%
% "Angular resolution"
%
figure

hA=loglog(angle,fr10TeV,'b--', angle,fr1TeV,'g-', angle,fr100GeV,'r-.');

th=text(4, 4e-2, '100GeV');
set(th,'VerticalAlignment','top');
set(th,'HorizontalAlignment','left');

th=text(2.4, 9e-2, '1TeV');
set(th,'VerticalAlignment','top');
set(th,'HorizontalAlignment','left');

th=text(2, 2.3e-1, '10TeV');
set(th,'VerticalAlignment','bottom');
set(th,'HorizontalAlignment','right');

%text('1TeV')
%text('100GeV')
xlabel('\Delta\theta [arc min.]')
ylabel('Probability P(E,<\Delta\theta) [1]')
axis([1.0 127.0 0.01 1.00]);
grid

saveas(gcf,'AngularErrorColor.fig')
print -depsc 'AngularErrorColor.eps'

%
% "Angular acceptance"
%
figure

hD=plot(angle,fr10TeV./angle,'b--', angle,fr1TeV./angle,'g-', angle,fr100GeV./angle,'r:');
legend('10TeV','1TeV','100GeV')

xlabel('\Delta\theta [arc min.]')
ylabel('Significance [arbitrary]')
axis([1.0 30.0 0 0.12]);
grid

saveas(gcf,'AngularAcceptanceColor.fig')
print -depsc 'AngularAcceptanceColor.eps'

%
% Collection area curve
%
%figure
%
%hB=loglog(E,Atrigger,'b-');
%
%xlabel('E [TeV]')
%ylabel('A(E) [m^2]')
%axis([1e-2 10 1e2 1e6])
%grid
%
%saveas(gcf,'CollectionAreaColor.fig')
%print -depsc 'CollectionAreaColor.eps'

%
% Differential crab rate
%
figure

splogE=[-2:1/32:2];
mask=E>0.01;
spdNdE=interp1(log10(E(mask)),log10(dNdE(mask)),splogE','spline');

hC=loglog(10.^splogE,10.^spdNdE,'b-');

xlabel('E [TeV]')
ylabel('dR/dE [sec^{-1} TeV^{-1}]')
axis([1e-2 10 1e-3 1e1])
grid

saveas(gcf,'DifferentialRateColor.fig')
print -depsc 'DifferentialRateColor.eps'

%
% Collection area curve 3/4 and 3/7
%
%figure

%hB=loglog(E,Atrigger7/1e4,'r-',E,Atrigger,'b--');
%legend('3/7 5.8p.e.','3/4 5.6p.e.',4)

%xlabel('E [TeV]')
%ylabel('A(E) [m^2]')
%axis([1e-2 10 1e2 1e6])
%grid
%
%saveas(gcf,'CollectionAreaColorFull.fig')
%print -depsc 'CollectionAreaColorFull.eps'

%
% Differential crab rate 3/4 and 3/7
%
%figure

%hC=loglog(E,dNdE7,'r-',E,dNdE,'b--');
%legend('3/7 5.8p.e.','3/4 5.6p.e.')

%xlabel('E [TeV]')
%ylabel('dR/dE [sec^{-1} TeV^{-1}]')
%axis([1e-2 10 1e-3 1e1])
%grid
%
%saveas(gcf,'DifferentialRateColorFull.fig')
%print -depsc 'DifferentialRateColorFull.eps'


%
% Sensitivity 5/50
%
figure

hE=loglog(E,EdFdEcr*10000,'k:', E,EdFdElim50*10000,'b-', E,EdFdElim5*10000,'r--');

legend(hE(2:3),'50 hours, 5\sigma','5 hours, 5\sigma',3);
legend(gca,'boxoff')

text(0.3,2.2e-6,'"Crab-like" source', 'FontName','Times','FontSize',14,'FontAngle','normal','FontWeight','Bold','VerticalAlignment','bottom','HorizontalAlignment','left')
%text(7e-1,5.6e-12,'5 hrs', 'FontName','Times','FontSize',14,'FontAngle','normal','FontWeight','Bold','VerticalAlignment','bottom','HorizontalAlignment','left')
%text(1e0,7e-13,'50 hrs', 'FontName','Times','FontSize',14,'FontAngle','normal','FontWeight','Bold','VerticalAlignment','bottom','HorizontalAlignment','left')

xlabel('E [TeV]')
ylabel('E dF/dE [m^{-2} s^{-1}]')
axis([2e-2 1e1 1e-9 1e-4])
grid

saveas(gcf,'Sensitivity50and5Color.fig')
print -depsc 'Sensitivity50and5Color.eps'

%
% Sensitivity 50
%
%figure

%hF=loglog(E,EdFdEcr,'k:', E,EdFdElim50,'b-');

%hFl=legend(hF(2),'50 hours, 5\sigma',3);
%legend(gca,'boxoff')

%text(0.3,2.2e-10,'"Crab-like" source', 'FontName','Times','FontSize',14,'FontAngle','normal','FontWeight','Bold','VerticalAlignment','bottom','HorizontalAlignment','left')
%text(1e0,7e-13,'50 hrs', 'FontName','Times','FontSize',14,'FontAngle','normal','FontWeight','Bold','VerticalAlignment','bottom','HorizontalAlignment','left')
%text(2.2e-2,1.1e-13,'(50 hours, 5\sigma)','FontSize',14,'FontAngle','normal','FontWeight','Bold','VerticalAlignment','bottom','HorizontalAlignment','left')

%xlabel('E [TeV]')
%ylabel('E dF/dE [cm^2 s^{-1}]')
%axis([2e-2 1e1 1e-13 1e-8])
%grid

%saveas(gcf,'Sensitivity50Color.fig')
%print -depsc 'Sensitivity50Color.eps'

%
% Trigger rate
%
figure

hG=semilogy(sc_thre,sc_rate,'b:', st_thre,st_rate,'b--', ar_thre,ar_rate,'b-', cr_thre,cr_rate,'r'); 

legend('NSB: Channel','NSB: Telescope', 'NSB: Array', 'CR: Array')

xlabel('Pixel Threshold [p.e.]');
ylabel('Trigger Rate [Hz]');
axis([2 14 1e-1 1e8]);
set(gca,'XTick',[2:1:14]);
set(gca,'YTick',10.^[-1:8]);
grid

saveas(gcf,'TriggerRateColor.fig')
print -depsc 'TriggerRateColor.eps'

%
% Effective Areas -- Interpolation
%
figure

hH=loglog(ea37e,ea37/10000,'b--',ea33e,ea33/10000,'b-.',ea34e,ea34/10000,'r');

legend('V7: 3/7-12m','V7: 3/3-12m','V4: 3/4-12m',4)

xlabel('E [TeV]')
ylabel('A(E) [m^2]')
axis([1e-2 10 1e2 1e6])
grid

saveas(gcf,'InterpolationCollectionAreaColor.fig')
print -depsc 'InterpolationCollectionAreaColor.eps'

%
% Proton Suppression Factor
%
figure

hI=loglog(prSupFacE,prSupFac,'b');

xlabel('Equivalent \gamma-ray energy [TeV]');
ylabel('Fraction');
axis([1e-2 10 1e-3 2]);
grid

saveas(gcf,'ProtonSuppressionFactorColor.fig')
print -depsc 'ProtonSuppressionFactorColor.eps'

%
% Proton dNdEg
%
figure
hJ=loglog(prE,prDNDEg);

xlabel('Equivalent \gamma-ray energy [TeV]');
ylabel('dR/dE [sec^{-1} TeV^{-1}]');
grid

saveas(gcf,'ProtonDifferentialRateColor.fig')
print -depsc 'ProtonDifferentialRateColor.eps'

%
% Aperture Cuts - Collection Area
%
clear 
load vvv_acceptance
figure

hK=loglog(acceptance7(:,1),acceptance7(:,2:4),'b' ,acceptance3(:,1), acceptance3(:,2:4),'r--');
xlabel('Angular Acceptance Cut [deg]')
ylabel('A(E) [m^2]')

axis([2e-2 2e0 6e1 3e5])
grid
legend([hK(1), hK(4)],'3/7-10m','3/3-10m',4)

th=text(4e-2, 1.05e4, '1TeV');
set(th,'VerticalAlignment','top');
set(th,'HorizontalAlignment','left');

th=text(1e-1, 1.6e3, '100GeV');
set(th,'VerticalAlignment','top');
set(th,'HorizontalAlignment','left');

th=text(5e-2, 7e4, '10TeV');
set(th,'VerticalAlignment','bottom');
set(th,'HorizontalAlignment','right');

saveas(gcf,'V7ApertureCollectionAreaColor.fig')
print -depsc 'V7ApertureCollectionAreaColor.eps'

figure
set(gcf,'DefaultAxesFontName','Times');
set(gcf,'DefaultAxesFontSize',12);
set(gcf,'DefaultAxesFontWeight','Bold');
set(gcf,'DefaultTextFontName','Times');
set(gcf,'DefaultTextFontSize',12);
set(gcf,'DefaultTextFontWeight','Bold');
mesh(log10(E),log10(theta),log10(ar7'),C7');
hold on;
mesh(log10(E),log10(theta),log10(ar3'),C3');
ylabel('log Aperture [deg]');
xlabel('log Energy [TeV]');
zlabel('log Effective Area [m^2]');
legend('3/7-10m','3/3-10m');
hold off;
colormap([1,0,0 ;0,0,1]);

saveas(gcf,'V7MeshCollectionAreaColor.fig')
print -depsc 'V7MeshCollectionAreaColor.eps'

figure
loglog(E,ar7(:,1),'b',E,ar3(:,1),'r--','LineWidth',2);
axis([1e-2 1e1 6e1 3e5])
set(gca,'FontSize',24);
set(gca,'Position',get(gca,'Position')+[0.05 0.05, -0.05, -0.05])
legend('3/7-10m','3/3-10m',4);
xlabel('Energy [TeV]')
ylabel('Effective Area [m^2]')
grid

saveas(gcf,'V7CollectionAreaColor.fig')
print -depsc 'V7CollectionAreaColor.eps'

