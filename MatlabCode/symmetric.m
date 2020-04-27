%The following script reproduces the coding of Saltenis (as presented in Saltelli et al., 2010) on a symmetric
%design, calcualtes the total order indices and plote the mean absolute error on a logarythmic scale
%across r repetitions. It was written to work with the Gfunction, but you can substitute
%any other function at line 40 (provided you inthere mark as STitrue the
%analytical values)

clear all;
a = [0, 0.5, 3, 9, 99, 99]; %G function values
k=6; %number of parameters
N=1000; %number of desired mondel runs
repetitions=1; %number of desired repetitions

A=[];
B=[];
err=[];
erz=zeros(N,1);
cont=0;
MAE=zeros(N,1);

for r=1:repetitions
[Xsamp, rshift]=rqmc(N,k*2,1,0); %input sampling, subsitute here you matrix of input design if you have one
y4var=[];
 for l=1:N
   X=[];
       UT = Xsamp(l,1:2*k);
       A=UT(1:k);
       B=UT(k+1:2*k);
       X=[A;B];
       
    for j=1:k;
        Ab=A;
        Ab(j)=B(j);
        X=[X;Ab];
    end

    for j=1:k;
        Ba=B;
        Ba(j)=A(j);
        X=[X;Ba];
    end 
    
   
       for e=1:length(X)
       [y(e,:), STitrue]=G_star_func(X(e,:),a,1,[0 0 0 0 0 0]); %function call, substitute here you function if you have one
       cont=cont+1;
       end
  
   
               
        yA=y(1);
        yB=y(2);
        yAb=y(3:k+2);
        y4var=[y4var;yA;yB];
        
        for j=1:k
           VT(l,j)=(yA-yAb(j))^2;
        end
        Vtot=varML(y4var);
        for j=1:k
        ST(l,j)=mean(VT(:,j))/2/Vtot;
        end 

 end 

for w=1:N
    for p=1:k
err(w,p)=abs(ST(w,p)-STitrue(p));
    end
end

err=sum(err,2);
erz=[erz err];
end

MAE=sum(erz,2)./repetitions;
xaxe2010=[1:N]*(2*k+2); 
plot(log(xaxe2010),log(MAE),'b');
xlabel('log2(model runs)');
ylabel('log2(err)');