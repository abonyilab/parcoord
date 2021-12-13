clear all
close all
clc

%% Read data
climate_data = readtable('co2_data.xlsx');


%% Create a variable for the appropriate values and convert to emission per cap
golden = climate_data.TOTeAllGHG./climate_data.Pop*1000^2; % Generate Golden Standard
axesnames = [string(climate_data.Properties.VariableNames(2:18)) string(climate_data.Properties.VariableNames(20:end))]; %Create variable for labels
num = [table2array(climate_data(:, 2:18))./climate_data.Pop *1000^2, table2array(climate_data(:, 20))./climate_data.Pop, table2array(climate_data(:, 21:end))];
% Transform the variables to pop/capita

%% Perform alphabet based parallel coordinates
R = tiedrank(num);
ri=find(std(R)==0);
R(:,ri)=[];
ax = axesnames;
ax(ri)=[];
[remind]=find(min(R)>10);
R(:,remind)=[];
ax(remind)=[];
[axnam, axnami] = sort(ax)
figure(1)
[abctau, abcinter] = parcoord(R(:, axnami), 1:length(axesnames)-1, axnami, axnam);

%% SRD based parallel coordinates
u = [num(:, 1:13), num(:, 15:end)]; % Remove golden from database
[N,n] = size(u);

axesnames(13) = []; %Remove golden

[srdi, srdindex, srdmat, srdlabels, srd_ranked_data] = SRD(u, golden, axesnames, string(climate_data.Properties.VariableNames(15)), true);
figure(2)
[stau, sinter] = parcoord(srd_ranked_data, srdi, srdindex, srdlabels);
%% Perform the srd angle based parallel coordinates
[angles, axes, index] = parcoord_angles(srdmat, srdi);
figure(3)
[angletau, angleinter] = parcoord(srd_ranked_data(:, index), axes, index, srdlabels(index));
%% Perform the srd angle based parallel coordinates - compact
figure(4)
parcoord_srd_angle(u, golden, axesnames);

%% MDS

tau = corr(srd_ranked_data, 'type', 'Kendall');
[Y, e] = cmdscale(1-tau,1);
[x, index] = sort(Y);

figure(6)
[mdstau, mdsinter] = parcoord(srd_ranked_data(:, index), x, index, srdlabels(index));
