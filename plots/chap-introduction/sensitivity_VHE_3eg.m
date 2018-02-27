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

E1=10.^(.05:.1:2);
E2=10.^(2:.1:3.95);
E2DFDEU1 = J100MeVU.*E1.^(-G100MeVU).*E1.*(erg100MeV*E1);
E2DFDEL1 = J100MeVL.*E1.^(-G100MeVL).*E1.*(erg100MeV*E1);
E2DFDEU2 = J100MeVU.*E2.^(-G100MeVU).*E2.*(erg100MeV*E2);
E2DFDEL2 = J100MeVL.*E2.^(-G100MeVL).*E2.*(erg100MeV*E2);

clf;
axes;
axis('on');
set(gca,'Box','on','LineWidth',1,'Xscale','log','Yscale','log');
axis([1e-1 1e3 1e-12 4e-10]);
hold on
h=fill([E1/10 fliplr(E1)/10],[E2DFDEU1 fliplr(E2DFDEL1)],[0.9 0.9 0.9 ]);
set(h,'EdgeColor','none');
loglog(E1/10,E2DFDEU1,'k',E1/10,E2DFDEL1,'k','LineWidth',1.5)
loglog(E2/10,E2DFDEU2,'k--',E2/10,E2DFDEL2,'k--','LineWidth',1.5)

load sensitivity.mat
Epeak=3500;
crabG=2.49;

loglog(Epeak/10,limits350(:,4)*(crabG-1)*Epeak*erg100MeV,'bo','MarkerSize',8);
set(line([1 1]*Epeak/10,([limits350(:,4)+limits350(:,5) limits350(:,4)-limits350(:,5)])*(crabG-1)*Epeak*erg100MeV),'Color','b');

ylabel('E^2 dF/dE [erg cm^{-2} s^{-1}]');
xlabel('Energy [GeV]');

texts={'0.5hr','5hr','50hr'};
for(i=1:3)
     y=sqrt((limits350(i,4)+limits350(i,5))*(limits350(i,4)-limits350(i,5)))*(crabG-1)*Epeak*erg100MeV;
     text(Epeak*1.3/10,y,texts{i},'Rotation',90,'HorizontalAlignment','center','VerticalAlignment','middle')
end

CrabE2DFDE=8.56E-11;
set(line([Epeak*0.8/10 Epeak/0.8/10],[CrabE2DFDE CrabE2DFDE]),'Color','k');
text(Epeak*0.75/10, CrabE2DFDE,'Crab','HorizontalAlignment','right');

if(1)
    axis([1e-1 1e3 2e-13 4e-10]);
    plot(100,4.4288e-13,'rs','MarkerSize',8);
    set(line([100 100],[4.4288e-13-1.1986e-13 4.4288e-13+1.1986e-13]),'Color','r');
    set(text(80,4.4288e-13,'VERITAS 50hr'),'HorizontalAlignment','right');
end

hold off
