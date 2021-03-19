# EEC-201
## Digital Signal Processing
### Team: Broketivated Engineers

*Note: code update in progress*

**Usage:**

Make sure all files are in same directory.

Open `main.m` and run

# Speaker Recognition

Speaker Recognition is the process through which a system can 'recognize' who is speaking by using speaker-specific information that is included in speech signals. It is generally used to verify identities. There are two methods through which speaker recognition is carried out - text dependent and text independent. The text dependent speaker recognition strategy requires the speaker to provide utterances of key words or sentences, i.e. the same text is used for both training and testing. The text independent speaker recognition strategy does not rely on specific text being spoken. 

Speaker Recognition has two phases: Enrollment and Recognition. 
- Enrollment: During enrollment, the speaker's voice is recorded and a number of the voice features are extracted to create a voice print that uniquely identifies the speaker. The voice print in our project is the training data that we have been provided. 
- Recognition: During this process, the provided speaker's audio sample is compared against the created voice print and the speaker's identity is verified. The audio sample in our project is the test data that we have been provided.

In this project, we will be implementing the text dependent speaker recognition strategy by the process of feature matching techniques in which the time axes of an input speech sample and reference templates or reference models of the registered speaker are aligned and the similarities between them are then accumulated from the beginning to the end of the utterance.

# Procedure for Speaker Recognition 

<h3> Pre-processing </h3>
When dealing with sound signals, we often have to find ways to reduce noise or remove portions of the sound signal where there is nothing but silence. We use methods of pre-processing of the sound signals to carry forward these operations. 
#  
The following plot shows our raw signal without any pre-processing conducted on it:
<p align="center"> 
  <img src="https://github.com/Supova/EEC-201/blob/main/Images/speech_signal_speaker_1.PNG">
  <br><i> Figure 1: Original (Raw) Signal 1 </i>
</p>

After pre-processing the signal, we get the following signal:
<p align="center"> 
  <img src="https://github.com/Supova/EEC-201/blob/main/Images/Normalized_Silence%20removed%20sig1.PNG">
  <br><i>Figure 2: Normalized and silence removed Signal 1</i>
</p>


<h3> Feature Extraction </h3>
In this method

<h3> Feature Matching </h3>


**TEST 1:**
Play each sound file in the TRAIN folder. Can you distinguish the voices of the 11 speakers in
the database? Next play each sound in the TEST folder in a random order without looking at the
groundtruth and try to identify the speaker manually. Record what is your (human performance)
recognition rate. Use this result as a later benchmark.
* 7/11
* 5/11

**TEST 2:**
In Matlab one can play the sound file using “sound”. Record the sampling rate and compute how
many milliseconds of speech are contained in a block of 256 samples? 
* sampling rate = 12.5k Hz
* frame_duration = frame_size/fs = 256/12500 = 0.02048 m = 20.48 ms

Now plot the signal to view it in the time domain. It should be obvious that the raw data are long and may need to be normalized
because of different strengths.

<p align="center"> 
  <img src="https://github.com/Supova/EEC-201/blob/main/Images/speech_signal_speaker_1.PNG">
  <br><i> Figure 1: Original Signal 1 </i>
</p>


<p align="center"> 
  <img src="https://github.com/Supova/EEC-201/blob/main/Images/Normalized_Silence%20removed%20sig1.PNG">
  <br><i>Figure 2: Normalized and silence removed Signal 1</i>
</p>




Use STFT to generate periodogram. Locate the region in the plot that contains most of the energy, in time
(msec) and frequency (in Hz) of the input speech signal. Try different frame size: for example N = 128, 256
and 512. In each case, set the frame increment M to be about N/3.

STFT of Signal 1:

<div class="row">
  <div class="column">
    <img src="https://github.com/Supova/EEC-201/blob/main/Images/sig1%20stft_1.PNG" alt="N = 128" ">
     <br><i> Figure 3: N = 128 </i>                                                                                             
  </div>
  <div class="column">
    <img src="https://github.com/Supova/EEC-201/blob/main/Images/sig1%20stft_2.PNG" alt="N = 256" ">
    <br><i>Figure 4: N = 256</i>    
  </div>
  <div class="column">
    <img src="https://github.com/Supova/EEC-201/blob/main/Images/sig1%20stft_3.PNG" alt="N = 512" ">
    <br><i> Figure 5: N = 512</i>   
  </div>
</div>

insert EXCEL table here


**TEST 3:**
 Plot the mel-spaced filter bank responses. Compare them with theoretical responses. Compute
and plot the spectrum of a speech file before and after the mel-frequency wrapping step. Describe and
explain the impact of the melfb.m or melfbown.m program

<p align="center"> 
<img src="https://github.com/Supova/EEC-201/blob/main/Images/20%20mel%20filter%20banks.PNG">
  <br><i>Figure 6:  mel-spaced filter bank response 1</i>
</p>


<p align="center"> 
<img src="https://github.com/Supova/EEC-201/blob/main/Images/stft%20sig1_before%20Mel.PNG">
  <br><i>Figure 7:  Before Mel filter bank</i>
</p>


<p align="center"> 
<img src="https://github.com/Supova/EEC-201/blob/main/Images/sig1%20MelFreqWrap.PNG">
  <br><i>Figure 8:  After Mel-frquency wrapping</i>
</p>





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
