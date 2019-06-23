function [k]=covardm(x,x0,model,c)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code is adopted and modified from Marcotte (1991).
% Please check this link for Marcotte (1991) and the associated codes.
% https://www.sciencedirect.com/science/article/pii/009830049190028C?via%3Dihub

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Here we define the equations for the various typr of variogram models. 
% Given the data matrix (vector) x and x0, and variogram model parameters
% model and c, we can calculate the covariance matrix.

k=[];
Gam=['h==0                                              '; %nugget
     'exp(-h)                                           '; %exponential
     'exp(-(h).^2)                                      '; %gaussian
     '1-(1.5*min(h,1)/1-.5*(min(h,1)/1).^3)             '; %spherical
     '1-h                                               ']; %linear
   
% definition of some constants


[n1,d]=size(x); 
[n2,d]=size(x0);
[rp,p]=size(c);
r=rp/p;  
cx=[x(:,1:d);x0];
nm=size(model,2);

model(:,2)=max(model(:,2),100*eps);

if nm>2
    model(:,3:2+d)=max(model(:,3:2+d),100*eps);
end
 

    
 k=zeros(n1*p,n2*p);
for i=1:r,

   [t1]=trans(x(:,1:d),model,i);
   [t2]=trans(x0,model,i);
   h=0;
   for id=1:d
      h=h+(t1(:,id)*ones(1,n2)-ones(n1,1)*t2(:,id)').^2;
   end
   h=sqrt(h);
   ji=(i-1)*p+1; js=i*p ;

   % evaluation of the current basic structure
   g=eval(Gam(model(i,1),:));
   k=k+kron(g,c(ji:js,:));
end
 