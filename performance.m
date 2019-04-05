function [ index ] = performance ( score, outlier )
% Calculate performance indices as presented here:
%           On the Evaluation of Unsupervised Outlier Detection: Measures, Datasets, and an Empirical Study
%           by G. O. Campos, A. Zimek, J. Sander, R. J. G. B. Campello, B. Micenková, E. Schubert, I. Assent and M. E. Houle
%           Data Mining and Knowledge Discovery 30(4): 891-927, 2016, DOI: 10.1007/s10618-015-0444-8
%           http://www.dbs.ifi.lmu.de/research/outlier-evaluation/DAMI/
%
% Created:      May 2018 FIV (TU Wien)
% Last update:  Apr 2019 FIV (TU Wien)

card_O=sum(outlier);
N=length(outlier);
a(:,1)=score;
a(:,2)=outlier;
b=sortrows(a,-1);
I=(1:N)';

% P@n
fprintf("Calculating P@n\n");
n=card_O;
patn=sum(b(1:n,2))/n;

% Adjusted P@n
fprintf("Calculating Adjusted P@n\n");
adj_patn=(patn-card_O/N)/(1-card_O/N);

% AP
fprintf("Calculating AP\n");
%ap=zeros(card_O,1);
ap=cumsum(b(1:card_O,2))./I(1:card_O);
AP=sum(ap)/card_O;

% Adjusted AP
fprintf("Calculating Adjusted AP\n");
adj_AP=(AP-card_O/N)/(1-card_O/N);

% ROC/AUC
fprintf("Calculating ROC_AUC\n");
if (sum(outlier))
    [X,Y,T,AUC] = perfcurve(outlier,score,1);
else 
    AUC=0;
end

%F1
fprintf("Calculating F1\n");
f1=zeros(N,1);
tp=cumsum(b(:,2));
fp=I-tp;
fn=card_O-tp;
f1=2.*tp./(2.*tp+fp+fn);
F1max=max(f1);

% Adjusted MF1
fprintf("Calculating Adjusted MF1\n");
adj_MF1=(F1max-card_O/N)/(1-card_O/N);

index.P_at_n=patn;
index.adjP_at_n=adj_patn;
index.AP=AP;
index.adjAP=adj_AP;
index.ROC_AUC=AUC;
index.MaxF1=F1max;
index.adj_MF1=adj_MF1;
end
