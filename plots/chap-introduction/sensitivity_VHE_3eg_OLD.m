src=[ 42.3 5.5 1.85 0.10
      69.3 6.1 2.21 0.07
      15.8 2.7 2.43 0.21
      22.0 2.8 1.90 0.10
      14.9 2.5 2.27 0.16
       9.0 2.3 1.92 0.26
      23.9 4.0 2.30 0.10
      15.0 3.5 2.03 0.26
      15.7 4.8 2.47 0.40
       4.8 1.4 1.90 0.37
      15.4 1.8 2.58 0.09
       5.2 1.6 1.86 0.35
       9.2 2.6 1.83 0.29
      46.3 7.3 2.00 0.11
      60.6 4.4 1.69 0.07
      62.1 8.9 2.38 0.17
      34.7 5.7 2.09 0.11
     123.7 6.7 2.08 0.04
      41.3 6.1 2.24 0.14
      12.9 3.5 2.11 0.39
       5.8 2.8 2.36 0.61];

src(:,1:2)=src(:,1:2)*1e-8;
   
erg100MeV = 1/6241.5097;

E100MeV = 10^0;
meansrc=mean(src);
I100MeVU = meansrc(1)+meansrc(2);          I100MeVL = meansrc(1)-meansrc(2);
G100MeVU = meansrc(3)-meansrc(4);          G100MeVL = meansrc(3)+meansrc(4);
J100MeVU = I100MeVU*(G100MeVL-1)/E100MeV;  J100MeVL = I100MeVL*(G100MeVU-1)/E100MeV;

E=10.^(.05:.1:3.95);
E2DFDEU = J100MeVU.*E.^(-G100MeVU).*E.*(erg100MeV*E);
E2DFDEL = J100MeVL.*E.^(-G100MeVL).*E.*(erg100MeV*E);

clf;
axes;
axis('on');
set(gca,'Box','on','LineWidth',1,'Xscale','log','Yscale','log');
axis([1e-1 1e3 1e-12 1e-9]);
hold on
h=fill([E/10 fliplr(E)/10],[E2DFDEU fliplr(E2DFDEL)],[0.9 0.9 0.9 ]);
set(h,'EdgeColor','none','EraseMode','none','FaceAlpha',0.1)
loglog(E/10,E2DFDEU,'k',E/10,E2DFDEL,'k','LineWidth',1)

load sensitivity.mat
Epeak=3500;
crabG=2.49;

h=loglog(Epeak/10,limits350(:,2)*(crabG-1)*Epeak*erg100MeV,'bs',...
       Epeak/10,limits350(:,4)*(crabG-1)*Epeak*erg100MeV,'bo','MarkerSize',8);

set(line([1 1]*Epeak/10,([limits350(:,4)+limits350(:,5) limits350(:,4)-limits350(:,5)])*(crabG-1)*Epeak*erg100MeV),'Color','b');

ylabel('E^2 dF/dE [erg cm^{-2} s^{-1}]');
xlabel('Energy [GeV]');

texts={'0.5hr','5hr','50hr'};
for(i=1:3)
     y=sqrt(limits350(i,2)*(limits350(i,4)-limits350(i,5)))*(crabG-1)*Epeak*erg100MeV;
     text(Epeak*1.3/10,y,texts{i},'Rotation',90,'HorizontalAlignment','center','VerticalAlignment','middle')
end

CrabE2DFDE=8.56E-11;
set(line([Epeak*0.65/10 Epeak*0.85/10],[CrabE2DFDE CrabE2DFDE]),'Color','k');
set(line([Epeak*0.85/10*0.92 Epeak*0.85/10 Epeak*0.85/10*0.92],...
         [CrabE2DFDE*0.92 CrabE2DFDE CrabE2DFDE/0.92]),'Color','k');
text(Epeak*0.62/10, CrabE2DFDE,'Crab','HorizontalAlignment','right');

p=get(gca,'Position');
r=0.01;t=0.015;w=.275;h=.1;
axes('Position',[p(1)+p(3)-w-r,p(2)+p(4)-h-t,w,h]);
axis('on');
set(gca,'Box','on','XTick',[],'YTick',[],'Linewidth',0.5,'Color','none')

a=[0 1 0 1];
axis(a);
hold on;
plot(0.075,0.75,'bs','MarkerSize',8);
text(0.15,0.75,'Flux sensitivity - 4\sigma')
plot(0.075,0.25,'bo','MarkerSize',8);
text(0.15,0.25,'Upper Limit - 99%')

hold off
