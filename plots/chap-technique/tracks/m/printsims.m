function printsims(tr,ph,root,varargin)
    close all

    trdensity=1.0;
    if(nargin>=4)
        trdensity=varargin{1};
    end
    
    phdensity=1.0;
    if(nargin>=5)
        phdensity=varargin{2};
    end

    phdensityfactor=1.0;
    if(nargin>=6)
        phdensityfactor=varargin{3};
    end
    
    altitude=2320;
    if(nargin>=7)
        altitude=varargin{4};
    end 
       
    dispsim(tr,ph,trdensity,phdensity,phdensityfactor,altitude)

    otrfile = sprintf('%s_tr.eps',root);
    ophfile = sprintf('%s_ph.eps',root);
    opdfile = sprintf('%s_pd.eps',root);
    ordfile = sprintf('%s_rd.eps',root);
    ospfile = sprintf('%s_sp.eps',root);

    figure(1)
    print('-painters','-deps2',otrfile)
    figure(2)
    print('-painters','-deps2',ophfile)
    figure(3)
    print('-painters','-deps2',opdfile)
    figure(4)
    print('-painters','-deps2',ordfile)
    figure(5)
    print('-painters','-deps2',ospfile)
