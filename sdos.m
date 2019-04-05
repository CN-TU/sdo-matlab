function [ y, observers, param ] = sdos( data, param )
% SDO (Sparse Data Observers) algorithm 
% SDO performs outlier detection based on the creation of a low density
% model of the data (safe version - time demanding)
% Created:      Nov 2017 FIV (TU Wien)
% Last update:  Apr 2019 FIV (TU Wien)
%   
% Inputs:
%   data, training dataset
%   param. 
%       k, number of observers
%       q, observation threshold
%       qv, quantile threshold for 'q' calculation
%       x, closest observers
%       sd, random seed
%       hbs, histogram-based selection of observers flag
%       ynorm.c, constant for score amplification
%
% Outputs:
%   y, outlierness score
%   observers, i.e., set of point with the SDO low density model
%   param.
%       m, number of samples
%       n, number of dimensions
%       kp, number of active observers
%       ynorm.ave, mean of scores
%       ynorm.std, standar deviation of scores
%       ynorm.min, minimun score

    [m,n]=size(data);
    if exist('param')==0, param=[];end
    if isfield(param,'k')==0, 
        % Caclulation of 'k' if not defined
        % 'k' is established based on sample size for finite populations using the 
        % variance of PCA most important parameter
        [c_pca,s_pca] = princomp(data);
        sigma = std(s_pca(:,1));
        if sigma<1,sigma=1;end
        error = 0.1*std(s_pca(:,1));
        [ param.k ] = sample_size( m, sigma, error );
    end
    if isfield(param,'x')==0, param.x= 5; end % default value for 'x' if not defined
    if isfield(param,'sd')==0, param.sd= 1000; end % default value for 'sd' if not defined
    if isfield(param,'hbs')==0, param.hbs= 0; end % 'hbs=0' by default
    
    if (param.sd>0)
        %if sd<=0, the script does not seed the random number generator  
        rng(param.sd);
    end
    
    param.m=m;
    param.n=n;
    k=param.k;
    %q=param.q; (below)
    x=param.x;
    hbs=param.hbs;
    r=[];

    % if histogram-based sampling is desired
    if (hbs)     
        dataLC=hbdiscret(data,k);
        [mLC,n]=size(dataLC); 
        k=min(mLC,k);
    else
        mLC=m;
        dataLC=data;
    end  

    % ------------- TRAINING ------------
    ind=randperm(mLC);
    observers = dataLC(ind(1:k),:);        
    for i=1:m
        distA=dist(data(i,:),observers');
        [val indA]=sort(distA);
        closest(i,:)=indA(1:x);
    end

    for i=1:k
        A=closest==i;
        A=sum(A');
        iMXi=ones(m,n);
        iMXi=bsxfun(@times, iMXi,observers(i,:));
        AX=bsxfun(@times, data,A');
        AXs=AX(A>0,:);
        AXs=median(AXs);
        actM(i)=sum(sum(A));
    end
    
    if isfield(param,'qv')==0, param.qv=0.3; end % 'qv=0.3' by default
    if isfield(param,'q')==0, 
        % if 'q' is not defined, 'q' is calculated based on 'qv'
        param.q = quantile(actM,param.qv)+1;
    end
    q=param.q;

    observers(actM<q,:)=[];
    [kp,n]=size(observers); 
    param.kp=kp;
    
    % ------------- APPLICATION ------------
    for i=1:m
        a=data(i,:);
        distB=dist(a,observers');
        [val indB]=sort(distB);
        xb=min(length(indB),x);
        BX=observers(indB(1:xb),:);
        y(i)=median(dist(a,BX'));
    end
    yc=2;
    param.ynorm.ave=mean(y);
    param.ynorm.std=std(y);
    param.ynorm.c=yc;
    y=yc*zscore(y);
    param.ynorm.min=min(y);
    y=y-min(y);
end
    
