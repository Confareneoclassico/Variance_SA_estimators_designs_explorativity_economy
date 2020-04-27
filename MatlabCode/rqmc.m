function [Xsamp, rshift]=rqmc(N,d,r,plott)

% generates an (Nxdxr) array of r randomly shifted Sobol' samples, each of
% N points in d dimensions.
%
% Uses a single random d-dimensional shift vector to shift all points, for
% each of the r samples.
%
% Use plott=1 to plot samples and vectors, else plott=0 for no plot. Only
% works for 2D samples of course (could use plot3 tho)

X=net(sobolset(d),N);
%X=lptauSEQ(N,d);   %the original sample
% NOTE I have switched to the sobolseq8192 here,
% switch to sobolset if have got the statistics toolbox. Otherwise, requires
% sobolseq8192.dll, possibly LPTAU51.m and definitely lptauSEQ.m

Xsamp=ones(N,d,r);      %the sample matrices
rshift=ones(r,d);       %the random shift vectors

for i=1:r
    rshift(i,:)=rand(1,d);
    Xsamp(:,:,i)=X+repmat(rshift(i,:),N,1)-floor(X+repmat(rshift(i,:),N,1));
end

if plott==1
    figure
    hold on
    for i=1:r
        plot(Xsamp(:,1,i),Xsamp(:,2,i),'.');
        arrow([0,0],rshift(i,:))
    end
    axis tight
end