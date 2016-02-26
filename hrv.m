% Load the signal
load('ecg.mat')

% Find the ECG peaks
[pks,locs] = findpeaks(x,2048, ...
'MinPeakProminence',0.3,'MinPeakHeight',0.2);

% Determine the RR intervals
RLocsInterval = diff(locs);

% Derive the HRV signal
tHRV = locs(2:end);
HRV = 1./RLocsInterval;

% Plot the signal
plot(tHRV,HRV,'LineWidth',4)
xlabel('Time(s)')
ylabel('HRV (Hz)')

% Find sampling interval
figure
hist(RLocsInterval)
grid
xlabel('Sampling interval (s)')
ylabel('RR distribution')


% Lomb-Scargle Spectral Density Estimate
figure
plomb(HRV,tHRV,'Pd',[0.95, 0.5])
