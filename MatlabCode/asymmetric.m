%The following script reproduces the coding of Saltenis as presented in Saltelli et al. (2010) on a asymmetric
%design, calcualates the total order indices and plot the mean absolute error on a 10-logarythmic scale
%across r repetitions. It was written to work with the Gfunction, but you can substitute
%any other function at line 40 (provided you inthere mark as STitrue the
%analytical values)

clear all;

a = [0, 1, 4.5, 9, 99, 99, 99, 99]; %G function paramters
k=8; % number of input parameters
N=1600; %number of desired model runs
repetitions=1; %number of desired repetitions

A=[];
B=[];
err=[];
erz=zeros(N,1);
MAE=zeros(N,1);

for r=1:repetitions
[Xsamp, rshift]=rqmc(N,k*2,1,0); %input design, subsitute here you input matrix if you have one (E.g.:    % Xsamp=csvread('sample.csv' );)
y4var=[];
 for l=1:N
   X=[];
        UT = Xsamp(l,1:2*k);

       A=UT(1:k);
       B=UT(k+1:2*k);
       X=[A];
       
    for j=1:k;
        Ab=A;
        Ab(j)=B(j);
        X=[X;Ab];
    end

    
   
       for e=1:length(X)
       [y(e,:), STitrue]=G_star_func(X(e,:),a,1,[0 0 0 0 0 0 0 0]);
       end
  
   
               
        yA=y(1);
     
        yAb=y(2:k+1);
        y4var=[y4var;yA];
        
        for j=1:k
           VT(l,j)=(yA-yAb(j))^2;
        end
        Vtot=var(y4var);
        
        for j=1:k
        ST(l,j)=mean(VT(:,j))/2/Vtot;
        end 
        
 end 

 
for w=1:N
    for p=1:k
err(w,p)=abs(ST(w,p)-STitrue(p));
    end
end

err=sum(err,2)/k;
erz=[erz err];
end

erz(:,1)=[];
MAE=sum(erz,2)./repetitions;
xaxe2010=[1:N]*(k+1); 

plot(log10(xaxe2010),log10(MAE),'r');
xlabel('log10(model runs)');
ylabel('log10(err)');