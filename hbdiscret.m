function [ dataLC ] = hbdiscret( data, k )
% HBDISCRET discretizes a dataset based on histograms
% FIV (TU Wien), Nov 2017
%
% Inputs:
%  data, input dataset
%
% Outputs:
%  dataLC, discretized dataset

    [m,n]=size(data);
	binning_param=20;
	for i=1:n
            D=data(:,i);
            [distro,edges] = histcounts(D,round(log10(k)*binning_param));
            values = edges(2:end);
            X(:,i) = discretize(D,edges,values);
        end
        dataLC=unique(X,'rows');
end
