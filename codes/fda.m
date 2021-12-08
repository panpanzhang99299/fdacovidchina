load('hbcase.mat')
load('hbdeath.mat')
load('procase.mat')
load('prodeath.mat')
%%load hubei data
city=[...
    'Xiaogan    ';...
    'Huanggang  ';...
    'Jingzhou   ';...
    'Ezhou      ';...
    'Suizhou    ';...
    'Xiangyang  ';...
    'Huangshi   ';...
    'Yichang    ';...
    'Jingmen    ';...
    'Xianning   ';...
    'Shiyan     ';...
    'Xiantao    ';...
    'Tianmen    ';...
    'Enshi      ';...
    'Qianjiang  ';...
    'Shennongjia'];
cityindex=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];
city=city(cityindex,:);
hbcase=hbcase(:,cityindex);
hbdeath=hbdeath(:,cityindex);
%load 30 province data 
province=[...;
    'Zhejiang    ';...
    'Shanghai    ';...
    'Beijing     ';...
    'Hebei       ';...
    'Henan       ';...
    'Hunan       ';...
    'Anhui       ';...
    'Jiangxi     ';...
    'Shaanxi     ';...
    'Shanxi      ';...
    'Sichuan     ';...
    'Chongqing   ';...
    'Guxangxi    ';...
    'Guangdong   ';...
    'Jiangsu     ';...
    'Fujian      ';...
    'Shangdong   ';...
    'Neimenggu   ';...
    'Tianjin     ';...
    'Jilin       ';...
    'Heilongjiang';...
    'Tibet       ';...
    'Xinjiang    ';...
    'Gansu       ';...
    'Qinghai     ';...
    'Ningxia     ';...
    'Hainan      ';...
    'Liaoning    ';...
    'Guizhou     ';...
    'Yunan       '];
provinceindex=1:30;
province=province(provinceindex,:);
procase=procase(:,provinceindex);
prodeath=prodeath(:,provinceindex);
nharm=2;
ncan=2;
weektime=linspace(0,77,77);

daytime=(1:77)'-0.5;
dayperiod=77;
dayrange=[0,77];
nbasis=9;
daybasis77=create_fourier_basis(dayrange,nbasis);
Lcoef=[0,(2*pi/77)^2,0];
Lbasis  = create_constant_basis(dayrange);
wfd     = fd(Lcoef,Lbasis);
wfdcell=fd2cell(wfd);
harmaccelLfd=Lfd(3,wfdcell);
lambda=1e5;


%case curve and death curve
date=1:77;
plot(date,hbcase)
xlabel('Date')
set(gca,'XTick',0:15:75)
set(gca,'XTicklabel',{'01/23','02/07','02/22','03/08','03/23','04/07'})
ylabel('Number of confirmed cases')
legend({'Xiaogan','Huanggang','Jingzhou','Ezhou','Suizhou','Xiangyang',...
    'Huangshi','Yichang','Jingmen','Xianning','Shiyan','Xiantao','Tianmen',...
    'Enshi','Qianjiang','Shennongjia'},'location','northeast');
plot(date,mean(hbcase,2))
xlabel('Date')
set(gca,'XTick',0:15:75)
set(gca,'XTicklabel',{'01/23','02/07','02/22','03/08','03/23','04/07'})
ylabel('Number of confirmed cases')

plot(date,procase)
xlabel('Date')
set(gca,'XTick',0:15:75)
set(gca,'XTicklabel',{'01/23','02/07','02/22','03/08','03/23','04/07'})
ylabel('Number of confirmed cases')
columnlegend(2,{'Zhejiang','Shanghai','Beijing','Hebei','Henan','Hunan',...
    'Anhui','Jiangxi','Shaanxi','Shanxi','Sichuan','Chongqing','Guangxi',...
    'Guangdong','Jiangsu','Fujian','Shangdong','Neimenggu','Tianjin',...
    'Jilin','Heilongjiang','Tibet','Xinjiang','Gansu','Qinghai','Ningxia',...
    'Hainan','Liaoning','Guizhou','Yunan'},'location','northeast');
plot(date,mean(procase,2))
xlabel('Date')
set(gca,'XTick',0:15:75)
set(gca,'XTicklabel',{'01/23','02/07','02/22','03/08','03/23','04/07'})
ylabel('Number of confirmed cases')

plot(date,hbdeath)
xlabel('Date')
set(gca,'XTick',0:15:75)
set(gca,'XTicklabel',{'01/23','02/07','02/22','03/08','03/23','04/07'})
ylabel('Number of death cases')
legend({'Xiaogan','Huanggang','Jingzhou','Ezhou','Suizhou','Xiangyang',...
    'Huangshi','Yichang','Jingmen','Xianning','Shiyan','Xiantao','Tianmen',...
    'Enshi','Qianjiang','Shennongjia'},'location','northeast');
plot(date,mean(hbdeath,2))
xlabel('Date')
set(gca,'XTick',0:15:75)
set(gca,'XTicklabel',{'01/23','02/07','02/22','03/08','03/23','04/07'})
ylabel('Number of death cases')

