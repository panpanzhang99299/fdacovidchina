load('hbcase.mat')
load('hbdeath.mat')
load('procase.mat')
load('prodeath.mat')
weektime=linspace(0,77,77);
daytime=(1:77)'-0.5;
dayperiod=77;
dayrange=[0,77];
nbasis=9;
daybasis77=create_fourier_basis(dayrange,nbasis);
hbcasefd=smooth_basis(daytime,hbcase,daybasis77);
hbcasefd_fdnames{1}='Day';
hbcasefd_fdnames{2}='City in Hubei';
hbcasefd_fdnames{3}='New cases';
hbcasefd=putnames(hbcasefd,hbcasefd_fdnames);

procasefd=smooth_basis(daytime,procase,daybasis77);
procasefd_fdnames{1}='Day';
procasefd_fdnames{2}='Province';
procasefd_fdnames{3}='New Cases';
procasefd=putnames(procasefd,procasefd_fdnames);

hbdeathfd=smooth_basis(daytime,hbdeath,daybasis77);
hbdeathfd_fdnames{1}='Day';
hbdeathfd_fdnames{2}='City';
hbdeathfd_fdnames{3}='Number of New Deaths';
hbdeathfd=putnames(hbdeathfd,hbdeathfd_fdnames);

prodeathfd=smooth_basis(daytime,prodeath,daybasis77);
prodeathfd_fdnames{1}='Day';
prodeathfd_fdnames{2}='Province';
prodeathfd_fdnames{3}='New Death';
prodeathfd=putnames(prodeathfd,prodeathfd_fdnames);

%variance surfaces of confirmed cases and death cases
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
title('Variance Surface of Confirmed Cases of 16 cities in Hubei','Fontsize',30)

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
title('Variance Surface of Confirmed Cases of 30 provinces','FontSize',30)

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
title('Variance Surface of death Cases of 16 cities in HUbei','FontSize',30)

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
title('Variance Surface of death Cases of 30 provinces','FontSize',30)

%covariance surface
cd_city_bifd=var_fd(hbcasefd,hbdeathfd);
cor_city_mat=eval_bifd(weektime,weektime,cd_city_bifd);
surfc(cor_city_mat)
xlabel('Date')
set(gca,'XTick',0:15:75)
set(gca,'XTicklabel',{'01/23','02/07','02/22','03/08','03/23','04/07'})
ylabel('Date')
set(gca,'YTick',0:15:75)
set(gca,'YTicklabel',{'01/23','02/07','02/22','03/08','03/23','04/07'})
zlabel('Covariance')
title('Covariance Surface of confirmed and death Cases of 16 cities in Hubei','FontSize',30)
% covariance surface between confirmed &death cases of 16 cities

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
title('Covariance Surface of confirmed and death Cases of 30 provinces','FontSize',30)
% covariance surface between confirmed &death cases of 30 provinces
