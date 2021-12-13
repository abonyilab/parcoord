%% Function to call the SRD angle based parallel coordinates. Written by János Abonyi and Ádám Ipkovich, 10.10.2021 (ddmmyyyy)
% parcoord_srd_angle - draws a figure of angle-based SRD parallel
% coordinate visualization.
% [angletau, angleinter] = parcoord_srd_angle(u, g, axesnames)
% calculates the srd matrix of `u' with `g' as the golden standard, which are visualized with angel-based SRD parallel coordinates.
%The axes are labeled with axesnames.

function [angletau, angleinter] = parcoord_srd_angle(u, g, axesnames, goldenname)

[srdi, srdindex, srdmat, srdlabels, srd_ranked_data] = SRD(u, g, axesnames,goldenname, true);
[angles, axes, index] = parcoord_angles(srdmat, srdi);
[angletau, angleinter] = parcoord(srd_ranked_data(:, index), axes, index, srdlabels(index));

end