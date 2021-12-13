clear all
close all
clc

%% Read data - Octave requires io package
[climate_data, varnames] = xlsread('co2_data.xlsx');

axesnames = [varnames(1, 2:18), varnames(1, 20:end)]; %Create variable for labels

%% Create a variable for the appropriate values and apply a transformation, here the golden is removed
num = [climate_data(:, 1:17)./climate_data(:, 18)*1000^2, climate_data(:, 19)./climate_data(:, 18), climate_data(:, 20:end)];
golden = num(:, 14); % Get Golden Standard
% Transform the variables to pop/capita

%% Perform alphabet based parallel coordinates
##R = tiedrank(num);
##ri=find(std(R)==0);
##R(:,ri)=[];
##ax = axesnames;
##ax(ri)=[];
##[remind]=find(min(R)>10);
##R(:,remind)=[];
##ax(remind)=[];
##[axnam, axnami] = sort(ax)
##figure(1)
##[abctau, abcinter] = parcoord(R(:, axnami), 1:length(axesnames)-1, axnami, axnam);


%% SRD based parallel coordinates
u = [num(:, 1:13), num(:, 15:end)];
[N,n] = size(u);
srdlabels = [axesnames(1:13),axesnames(15:end)]
[srdi, srdindex, srdmat, srdlabels, srd_ranked_data] = SRD(u, golden, srdlabels, axesnames(14), true);
figure(2)
[stau, sinter] = parcoord(srd_ranked_data, srdi, srdindex, srdlabels);
%% Perform the srd angle based parallel coordinates
[angles, axes, index] = parcoord_angles(srdmat, srdi);
figure(3)
[angletau, angleinter] = parcoord(srd_ranked_data(:, index), axes, index, srdlabels(index));
%% Perform the srd angle based parallel coordinates - compact
figure(4)
parcoord_srd_angle(u, golden, [axesnames(1:13), axesnames(15:end)], axesnames(14));


tau = [];
for j =2:n
    tau = [tau kendall(srd_ranked_data(:, j-1), srd_ranked_data(:, j))];
end
[Y, e] = cmdscale(1-tau,1);
[x, index] = sort(Y);

figure(6)
[mdstau, mdsinter] = parcoord(srd_ranked_data(:, index), x, index, srdlabels(index));

