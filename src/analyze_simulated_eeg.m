% analyze_simulated_eeg.m
% -------------------------------------------------------------
% Analysis pipeline for simulated EEG data from ANT-DBS model
% using FieldTrip toolbox: epoching, GMFP, artifact removal,
% and topographical plotting.
%
% Author: Lorenzo Prione
% Last updated: April 2025
%
% Requirements:
% - FieldTrip toolbox (https://www.fieldtriptoolbox.org)
% - Files: "Stimulated EEG.mat", "Stimulated EEG Time.mat", 
%   "eeg_regions.txt", layout files (positions, labels, etc.)
%% Load of Dataset and labels
time = load("Stimulated EEG Time.mat"); % time in ms
trial = load("Stimulated EEG.mat");
time = {time.data};
trial = {squeeze(trial.data)'};
fileID = fopen('eeg_regions.txt', 'r');
regionNames = textscan(fileID, '%s');
fclose(fileID);
regionNames = regionNames{1};
%% Load Fieldtrip
addpath('C:\Users\loren\Downloads\fieldtrip-20240603')
ft_defaults;
%% Create data struct
data.label = regionNames;
data.time = time;
data.trial = trial;
data.fsample = 4096;
data.sampleinfo = [1, numel(data.time{1})];
cfg            = [];
cfg.dataset    = ['Stimulated EEG', '.mat'];
cfg.continuous = 'yes';
cfg.channel    = 'all';
%% reject "artifacts"
cfg        = [];
cfg.metric = 'range';
cfg.method = 'summary'; % use by default summary method
data       = ft_rejectvisual(cfg,data); %  IO1, IO2, CB1, CB2
%% PLOT EEG
figure
hold on
grid on

spacing = 10000000;

for i = 1:length(data.label)
    plot(data.time{1}/1000, data.trial{1}(i, :)*25 + (i-1) * spacing, 'k');
end

set(gca, 'YTick', (0:length(data.label)-1) * spacing);
set(gca, 'YTickLabel', data.label);

ylim([-spacing, length(data.label) * spacing]);

xlabel('Time (s)');
ylabel('Electrodes');
title('EEG');

hold off
grid off
%%
start_sample = 1;
window_duration_sec = 10;
end_sample = start_sample + window_duration_sec * data.fsample - 1;

start_sample = round(start_sample);
end_sample = round(end_sample);

time_window = data.time{1}(start_sample:end_sample) / 1000; % convert to seconds
trial_window = data.trial{1}(:, start_sample:end_sample);

%Define stimulation parameters
stim_start_time = 0; % start time in seconds
stim_duration = 0.01; % 50 ms duration for the pulse train
stim_amplitude = 100.0;
stim_period = 0.33; % period of the pulse train

% Generate the pulse train
rectPulse = @(t) double(t >= 0 & t < stim_duration);
pulse_times = stim_start_time:stim_period:(stim_start_time + window_duration_sec); % Times for the pulses
y = pulstran(time_window, pulse_times, rectPulse) * stim_amplitude;

figure
hold on
grid on

spacing = 10000000;
amplitude_scale = 25;

for i = 1:length(data.label)
    plot(time_window, trial_window(i, :) * amplitude_scale + (i-1) * spacing, 'k');
    plot(time_window, y * amplitude_scale * 25000 + (i-1) * spacing - spacing / 10, 'r');
end

set(gca, 'YTick', (0:length(data.label)-1) * spacing);
set(gca, 'YTickLabel', data.label);

ylim([-spacing / 10, length(data.label) * spacing]);

xlabel('Time (s)');
ylabel('Electrodes');
title('EEG');

hold off
grid off
%% FIND PERIODS BETWEEN STIMULATIONS
window_duration = 0.330; % 600 ms window
samples_per_window = round(window_duration * data.fsample);

num_pulses = ceil((60 - stim_start_time) / stim_period);

d_times = stim_start_time + (0:num_pulses-1) * stim_period;
d_samples = round(d_times * data.fsample);

% windows = cell(length(data.label), length(d_samples)-1);
% 
% for i = 1:length(d_samples)-1
%     start_sample = d_samples(i) + round(stim_duration * data.fsample);
%     end_sample = start_sample + samples_per_window - 1;
%     for j = 1:length(data.label)
%         windows{j,i} = data.trial{1}(j, start_sample:end_sample);
%     end
% end
%% DATA SELECTION
%Select the start of the stimulationlayout.pos = new_pos;
locs = d_samples(2:end-1);
%% Epoching the data:
pretrl   = round(0.03 * data.fsample); % Timesteps before start of the ED
posttrl  = round(0.3 * data.fsample); % Timesteps after start of ED 1

trl_startstop      = [];
trl_startstop(:,1) = locs(1,:)-pretrl;
trl_startstop(:,2) = locs(1,:)+posttrl; 

cfg_trl     = [];
cfg_trl.trl = [trl_startstop -pretrl*ones(size(trl_startstop,1),1)];
data        = ft_redefinetrial(cfg_trl, data);
trl = cfg_trl.trl; %
%% Check channels visually
cfg          = [];
cfg.viewmode = 'vertical'; %Channels below each other
%cfg.channel  = {'M2','M1','FC3'}; %Select channels you want to check; can scroll afterwards through others
 ft_databrowser(cfg, data);   
%% timelock analysis:
cfg = [];
cfg.preproc.demean = 'yes';
avgERPdbs64_raw = ft_timelockanalysis(cfg, data);
%% Global Mean Field
cfg = [];
cfg.method = 'amplitude';
EEG_free_gmfp = ft_globalmeanfield(cfg, avgERPdbs64_raw); %Calculate absolute average
figure, 
plot(1000*avgERPdbs64_raw.time,avgERPdbs64_raw.avg/10,'color',[0,0,0.5]); %All channels
hold on;
plot(1000*avgERPdbs64_raw.time,EEG_free_gmfp.avg/10,'color',[1,0,0],'linewidth',3);  %Check signal with global mean field. The blue lines are all channels, 
%The red line is the absolute average of all channels
xlabel('time(ms)'), ylabel('uV')
title('Global mean field after artifact removal')
ylim([-10  10])
xlim([-30  220])
%% Topoplot
load("positions.mat")
load("labels.mat")
load("width.mat")
load("height.mat")
load("mask.mat")
load("outline.mat")

idx = [1; 3; 7; 5; 14; 16; 25; 23; 30; 28; 8; 4; 17; 13; 26; 22; 24;...
    6; 53; 55; 56; 54; 29; 50; 49; 18; 21; 19; 20; 51; 52; 11; 10; 32;...
    33; 12; 9; 44; 46; 27; 47; 48; 43; 45; 41; 42; 40; 37; 38; 36; 34;...
    35; 31; 2; 29; 15];

cidx = zeros(size(idx));
cidx(idx) = 1:numel(idx);
cidx(39) = 55;

layout.pos     = positions;
layout.label   = labels;
layout.width   = width(1:56);
layout.height  = height(1:56);
layout.mask    = mask;
layout.outline = outline;

layout.pos(28,:) = [];
layout.pos(19:22,:) = [];

layout.label(28) = [];
layout.label(19:22) = [];

new_pos = layout.pos(cidx,:);
layout.pos = new_pos;

new_labels = layout.label(cidx);
layout.label = new_labels;

cfg.layout     = layout;

ft_layoutplot(cfg);
%%
% Prompt the user to enter a time point in milliseconds
prompt = 'Enter a time point (in milliseconds) for the topoplot: ';
selected_time_ms =0; %Time of topoplot (ms)
selected_time = selected_time_ms / 1000;  % Convert from milliseconds to seconds

% Find the closest time point index to the selected time
[~, idx] = min(abs(avgERPdbs64_raw.time - selected_time));
toi = avgERPdbs64_raw.time(idx);

[mxx, idxm] = max(max(abs(avgERPdbs64_raw.avg(:, idx))));
toi_mean_trial = toi(idxm);

cfg = [];
cfg.comment = 'xlim';
cfg.commentpos = 'title';
cfg.xlim = [toi_mean_trial, toi_mean_trial + 0.01 * toi_mean_trial];
cfg.layout = layout;
% cfg.marker = 'labels'; %Add electrode names in plot
cfg.fontsize = 14;
%cfg.zlim = [-5e-3 5e-3]; %Defines color axis
figure;
ft_topoplotER(cfg, avgERPdbs64_raw);
colorbar;

time_title=1000*toi_mean_trial;
title(['Topoplot at time ', num2str(time_title), ' ms']);