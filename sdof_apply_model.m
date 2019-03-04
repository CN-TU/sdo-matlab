function [ y ] = sdof_apply_model( data, observers, x, ynorm )
% SDOF_APPLY_MODEL uses a model (set of observers) to calculate 
% outlierness scores in new data (fast version)
% FIV (TU Wien), May 2018 (created)
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
    distB=dist(data,observers');
    [val indB]=sort(distB');
    y=median(val(1:x,:));
    a=ynorm.c*(y-ynorm.ave)/ynorm.std-ynorm.min;
end
    
