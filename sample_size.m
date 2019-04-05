function [ n ] = sample_size( N, s, e )
% SAMPLE_SIZE calculates the number of samples to match the mean for a case
% of finite population
% Created:      May 2018 FIV (TU Wien)
%
% Inputs:
%   N, population size
%   s, sigma
%   e, error
%
% Outputs:
%   n, sample size

z=1.96;
num=N*power(z,2)*power(s,2);
den=(N-1)*power(e,2)+power(z,2)*power(s,2);
n=floor(num/den);
end

