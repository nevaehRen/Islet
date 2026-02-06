
% ###########################################################################
% File Description:
% This file contains experimental data from 3 sets of IVGTT (Intravenous Glucose Tolerance Test) 
% conducted on INS-GCAMP-wt/ob mice. The included data categories are:
%   1. Ca trace (Calcium signal trace)
%   2. Blood glucose concentrations
%   3. Oscillation peaks (of Ca signal/blood glucose) 
% ###########################################################################


clear;
clc;
close all;

load CGM_IVGTT_mice1.mat
load CGM_IVGTT_mice2.mat
load CGM_IVGTT_mice3.mat

Name = Islet(1).Name;
T    = length(Islet(2).Ca);

OscillationCount = [];

for i = 1:length(Islet)
    temp = Islet(i).Ca*0;
    Islet(i).Peak_Time = [Islet(i).Peaks.t3];
    OscillationCount = [OscillationCount; length(Islet(i).Peak_Time)];
end

[s,r] = sort(OscillationCount,'ascend');
Islet = Islet(r);


figure; hold on;
set(gcf,"Position",[165 134 1107 1115],'color','w','Renderer','Painters');
ax(1) = subplot(8,1,1);
plot(Islet(1).BG,'k');
ylabel('BG');
title(strrep(Name,'_',' '),'FontSize',20);

ax(2) = subplot(8,1,2);
plot(Islet(end).Ca_01,'k'); hold on;
axis off;

ax(3) = subplot(8,1,3:5); hold on;
for i = 1:length(Islet)
scatter(Islet(i).Peak_Time, Islet(i).Peak_Time*0+i,[30],'filled','|','MarkerEdgeColor','k','MarkerFaceColor','k')
end
axis off

ax(4) = subplot(8,1,6:8); hold on;
for i=1:length(Islet)
    Islet(i).Ca=Islet(i).Ca_01;
end
imagesc([Islet.Ca]');
xlim([1 T]);

saveas(gca,'raster plot.png');
