function dispsim(track, photon, varargin)
    tr_x = [track(:,2) track(:,2)+track(:,6).*(track(:,4)-track(:,5))];
    tr_y = [track(:,3) track(:,3)+track(:,7).*(track(:,4)-track(:,5))];
    tr_z = [track(:,4) track(:,5)];

    trdensity=1.0;
    if(nargin>=3)
        trdensity=varargin{1};
    end
    
    phdensity=1.0;
    if(nargin>=4)
        phdensity=varargin{2};
    end

    phdensityfactor=1.0;
    if(nargin>=5)
        phdensityfactor=varargin{3};
    end

    altitude=2320;
    if(nargin>=6)
        altitude=varargin{4};
    end
    
    charged=[0 1 1 1 1 0 1 1 1 1 0 0 1 0 0 0 0 0];
    trmask=(rand(length(tr_x),1)<=trdensity)&(charged(track(:,1))');
    figure
    h=plot(tr_x(trmask,:)',tr_z(trmask,:)'/1000.0,'k-');
    set(h,'LineWidth',1)
    a=axis;
    if a(4)>20
        a(4)=20;
    end
    axis([-500 500 0 a(4)]);
    set(gca,'PlotBoxAspectRatio',[0.5 1 1]);
    xlabel('West-East [m]')
    ylabel('Height [km]')
    
    hh=line([-600 600],[altitude/1000,altitude/1000]);
    set(hh,'Color','k','LineStyle','--');
    text(0,altitude/1000-0.1,'Ground Level','VerticalAlignment','top','HorizontalAlignment','center');
    
    phmask=(rand(length(photon),1)<=phdensity);
    figure
    h=plot(photon(phmask,1),photon(phmask,2),'k.');
    set(h,'MarkerSize',4)
    axis('square')
    axis([-250 250 -250 250])
    xlabel('East-West [m]')
    ylabel('North-South [m]')
    if((phdensity/phdensityfactor) < 1.0)
        m=sprintf('%.1f%% of photons',phdensity/phdensityfactor*100);
        text(240,240,m,'VerticalAlignment','top','HorizontalAlignment','right');
    end

    index=-250:10:250;
    phcount=zeros(length(index),length(index));
    for i=1:length(index)
        phmask=(photon(:,2)>(index(i)-5))&(photon(:,2)<=(index(i)+5));
        if(sum(phmask)>0)
            temp = histc(photon(phmask,1),index)*phdensityfactor/100;
            if(size(temp) == [length(index) 1])
                % bug in histc -- if only one element is in input then it flips the 
                % output around. we test to make sure it is the way we want
                % it
                temp=temp';
            end             
            phcount(i,:)=temp;
        end
    end
    figure
    pcolor(index,index,phcount)
    axis('square')
    colormap(1-gray)
    colorbar
    shading('interp')
    xlabel('East-West [m]')
    ylabel('North-South [m]')
    
    r=sqrt(photon(:,1).^2 + photon(:,2).^2);
    bincenter = [5:505];
    binarea = pi*((bincenter+5).^2 - (bincenter-5).^2);
    bincount = histc(r,bincenter)*phdensityfactor;
    figure
    plot(bincenter,bincount./binarea','k');
    a=axis;
    axis([0 300 a(3) a(4)]);
    xlabel('Distance from impact location [m]')
    ylabel('Photon density [m^{-2}]')

    spec_density = 20;
    spec_phfreq = [180:spec_density:700];
    mask = r<50;
    ispec_count = hist(photon(mask,7),spec_phfreq)*phdensityfactor;
    ispec_count = ispec_count/spec_density/(pi*(50^2-0^2));
    mask = r>50&r<150;
    ospec_count = hist(photon(mask,7),spec_phfreq)*phdensityfactor;
    ospec_count = ospec_count/spec_density/(pi*(150^2-50^2));

    figure
    ax1 = axes;
    load detector_qe
    h=fill(Fnm,Fqe.*Fre*100,[0.8, 0.8, 0.8],'linestyle','none','Parent',ax1);
%    set(ax1,'Position',get(ax1,'Position')-[0 0 .1 0],...
%        'YAxisLocation','right','XTickMode','manual','YTickMode','manual');
    set(ax1,'YAxisLocation','right','XTickMode','manual','YTickMode','manual');
    a=axis;
    axis([180 720 a(3) a(4)]);
    h=line([450 510],[20 20]);
    set(h,'LineStyle',':','Parent',ax1)
    h=text(490, 19.85, '20%');
    set(h,'FontSize',floor(get(h,'FontSize')*0.8),...
        'HorizontalAlignment','left','VerticalAlignment','top','Parent',ax1)
%    ylabel('Detection Probability [%]')
    
    ax2 = axes;
    h=plot(spec_phfreq,ospec_count,'b',spec_phfreq,ispec_count,'r--','Parent',ax2);
    set(ax2,'Position',get(ax1,'Position'),...
        'XAxisLocation','bottom','YAxisLocation','left','Color','none');
    a=axis;
    axis([180 720 a(3) a(4)]);
    legend('50<r<150','r<50');
    xlabel('Photon wavelength [nm]');
    ylabel('Spectrum: dN/d\lambda [nm^{-1} m^{-2}]');

    
    if(0)
    td=sqrt((photon(:,1)-120).^2+(photon(:,2)-0).^2);
    phmask=td<5;
    figure;
    plot(asin(photon(phmask,3)),asin(photon(phmask,4)),'k.')
    axis([-0.02 0.02 -0.02 0.02])
    axis('square')
    end

    
    
    whos