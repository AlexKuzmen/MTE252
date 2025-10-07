%Call this file from another script with <"audioname.ext"> as parameter
%Include "audioname.ext" in the same folder as this script (add to path)
function T3P1(filename) % Tasks 3.1–3.7

% 3.1 Get file and get sampling rate
[y, fs] = audioread(filename);
fprintf('Sampling rate of input file: %g Hz\n', fs);

% 3.2 Convert to Mono if stereo (add them but also should divide by 2?)
if size(y,2) == 2
    y = (y(:,1) + y(:,2))/2; %averaged two columns
end

% 3.3 Play Mono Sound
sound(y, fs);

% 3.4 Write Mono Sound to a new file
output_file="new_"+filename;
audiowrite(output_file,y,fs); %save to folder
fprintf('Added mono file to same folder as this matlab with same frequency: %s\n', output_file);

% 3.5 Plot waveform vs sample number
figure; 
plot(y); %already as sample number
xlabel('Sample Number'); 
ylabel('Amplitude');
title('Waveform vs Sample Number'); 
grid on;

% 3.6 Downsample to 16 kHz only if fs > 16 kHz
if fs > 16000
    try
        y16 = resample(y, 16000, fs); %newer need to install
    catch
        y16 = audioresample(y, 16000, fs); %may error out
    end
    fs16 = 16000;
    fprintf('Resampled to 16kHz, use <y16> and <fs16>: %g Hz\n', fs16);
else
    % Per 3.6: if original fs < 16 kHz, better to redo 3.1 with a higher-rate file
    warning('Input fs (%g Hz) <= 16 kHz. Skipping resample per Task 3.6 & error out.', fs);
    quit;
end

% 3.7 Generate 1 kHz cosine with same duration/length; play and plot 2 cycles
t = (0:size(y,1)-1)/fs; %time duration equal to input signal?
cos_signal = cos(1000*2*pi*t); %one waveform

% Play the cosine
sound(cos_signal, fs);%play sound same as input signal! fs16 will make it sound lower and longer

% Plot exactly two cycles (2 ms at 1 kHz). Confusing but works as a mask,
% not sure how else to do this more efficiently
T = 2/1000; %time for 2 cycles               
two_cycles = t <= T; %bound it to 2/1000 seconds              
figure; plot(t(two_cycles), cos_signal(two_cycles)); %accessing t @proper time
xlabel('Time (s)'); 
ylabel('Amplitude');
title('Two Cycles of 1 kHz Cosine'); grid on;

end

T3P1("Recording.m4a"); %input string filename
