THe present scripts calcualtes the total sensitivity indeces with the method of Glen and Isaacs (2012) expressed under formulae D3
Results are stored in the variable ST after execution

clear all;
k=6; %number of function parameters
N=1000; %number of model runs
a = [0, 0.5, 3, 9, 99, 99]; %G function parameters


ST=[];

 y4mean=[];
 y4var=[];
%Xsamp=csvread('sample.csv');
[Xsamp, rshift]=rqmc(N,k*2,1,0);
   for i=1:N
       X=[];
       %generation of uniform samples in (0;1)
       T = Xsamp(i,1:2*k);
       
       A=T(1:k);
       B=T(k+1:2*k);
       
       %input with dim: 2k+2
       X=[A;B];
       
    for j=1:k;
        Ab=A;
        Ab(j)=B(j);
        X=[X;Ab];
    end
        j=1;
    for j=1:k;
        Ba=B;
        Ba(j)=A(j);
        X=[X;Ba];
    end   
      
 for e=1:length(X)
 [y(e,:),STitrue]=G_star_func(X(e,:),a,1,[0 0 0 0 0 0]);
 end


y4mean=[y4mean; y];
y4var=[y4var; y(1); y(2)];
m=mean(y4mean);
v=var(y4mean);
        
     for j=1:k
            
         
            go(i)=(y(1)-m)/sqrt(v);
            gop(i)=(y(2)-m)/sqrt(v);
            gj(i)=(y(2+j)-m)/sqrt(v);
            gjp(i)=(y(2+k+j)-m)/sqrt(v);


            csmj(i,j)=go*gj;
            po(i,j)=go*gop;
            csj(i,j)=gop*gj;
            cdj(i,j)=(gop*gj+go*gjp);
            cdmj(i,j)=(go*gj+gop*gjp);
            pj(i,j)=(go*gop+gj*gjp);
            

            xcsmj=nanmean(csmj(:,j));
            xpo=nanmean(po(:,j));
            xcsj=nanmean(csj(:,j));
            xcdj=nanmean(cdj(:,j))/2;
            xcdmj=nanmean(cdmj(:,j))/2;
            xpj=nanmean(pj(:,j))/2;
            xcaj=(xcdj-xpj*xcdmj)/(1-xpj^2);
            xcamj=(xcdmj-xpj*xcdj)/(1-xpj^2);
                                     
ST(i,j)=1-xcdmj+(xpj*xcaj)/(1-xcaj*xcamj);
    
      end
       
end %N
