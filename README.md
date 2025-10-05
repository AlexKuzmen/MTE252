# MTE252
Project 1

# MTE252 Phase 1 due: 

## Task 1

Evaluation of signal:

Audio signal will be an energy signal (the audio clip will end)

- A loud short clap can have the same energy as a quiet long whisper  
- The final output will have less energy because the system will remove details from the signal, however the ratio of output to input energy should be as high as possible  
- (Input signal energy/output signal energy) \* 100% on F-A

Signal type

- Input will be an digital, discrete, **finite energy**  
- Output will be digital, discrete, **finite energy**  
- Don't want output to start oscillating or run away with positive feedback

Signal length

- The length of the output signal should be the same as the input signal  
- (input signal length / output signal length) \* 100% on F-A

Signal volume

- Average power of a signal represents the loudness  
- If input is loud/quiet, the the output should also be loud/quiet  
- Aka the system should preserve the power of the system  
- (input power / output power) \* 100% on F-A, input power \>= output power

System should be time invariant

- A time delay should only shift the signal by the delay, should not change the signal  
- It is or it isn’t YES-NO scale

Output should preserve key frequency bands

- Should be in audible range (100Hz-8kHz)  
- Should preserve pitch, be able to differentiate male vs female voice etc  
  - Test how many people are able to differentiate the following voices:  
    - Male voice  
    - Female voice  
    - Dog barking  
  - Percentage of people able to differentiate each on scale of F-A \[ask chatGPT to come up with a way to quantify this.

Output should be intelligible

- words should be intelligible in the output signal  
  - % of words understood F-A  
- Should filter out unwanted background noise  
  - Rate “noisiness” on scale F-A  
- Should be able to differentiate vowels and consonants   
  - % of vowels/constants recognized F-A

\<60% \- F  
60-70 \- D  
70 \- 80 \- C  
80 \- 90 \- B  
90-100 \- A

| Criteria | F (\<60%) | D (60-70) | C (71-80) | B (81-90) | A (91-100) | Comment |
| :---- | :---- | :---- | :---- | :---- | :---- | :---- |
| % Vowels/Constants recognized |  |  |  |  |  |  |
| % Words Understood |  |  |  |  |  |  |
| % Differentiated Voices |  |  |  |  |  |  |

At the end take a weighted average to determine a final rating. 

##   Task 2

\-10 sound files (male, female, dog: quiet to easier with vowel heavy sentences)

Audio files

- MCQ: Male voice with consonants quiet background  
- MVQ: Male voice with vowels quiet background (quiet to loud)  
- MCL: Male voice with consonants loud background  
- MVL: Male voice with vowels loud background  
- FCQ: Female voice with consonants quiet background  
- FVQ: Female voice with vowels quiet background (quiet to loud)  
- FCL: Female voice with consonants loud background  
- FVL: Female voice with vowels loud background  
- DQ: Dog barking quiet background  
- DL: Dog barking loud background

Consonant sentence:

“*Strong knights sprint swiftly through the crisp, dark forests*”

Vowel sentence:

“*I see a quiet oasis where eagles soar above a radiant, azure area*”

## Task 3 Deliverables

Git repo for matlab:   
Share your username or email or smth?: 

Task 3.5 WE NEED ALL OF THE HIGHLIGHTED AUDIOS AS GRAPHS (I used my computer to get an .m4a file which works with this code)

Task 3.7

Matlab File (Call function from another script)  
%Call this file from another script with \<"audioname.ext"\> as parameter  
%Include "audioname.ext" in the same folder as this script (add to path)  
function Task3Phase1(filename) % Tasks 3.1–3.7  
% 3.1 Get file and get sampling rate  
\[y, fs\] \= audioread(filename);  
fprintf('Sampling rate of input file: %g Hz\\n', fs);  
% 3.2 Convert to Mono if stereo (add them but also should divide by 2?)  
if size(y,2) \== 2  
   y \= (y(:,1) \+ y(:,2))/2; %averaged two columns  
end  
% 3.3 Play Mono Sound  
sound(y, fs);  
% 3.4 Write Mono Sound to a new file  
output\_file="new\_"\+filename;  
audiowrite(output\_file,y,fs); %save to folder  
fprintf('Added mono file to same folder as this matlab with same frequency: %s\\n', output\_file);  
% 3.5 Plot waveform vs sample number  
figure;  
plot(y); %already as sample number  
xlabel('Sample Number');  
ylabel('Amplitude');  
title('Waveform vs Sample Number');  
grid on;  
% 3.6 Downsample to 16 kHz only if fs \> 16 kHz  
if fs \> 16000  
   try  
       y16 \= audioresample(y, 16000, fs); %newer need to install  
   catch  
       y16 \= resample(y, 16000, fs); %may error out  
   end  
   fs16 \= 16000;  
   fprintf('Resampled to 16kHz, use \<y16\> and \<fs16\>: %g Hz\\n', fs16);  
else  
   % Per 3.6: if original fs \< 16 kHz, better to redo 3.1 with a higher-rate file  
   warning('Input fs (%g Hz) \<= 16 kHz. Skipping resample per Task 3.6 & error out.', fs);  
   quit;  
end  
% 3.7 Generate 1 kHz cosine with same duration/length; play and plot 2 cycles  
t \= (0:size(y,1)-1)/fs; %time duration equal to input signal?  
cos\_signal \= cos(1000\*2\*pi\*t); %one waveform  
% Play the cosine  
sound(cos\_signal, fs);%play sound same as input signal\! fs16 will make it sound lower  
% Plot exactly two cycles (2 ms at 1 kHz). Confusing but works as a mask,  
% not sure how else to do this more efficiently  
T \= 2/1000; %time for 2 cycles                
two\_cycles \= t \<= T; %bound it to 2/1000 seconds               
figure; plot(t(two\_cycles), cos\_signal(two\_cycles)); %accessing t @proper time  
xlabel('Time (s)');  
ylabel('Amplitude');  
title('Two Cycles of 1 kHz Cosine'); grid on;  
end

