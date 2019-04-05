function [ y ] = sdos_apply_model( data, observers, x, ynorm )
% SDOS_APPLY_MODEL uses a model (set of observers) to calculate 
% outlierness scores in new data (safe version - time demanding)
% Created:      Dec 2017 FIV (TU Wien)
% Last update:  Apr 2019 FIV (TU Wien)
%   
% Inputs:
%   data, training dataset
%   observers, i.e., set of points with the SDO low density model
%   x, closest observers
%   ynorm, for the score normalization
%       .ave, mean of scores in training
%       .std, standar deviation of scores in training
%       .min, minimun score in training
%       .c, constant for score amplification
%
% Outputs:
%   y, normalized outlierness score


    if exist('ynorm')==0, ynorm=[];end
    if isfield(ynorm,'ave')==0, ynorm.ave=0; end
    if isfield(ynorm,'std')==0, ynorm.std=1; end
    if isfield(ynorm,'min')==0, ynorm.min=0; end
    if isfield(ynorm,'c')==0, ynorm.c=1; end
    if exist('x')==0, x=5;end

    [m,n]=size(data);
    % ------------- APPLICATION ------------
    for i=1:m
        a=data(i,:);
        distB=dist(a,observers');
        [val indB]=sort(distB);
        xb=min(length(indB),x);
        BX=observers(indB(1:xb),:);
        y(i)=median(dist(a,BX'));
        y(i)=ynorm.c*(y(i)-ynorm.ave)/ynorm.std-ynorm.min;
    end
end
    
