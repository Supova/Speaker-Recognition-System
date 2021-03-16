# EEC-201
Digital Signal Processing


Detailed Submission Guideline: 

Part (a) 1st Github (12:00noon March 16th); (Part b) 1st draft report (11:59PM March 18th); (Part c): Everything (11:59PM March 20th)

(a) Each group need to prepare a github project which contains

Dataset used
Your own computer program and clear instructions how to execute the program;
Separate demonstration (tests) and resutls as required in the final project description. 
1st Github link needs to be submitted by Tuesday 12noon March 16th that contains preliminary works (submit by text on the same final project assignment text entry). 

(b) Each group need to prepare a group report as required 

The report must be accessible at Github
The report must explains in detail your approaches, your tests, your results, AND your unique efforts
The 1st draft of the group report must be submit by Thursday 11:59PM. (Submit by text on the same final project assignment text entry on link to the Github file as 1st report draft). 

(c) Each group must prepare a video presentation of 12-15 minutes to explain the project (coupled with the project report) 

The video must be in mp4 format and may be recorded using zoom, quicktime, or any software.
Both members must be present and both should discuss their works and contributions. 
The video needs to be submitted as a link on Github at the final deadline (11:59PM) March 20th. (Submit by text on the same final project assignment text entry on link to the Github video file).  


TEST 1:

TEST 2:
In Matlab one can play the sound file using “sound”. Record the sampling rate and compute how
many milliseconds of speech are contained in a block of 256 samples? 
sampling rate = 12.5k Hz
frame_duration = frame_size/fs = 256/12500 = 0.02048 m = 20.48 ms

Now plot the signal to view it in the time domain. It should be obvious that the raw data are long and may need to be normalized
because of different strengths.

<p align="center"> 
<img src="https://github.com/Supova/EEC-201/blob/main/Images/speech_signal_speaker_1.PNG">
 <em>Figure _: Original Signal 1</em>
</p>



Use STFT to generate periodogram. Locate the region in the plot that contains most of the energy, in time
(msec) and frequency (in Hz) of the input speech signal. Try different frame size: for example N = 128, 256
and 512. In each case, set the frame increment M to be about N/3.

insert EXCEL table here


TEST 3:
 Plot the mel-spaced filter bank responses. Compare them with theoretical responses. Compute
and plot the spectrum of a speech file before and after the mel-frequency wrapping step. Describe and
explain the impact of the melfb.m or melfbown.m program

<p align="center"> 
<img src="https://github.com/Supova/EEC-201/blob/main/Images/20%20mel%20filter%20banks.PNG">
 Figure _:  mel-spaced filter bank response 1
</p>







TEST 4:

TEST 5:

TEST 6:

TEST 7:

TEST 8:

TEST 9:
