function [ dataLC ] = hbdiscret( data, k )
% HBDISCRET discretizes a dataset based on histograms
% Created:      Nov 2017 FIV (TU Wien)
% Last update:  Apr 2019 FIV (TU Wien)
%
% Inputs:
%  data, input dataset
%  k, number of observers
%
% Outputs:
%  dataLC, discretized dataset

    [m,n]=size(data);
	binning_param=20;
    X=zeros(m,n);
	for i=1:n
            D=data(:,i);
            [distro,edges] = histcounts(D,round(log10(k)*binning_param));
            values = edges(2:end);
            X(:,i) = discretize(D,edges,values);
    end
    dataLC=unique(X,'rows');
end
