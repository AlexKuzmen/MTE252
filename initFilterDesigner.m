function Hd = initFilterDesigner
% Butterworth Bandpass filter designed using FDESIGN.BANDPASS.

% All frequency values are in Hz.
Fs = 16000;  % Sampling Frequency

Fstop1 = 400;         % First Stopband Frequency
Fpass1 = 450;         % First Passband Frequency
Fpass2 = 550;         % Second Passband Frequency
Fstop2 = 600;         % Second Stopband Frequency
Astop1 = 60;          % First Stopband Attenuation (dB)
Apass  = 1;           % Passband Ripple (dB)
Astop2 = 80;          % Second Stopband Attenuation (dB)
match  = 'stopband';  % Band to match exactly

% Construct an FDESIGN object and call its BUTTER method. DT Filter Object
h  = fdesign.bandpass(Fstop1, Fpass1, Fpass2, Fstop2, Astop1, Apass, Astop2, Fs);
Hd = design(h, 'butter', 'MatchExactly', match);