plot(date,prodeath)
xlabel('Date')
set(gca,'XTick',0:15:75)
set(gca,'XTicklabel',{'01/23','02/07','02/22','03/08','03/23','04/07'})
ylabel('Number of death cases')
columnlegend(2,{'Zhejiang','Shanghai','Beijing','Hebei','Henan','Hunan',...
    'Anhui','Jiangxi','Shaanxi','Shanxi','Sichuan','Chongqing','Guxangxi',...
    'Guangdong','Jiangsu','Fujian','Shangdong','Neimenggu','Tianjin',...
    'Jilin','Heilongjiang','Tibet','Xinjiang','Gansu','Qinghai','Ningxia',...
    'Hainan','Liaoning','Guizhou','Yunan'},'location','northeast');
plot(date,mean(prodeath,2))
xlabel('Date')
set(gca,'XTick',0:15:75)
set(gca,'XTicklabel',{'01/23','02/07','02/22','03/08','03/23','04/07'})
ylabel('Number of death cases')
%Figure 1 and Figure 9


hbcasefd=smooth_basis(daytime,hbcase,daybasis77);
hbcasefd_fdnames{1}='Date';
hbcasefd_fdnames{2}='City in Hubei';
hbcasefd_fdnames{3}='New cases';
hbcasefd=putnames(hbcasefd,hbcasefd_fdnames);
procasefd=smooth_basis(daytime,procase,daybasis77);
procasefd_fdnames{1}='Date';
procasefd_fdnames{2}='Province';
procasefd_fdnames{3}='New Cases';
procasefd=putnames(procasefd,procasefd_fdnames);
%smooth confirmed cases data
hbdeathfd=smooth_basis(daytime,hbdeath,daybasis77);
hbdeathfd_fdnames{1}='Date';
hbdeathfd_fdnames{2}='City';
hbdeathfd_fdnames{3}='Number of New Deaths';
hbdeathfd=putnames(hbdeathfd,hbdeathfd_fdnames);
prodeathfd=smooth_basis(daytime,prodeath,daybasis77);
prodeathfd_fdnames{1}='Date';
prodeathfd_fdnames{2}='Province';
prodeathfd_fdnames{3}='New Cases';
prodeathfd=putnames(prodeathfd,prodeathfd_fdnames);
%smooth death cases data


%variance-covariance surface
hbcasebifd=var_fd(hbcasefd);
hbcasevar_mat=eval_bifd(weektime,weektime,hbcasebifd);
surfc(hbcasevar_mat)
xlabel('Date')
set(gca,'XTick',0:15:75)
set(gca,'XTicklabel',{'01/23','02/07','02/22','03/08','03/23','04/07'})
ylabel('Date')
set(gca,'YTick',0:15:75)
set(gca,'YTicklabel',{'01/23','02/07','02/22','03/08','03/23','04/07'})
zlabel('Variance')
c=colorbar;
c.Label.String='Variance Level';
procasebifd=var_fd(procasefd);
procasevar_mat=eval_bifd(weektime,weektime,procasebifd);
surfc(procasevar_mat)
xlabel('Date')
set(gca,'XTick',0:15:75)
set(gca,'XTicklabel',{'01/23','02/07','02/22','03/08','03/23','04/07'})
ylabel('Date')
set(gca,'YTick',0:15:75)
set(gca,'YTicklabel',{'01/23','02/07','02/22','03/08','03/23','04/07'})
zlabel('Variance')
c=colorbar;
c.Label.String='Variance Level';
% Figure 2

hbdeathbifd=var_fd(hbdeathfd);
hbdeathvar_mat=eval_bifd(weektime,weektime,hbdeathbifd);
surfc(hbdeathvar_mat)
xlabel('Date')
set(gca,'XTick',0:15:75)
set(gca,'XTicklabel',{'01/23','02/07','02/22','03/08','03/23','04/07'})
ylabel('Date')
set(gca,'YTick',0:15:75)
set(gca,'YTicklabel',{'01/23','02/07','02/22','03/08','03/23','04/07'})
zlabel('Variance')
c=colorbar;
c.Label.String='Variance Level';
prodeathbifd=var_fd(prodeathfd);
prodeathvar_mat=eval_bifd(weektime,weektime,prodeathbifd);
surfc(prodeathvar_mat)
xlabel('Date')
set(gca,'XTick',0:15:75)
set(gca,'XTicklabel',{'01/23','02/07','02/22','03/08','03/23','04/07'})
ylabel('Date')
set(gca,'YTick',0:15:75)
set(gca,'YTicklabel',{'01/23','02/07','02/22','03/08','03/23','04/07'})
zlabel('Variance')
c=colorbar;
c.Label.String='Variance Level';
% Figure 10

