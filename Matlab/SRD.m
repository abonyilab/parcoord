%% Calculation of SRD and SRD matrix. Written by János Abonyi and Ádám Ipkovich, 10.10.2021
% SRD - Calculate the SRD matrix of a N×n matrix
% srdi = SRD(ranked_data, g) returns only the golden based SRD, with ranked_data as the ranked
% data and g as the golden
%[srdi, srdindex] = SRD(ranked_data, g) returns the golden based
%   SRD and the original orientation
%[srdi, srdindex, srdmat] = SRD(ranked_data, g) returns the golden based
%   SRD and the original orientation, and the SRD matrix that contains all
%the SRD values based on each variable.
%[srdi, srdindex, srdmat, srdlabels] = SRD(ranked_data, g) returns the golden based
%   SRD and the original orientation, and the SRD matrix that contains all
%   the SRD values based on each variable.
%[srdi, srdindex, srdmat, srdlabels, srd_ranked_data] = SRD(data, g,
%axesnames, stdcheck) returns the ranked data in srdindex order
%Data variable should be an N×n matrix. The function is NaN sensitive. Ensure that
%   no NaNs can be found in the data matrix.
%The golden should be predefined. No NaNs are allowed.
%If stdcheck is true, it removes the rankings with high standard
%   deviation. The default values is false as it is an optional variable.
%axesnames is an optional variable. If stdcheck is true, the respective
%   axesname is removed along with the variable.
%   If not supplied, the indexes of the remaining variables in the original order is provided. 

function [srdi, srdindex, srdmat, srdlabels, srd_ranked_data, dist] = SRD(data, g, axesnames, goldenname, stdcheck)
R = tiedrank(data)
 if ~exist('stdcheck','var')
     % if no stdcheck, then don't do it
      stdcheck = false;
 end
 if ~exist('goldenname','var')
     %if no lables are given, then return the order of the labels as should
     %be
      goldenname = "Gold Standard";
  end
  if ~exist('axesnames','var')
     %if no lables are given, then return the number of the labels
      axesnames = 1:n;
  end
srdlabels = axesnames;
if stdcheck
     ri=find(std(R)==0);
    R(:,ri)=[];
    srdlabels(ri)=[];

    [remind]=find(min(R)>10);
    R(:,remind)=[];
    srdlabels(remind)=[];
end
[N, n] = size(R);

    if rem(N,2)==1
        k=(N-1)/2;
        m=2*k*(k+1);
    else
        k=N/2;
        m=2*k^2;
    end 
nrk=tiedrank(g, 'omitnan'); 
dist = abs(R-repmat(nrk,1,n))
srd=sum(dist,1, 'omitnan')/m*100;

srdg = [0, srd];
[srdi, srdindex] = sort(srdg);
srdlabels=[goldenname, srdlabels];
srdlabels = srdlabels(srdindex);

R = [nrk, R];
orderedR = R(:, srdindex);
srdmat = [];
for j =1:n+1
     srdmat =[srdmat; sum(abs(orderedR - orderedR(:, j)), 1, 'omitnan')/m*100];
end

srd_ranked_data = R(:, srdindex);
end