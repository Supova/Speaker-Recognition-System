# EEC-201
## Digital Signal Processing
### Team: Broketivated Engineers
#### Members: Aakansha Bhatt, Sadia Mahtaban

*Note: code update in progress*

* Usage: *
Make sure all files are in same directory.
run `main.m`

**TEST 1:**
Play each sound file in the TRAIN folder. Can you distinguish the voices of the 11 speakers in
the database? Next play each sound in the TEST folder in a random order without looking at the
groundtruth and try to identify the speaker manually. Record what is your (human performance)
recognition rate. Use this result as a later benchmark.
* 11/11

**TEST 2:**
In Matlab one can play the sound file using “sound”. Record the sampling rate and compute how
many milliseconds of speech are contained in a block of 256 samples? 
* sampling rate = 12.5k Hz
* frame_duration = frame_size/fs = 256/12500 = 0.02048 m = 20.48 ms

Now plot the signal to view it in the time domain. It should be obvious that the raw data are long and may need to be normalized
because of different strengths.

<p align="center"> 
<img src="https://github.com/Supova/EEC-201/blob/main/Images/speech_signal_speaker_1.PNG">
</p>
Figure 1: Original Signal 1

<p align="center"> 
<img src="https://github.com/Supova/EEC-201/blob/main/Images/Normalized_Silence%20removed%20sig1.PNG">
</p>
Figure 2: Normalized and silence removed Signal 1



Use STFT to generate periodogram. Locate the region in the plot that contains most of the energy, in time
(msec) and frequency (in Hz) of the input speech signal. Try different frame size: for example N = 128, 256
and 512. In each case, set the frame increment M to be about N/3.

STFT of Signal 1:

<div class="row">
  <div class="column">
    <img src="https://github.com/Supova/EEC-201/blob/main/Images/sig1%20N_128.PNG" alt="N = 128" ">
     Figure 3: N = 128                                                                                             
  </div>
  <div class="column">
    <img src="https://github.com/Supova/EEC-201/blob/main/Images/sig1%20N_256.PNG" alt="N = 256" ">
    Figure 4: N = 256    
  </div>
  <div class="column">
    <img src="https://github.com/Supova/EEC-201/blob/main/Images/sig1%20N_512.PNG" alt="N = 512" ">
    Figure 5: N = 512   
  </div>
</div>

insert EXCEL table here


**TEST 3:**
 Plot the mel-spaced filter bank responses. Compare them with theoretical responses. Compute
and plot the spectrum of a speech file before and after the mel-frequency wrapping step. Describe and
explain the impact of the melfb.m or melfbown.m program

<p align="center"> 
<img src="https://github.com/Supova/EEC-201/blob/main/Images/20%20mel%20filter%20banks.PNG">
</p>
Figure 6:  mel-spaced filter bank response 1

<p align="center"> 
<img src="https://github.com/Supova/EEC-201/blob/main/Images/stft%20sig1_before%20Mel.PNG">
</p>
Figure 7:  Before Mel filter bank

<p align="center"> 
<img src="https://github.com/Supova/EEC-201/blob/main/Images/sig1%20MelFreqWrap.PNG">
</p>
Figure 8:  After Mel-frquency wrapping



**TEST 4:**
**MFCC Steps:**
* Frame the signal into short overlapping frames
* Windowing: Hamming
* Discrete Fourier Transform
* Apply Filter Banks for Mel-frequency wrapping
* Get the log filterbank energies
* Discrete cosine transform

<p align="center"> 
<img src="https://github.com/Supova/EEC-201/blob/main/Images/sig1%20MFCC.PNG">
</p>


**TEST 5:**
To check whether the program is working, inspect the acoustic space (MFCC vectors) in any two
dimensions in a 2D plane to observe the results from different speakers. Are they in clusters?


<p align="center"> 
<img src="https://github.com/Supova/EEC-201/blob/main/Images/sig1%20sig2%20MFCC%20clusters.PNG">
</p>


**TEST 6:**

**TEST 7:**

**TEST 8:**

**TEST 9:**