cd_city_bifd=var_fd(hbcasefd,hbdeathfd);
cor_city_mat=eval_bifd(weektime,weektime,cd_city_bifd);
surfc(cor_city_mat)
xlabel('Date of death cases')
set(gca,'XTick',0:15:75)
set(gca,'XTicklabel',{'01/23','02/07','02/22','03/08','03/23','04/07'})
ylabel('Date of confirmed cases')
set(gca,'YTick',0:15:75)
set(gca,'YTicklabel',{'01/23','02/07','02/22','03/08','03/23','04/07'})
zlabel('Covariance')
c=colorbar;
c.Label.String='Covariance Level';
cd_pro_bifd=var_fd(procasefd,prodeathfd);
cor_pro_mat=eval_bifd(weektime,weektime,cd_pro_bifd);
surfc(cor_pro_mat)
xlabel('Date')
set(gca,'XTick',0:15:75)
set(gca,'XTicklabel',{'01/23','02/07','02/22','03/08','03/23','04/07'})
ylabel('Date')
set(gca,'YTick',0:15:75)
set(gca,'YTicklabel',{'01/23','02/07','02/22','03/08','03/23','04/07'})
zlabel('Covariance')
c=colorbar;
c.Label.String='Covariance Level';
%Figure 11

% pca of confirmed cases of 16 cities and 30 provinces
hbcasefdParobj=fdPar(hbcasefd,harmaccelLfd,lambda);
hbcasepca=pca_fd(hbcasefd,nharm,hbcasefdParobj);
hbcasepca.varprop
plot_pca_fd(hbcasepca, 1)
%Figure 3

procasefdParobj=fdPar(procasefd,harmaccelLfd,lambda);
procasepca=pca_fd(procasefd,nharm,procasefdParobj);
procasepca.varprop
plot_pca_fd(procasepca, 1)
%Figure 4

hbdeathfdParobj=fdPar(hbdeathfd,harmaccelLfd,lambda);
hbdeathpca=pca_fd(hbdeathfd,nharm,hbdeathfdParobj);
hbdeathpca.varprop
plot_pca_fd(hbdeathpca, 1)
%Figure 12

prodeathfdParobj=fdPar(prodeathfd,harmaccelLfd,lambda);
prodeathpca=pca_fd(prodeathfd,nharm,prodeathfdParobj);
prodeathpca.varprop
plot_pca_fd(prodeathpca, 1)
%Figure 13

ccafd_hb=cca_fd(hbcasefd,hbdeathfd,ncan,hbcasefdParobj,hbdeathfdParobj);
ccafd_hb.corrs

g=plot(ccafd_hb.wtfdx(1));
set(g,'lineWidth',1.5,'Color','k')
ylim([-0.25,0.25])
xlabel('Date')
set(gca,'XTick',0:15:75)
set(gca,'XTicklabel',{'01/23','02/07','02/22','03/08','03/23','04/07'})
ylabel('Canonical weight function')
hold on
h=plot(ccafd_hb.wtfdy(1));
set(h,'LineStyle','--','LineWidth',1.5,'Color','b')
ylim([-0.25,0.25])
xlabel('Date')
set(gca,'XTick',0:15:75)
set(gca,'XTicklabel',{'01/23','02/07','02/22','03/08','03/23','04/07'})
ylabel('Canonical weight function')
hold off
legend('u_1 for confirmed cases','u^*_1 for death cases')
%Left panel of Figure 5
ccahbcscore=ccafd_hb.varx;
ccahbdscore=ccafd_hb.vary;
plot(ccahbcscore(:,1),ccahbdscore(:,1), 'o')
xlabel('Confirmed case canonical weight')
ylabel('Death case canonical weight')
text(ccahbcscore(:,1),ccahbdscore(:,1), city,'HorizontalAlignment',...
    'center','VerticalAlignment','bottom','FontSize',10)
%Top panel of Figure 7

ccafd_pro=cca_fd(procasefd,prodeathfd,ncan,procasefdParobj,prodeathfdParobj);
ccafd_pro.corrs

g=plot(ccafd_pro.wtfdx(1));
set(g,'lineWidth',1.5,'Color','k')
ylim([-0.25,0.25])
xlabel('Date')
set(gca,'XTick',0:15:75)
set(gca,'XTicklabel',{'01/23','02/07','02/22','03/08','03/23','04/07'})
ylabel('Canonical weight function value')
hold on
h=plot(ccafd_pro.wtfdy(1));
set(h,'LineStyle','--','LineWidth',1.5,'Color','b')
ylim([-0.25,0.25])
xlabel('Date')
set(gca,'XTick',0:15:75)
set(gca,'XTicklabel',{'01/23','02/07','02/22','03/08','03/23','04/07'})
ylabel('Canonical weight function value')
legend('v_1 for confirmed cases','v^*_1 for death cases','Location','northwest')
%Right panel of Figure 5
ccaprocscore=ccafd_pro.varx;
ccaprodscore=ccafd_pro.vary ;
plot(ccaprocscore(:,1),ccaprodscore(:,1), 'o')
xlabel('Confirmed case canonical weight')
ylabel('Death case canonical weight')
text(ccaprocscore(:,1),ccaprodscore(:,1), province,'HorizontalAlignment',...
    'center','VerticalAlignment','bottom','FontSize',10)
%Bottom panel of Figure 6
