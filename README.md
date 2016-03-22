#####Heart Rate Variability (HRV), RR-interval and Spectral analysis of Electrocardiogram (ECG) 
Unevenly spaced signals are met commonly in car industry, communications, medicine and other sciences. In our case, the raw ECG signal
is usually unevenly sampled. Heart-rate variability (HRV) signals, which represent the physiological 
variation in time between heartbeats, are typically unevenly sampled because human heart rates are not constant.

#####Dependencies
* Matlab
* Signal Processing Toolbox

#####RR Intervals
We load our signal in Matlab and perform low or high-pass filtering in order to rule out artifacts. 
The filtered signal is presented below.
![PICTURE](https://github.com/sdimi/HRV-of-ECG/blob/master/filtered.png)

Then, we find the peaks of the ECG. The amplitude of each point is computed as the inverse of the time difference 
between consecutive R-Peaks and is placed at the instant of the second R-Peak.


```Matlab
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
```
![PICTURE](https://github.com/sdimi/HRV-of-ECG/blob/master/hrv.png)

We notice that the average heart rate variability is around 1.4, perhaps a sign of arrythmia in our signal.
In order to visualize the HRV values better, we plot the RLocsInterval histogram. 
```Matlab
% Find sampling interval
figure
hist(RLocsInterval)
grid
xlabel('Sampling interval (s)')
ylabel('RR distribution')
```
![PICTURE](https://github.com/sdimi/HRV-of-ECG/blob/master/sampling%20interval.png)

In an ideally perfect result, the sampling intervals of all
distributions should have only one value, (equidistant RRs).
Here we see 8 different intervals on the axis x.

#####Spectral Analysis
The typical frequency bands of interest in HRV spectra are:

* Very Low Frequency (VLF) (3.3 - 40 mHz)
* Low Frequency (LF)  (40 to 150 mHz)
* High Frequency (HF) (150 to 400 mHz)

These bands approximately confine the frequency ranges 
of the distinct biological regulatory mechanisms that 
contribute to HRV. Fluctuations in any of these bands have biological significance.

We use the [Lomb–Scargle periodogram](https://en.wikipedia.org/wiki/Least-squares_spectral_analysis#The_Lomb.E2.80.93Scargle_periodogram) to 
calculate the spectrum of the HRV signal. In Matlab, we call ``` plomb ```.

```Matlab
% Lomb-Scargle Spectral Density Estimate
figure
plomb(HRV,tHRV,'Pd',[0.95, 0.5])
```
![PICTURE](https://github.com/sdimi/HRV-of-ECG/blob/master/plomb.png)

The dashed lines denote 95% and 50% detection probabilities (Pd). 
These thresholds measure the statistical significance of peaks. 
The spectrum shows peaks in all 3 bands of interest listed above.
However, only the peak located at **74.5 mHz** in the LF range shows a detection
probability **95%**, while only the peak at **231 mHz** has a detection probability of **50%** in the HF range. 


