function [var_grid]=krig_sc(Data_new,s1,mod1,c1,nk1,coc1,min_dis)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code is modified from Marcotte (1991).
% Please check this link for Marcotte (1991) paper and the associated codes.
% https://www.sciencedirect.com/science/article/pii/009830049190028C?via%3Dihub

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OUTOUT:

% var_grid: The kriging variance calculated at grid file locations

% The negative weights are adjusted according to Rao and Journel (1997),
% Please check our paper for detail reference.



K=[];
for i=1:length(Data_new)
d=dist(s1,Data_new(i,1:2)');
ind=find(d==min(d));
min_d=d(ind(1));
K=[K;ind(1) min_d s1(ind(1),:)];
end

k= K(:,2)<=min_dis;
k_p=K(k,1);
s1(k_p,:)=[];

[~,idx,~]=unique(Data_new(:,1:2),'rows');

Data1=Data_new(idx,:);

for i=1:length(s1)
d=dist(Data1(:,1:2),s1(i,1:2)');
s_new=[Data1(:,1:2) d];
s_new1=sortrows(s_new,3);
ss=s_new1(1:nk1,1:2);
kk=covardm(ss(:,1:2),ss(:,1:2),mod1,c1);
sp=find(kk(:,:)==0);
spt=ceil(sp/nk1);
kk(spt,:)=[];
kk(:,spt)=[];
k0=covardm(ss(:,1:2),s1(i,1:2),mod1,c1);
k0(spt)=[];
%kk_inv=inv(kk);
kk1=[kk ones(length(kk),1);ones(length(kk),1)' 0];
k01=[k0;1];
w=kk1\k01;
lamda_new=w(1:length(kk));

if min(lamda_new)<0
    lamda_new=lamda_new-min(lamda_new);
    lamda_new=lamda_new./sum(lamda_new);
end

lambda1=[lamda_new; w(length(kk)+1)];

%krig_v = total_sill - k'*lambda1;

var_1=coc1-lambda1'*k01;
var_grid(i,:)=[s1(i,1:2) var_1];
end