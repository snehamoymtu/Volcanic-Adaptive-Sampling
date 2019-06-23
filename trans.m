function [cx,rot]=trans(cx,model,im)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code is adopted and modified from Marcotte (1991).
% Please check this link for Marcotte (1991) and the associated codes.
% https://www.sciencedirect.com/science/article/pii/009830049190028C?via%3Dihub

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[n,d]=size(cx);
[m,p]=size(model);

if p-1>d,

   if d==2,
      ang=model(im,4); cang=cos(ang/180*pi); sang=sin(ang/180*pi);
      rot=[cang,-sang;sang,cang];
   else
      angz=model(im,7); cangz=cos(angz/180*pi); sangz=sin(angz/180*pi);
      angy=model(im,6); cangy=cos(angy/180*pi); sangy=sin(angy/180*pi);
      angx=model(im,5); cangx=cos(angx/180*pi); sangx=sin(angx/180*pi);
      rotz=[cangz,-sangz,0;sangz,cangz,0;0 0 1];
      roty=[cangy,0,sangy;0 1 0;-sangy,0,cangy];
      rotx=[1 0 0;0 cangx -sangx;0 sangx cangx];
      rot=rotz*roty*rotx;
   end 

   dm=min(3,d);
   cx(:,1:dm)=cx(:,1:dm)*rot;
   t=[model(im,2:1+dm),ones(d-dm,1)];
   t=diag(t);
 else
   t=eye(d)*model(im,2);
end
  cx=cx/t;

  