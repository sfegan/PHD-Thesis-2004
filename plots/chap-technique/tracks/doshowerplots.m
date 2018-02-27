sjf_defaults
clear
load

printsims(mtrack99999,mphoton99999,'kas_muon_99999',1,0.05,1,2320)
figure(4)
a=axis;
a(2)=150;
if(a(4)>100)
    a(4)=100;
end
axis(a)    
print('-painters','-deps2','kas_muon_99999_rd.eps')
printsims(gtrack100,gphoton100,'kas_gamm_100',0.5,0.2,0.1,2320)
printsims(gtrack1000,gphoton1000,'kas_gamm_1000',0.5,0.1,0.01,2320)
printsims(ptrack1000,pphoton1000,'kas_prot_1000',0.5,0.1,0.01,2320)
