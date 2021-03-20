# EEC-201 [Speaker Recognition]
<a name="jump_to_top"></a>
<p align="center"><i>♪ All around me were familiar faces..but now they are familiar voices...♫</i></p>
<img src=https://www.civitaslearning.com/wp-content/uploads/2017/10/cls_signal.jpg width="1000" height="200">

### Team: Broketivated Engineers
*This project was undertaken by Aakansha and Sadia in a collaborative effort to implement speaker recognition using MFCC, VQ, and LBG algorithm. Sadia has worked on pre-procressing and MFCC. Aakansha has worked on LBG and noise addition. Training, testing, and analysis writing was done simultaneously.*

## Abstract 
In the current world situation with a pandemic and quarantine, our voices have become ever more important, literally. There is deceased identity verification through face to face or through finger prints due to communication being restricted to mostly virtual. However, just as our faces and finger prints are unique, our voices also have distinct and differentiable characteristics. Computer programs are able to identify these features better than the human ear as demonstrated in our project. We implement a speaker recognition system using pattern recognition, or feature matching, where sequences of acoustic vectors that are extracted from input speech signals are classified into individual speaker IDs. Specifically, our system is an implementation of supervised pattern recognition where the database consists of known patterns in the training set which are compared to a test set to evaluate our classification algorithm. The recognition rate of our algorithm is ___%.


## Introduction
There are two methods through which speaker recognition is carried out - text dependent and text independent. The text dependent speaker recognition strategy requires the speaker to provide utterances of key words or sentences, i.e. the same text is used for both training and testing. The text independent speaker recognition strategy does not rely on specific text being spoken. 

Speaker Recognition has two phases: Enrollment and Recognition. 
- Enrollment: During enrollment, the speaker's voice is recorded and a number of the voice features are extracted to create a voice print that uniquely identifies the speaker. The voice print in our project is the training data that we have been provided. 
- Recognition: During this process, the provided speaker's audio sample is compared against the created voice print and the speaker's identity is verified. The audio sample in our project is the test data that we have been provided.

In this project, we will be implementing the text dependent speaker recognition strategy by the process of feature matching techniques described below. Our obejctive is to train a voice model for each of the 11 speakers in the *Training* folder and then match them to the speech files in the *Test* folder. We will vary the paramters and add noise to test the robustness of our system.

## Methodology 

<h3> Pre-processing </h3>

When dealing with speech signals, we often have to find ways to reduce noise or remove portions of the signal where there is nothing but silence. We use methods of pre-processing of the speech signals to carry forward these operations. 
<br> </br>
The following plot shows our raw signal without any pre-processing conducted on it:
<p align="center"> 
  <img src="https://github.com/Supova/EEC-201/blob/main/Images/speech_signal_speaker_1.PNG">
  <br><i> Figure 1: Original (Raw) Signal 1 </i>
</p>

After pre-processing the signal, we get the following signal:
<p align="center"> 
  <img src="https://github.com/Supova/EEC-201/blob/main/Images/Normalized_Silence%20removed%20sig1.PNG">
  <br><i>Figure 2: Normalized and Silence Removed Signal 1</i>
</p>

<h3> Feature Extraction </h3>

Speech signals are slowly-timed varying signals and when we observe their characteristics over a long period of time, we find that they contain variations that can help distinguish between the different sounds being spoken. Therefore, a short-time spectral analysis is the most common way to characterize any speech signal. One way of representing the speech signal is by using the phenomenon called Mel Frequency Cepstrum (MFC). It is a representation of the short-term power spectrum of a speech signal, based on a linear cosine transform of a log power spectrum on a nonlinear mel scale of frequency. Mel-frequency cepstral coefficients (MFCCs) are coefficients that collectively make up an MFC.

To compute the MFCCs, we first perform a short-time fourier transform (STFT) on our speech signal. We then perform windowing to minimize any spectral distortion we may observe. The STFT is mainly used to distinguish the changes in frequencies of our speech signal through time to create uniqueness across speakers. The generated periodogram can be viewed in the images below. We can observe regions in the plots that contain most of the energy, in time (msec) and frequency (in Hz).
<br> </br>
STFT of Signal 1:

<div class="row" align="center">
  <div class="column">
    <img src="https://github.com/Supova/EEC-201/blob/main/Images/sig1%20stft_1.PNG" alt="N = 128" ">
     <br><i> Figure 3: N (frame size) = 128 </i>
  </div>
  <br> </br>
  <div class="column">
    <img src="https://github.com/Supova/EEC-201/blob/main/Images/sig1%20stft_2.PNG" alt="N = 256" ">
    <br><i>Figure 4: N (frame size) = 256 </i>    
  </div>
  <br> </br>                                                                                          
  <div class="column">
    <img src="https://github.com/Supova/EEC-201/blob/main/Images/sig1%20stft_3.PNG" alt="N = 512" ">
    <br><i> Figure 5: N (frame size) = 512 </i>   
  </div>
  <br> </br>
</div>

After performing the FFT, the next step is to carry out mel-frequency wrapping. In this process, we simulate a subjective spectrum by creating a filter bank which is spaced uniformly on the mel-scale. The mel-frequency scale is a linear frequency spacing below 1000 Hz and a logarithmic spacing above 1000 Hz. We create this spectrum because speech signals do not follow a linear scale, and hence for each tone with an actual frequency, f, a subjective pitch is to be measured and determined. 
<br> </br>

The mel-spaced filter bank response is plotted in the image below:

<p align="center"> 
<img src="https://github.com/Supova/EEC-201/blob/main/Images/20%20mel%20filter%20banks.PNG">
  <br><i>Figure 6:  Mel filter bank response 1</i>
</p>
<br> </br>

We also computed the spectrum of the speech signal before and after the mel-frequency wrapping step is carried out and our observations are shown below: 

<p align="center"> 
<img src="https://github.com/Supova/EEC-201/blob/main/Images/stft%20sig1_before%20Mel.PNG">
  <br><i>Figure 7:  Before mel-frequency wrapping</i>
</p>
<br> </br>
<p align="center"> 
<img src="https://github.com/Supova/EEC-201/blob/main/Images/sig1%20MelFreqWrap.PNG">
  <br><i>Figure 8:  After mel-frquency wrapping</i>
</p>
<br> </br>

As can be seen from the above images, the mel filter bank smooths out the original spectogram to better represent the sound. 

After carrying out the wrapping, we then wish to convert our speech signal back into the time domain, hence creating coefficients in time called the mel frequency cepstrum coefficients (MFCCs). We use the discrete cosine transform (DCT) to do the same and extract 14 coefficients for each time instance. Over here, we exclude the first component from the DCT since it represents the mean value of the input signal, which contains little speaker specific information, hence only extracting coefficients 2-14 (13 coefficients in total). Hence, each voice utterance has been transformed into a sequence of acoustic vectors. 

In the image below, we inspect the acoustic space (MFCC vectors) of two different speakers (speaker 1 and 2) in a 2D plane to observe the different features of the speech signals.

<p align="center"> 
<img src="https://github.com/Supova/EEC-201/blob/main/Images/mfcc5_6%20speaker1_2.PNG">
<br><i> Figure 9: MFCC space for speaker 1 and speaker 2 </i>
</p>

<h3> Feature Matching </h3>

The next step in the speaker recognition process is using applying vector quantization (VQ) and the Linde-Buze-Gray (LBG) algorithm. VQ is a quantization process of data in contiguous blocks known as vectors. Quantization maps these infinite vectors into finite representative vectors. There are several techniques for quantization and the efficiency of these steps is reliant upon the generated codebooks by the training set of speech signals. Our method uses LBG algorithm to iteratively form the codebooks. First, a finite number of regions known as clusters are generated from the MFCCs. Then we partition these clusters into non-overlapping regions where every vector is represented by a corresponding centroid vector known as the code word. The code words are then grouped together to form a codebook.

The recursive process of the LBG algorithm used is as follows. First a single-vector codebook, the centroid for all training vectors, is initialized. Next the size of the codebook is doubled by splitting each current codebook by adding or subtracting epsilon, the percentage of splitting. Then for each of the training vectors, the closest codeword in the current codebook is found so the vectors can be assigned to the corresponding cell associated with the closest centroid.  Finally the codeword in each cell is updated using the centroid of training vectors assigned to that cell. The iterative process of nearest-neighbor search and centroid update is repeated until the average distance between the training vectors and centroids falls below a preset threshold. Furthermore, the iteration from the doubling of the size of the codebook step to centroid update is repeated until a preset codebook size is designed. Then the loop breaks once this condition is achieved.

Below is our image of our acoustic vectors after implementing the vector quantization.

<p align="center"> 
<img src="https://github.com/Supova/EEC-201/blob/main/Images/VQ%20acoustic%20vector%20codeblocks.PNG">
<br><i> Figure 10: MFCC space with centroids after VQ </i>
</p>

<h3> Testing </h3>

The final step for our speaker recognition system is the verification. As previously mentioned, we were given two data sets - test and train - and we have to ensure that the test data and the train data match by running the test data through all of our train data until the exact same speech signal is found. We tabulated our matching results in the image below to show that our speaker recognition can recognize and verify whether two speech signals are matching. 

**compare with human rate here**

<p align="center"> 
<img src="https://github.com/Supova/EEC-201/blob/main/Images/results.PNG">
<br><i> Figure 11: Matching </i>
</p>

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


###### Remarks:
The computational time and space complexity of our code can be improved by combining functions and processes. By using an user-defined STFT function, the preprocessing can effectively be done after the framing within this step. More efficient algorithms for silence and noise removal can be implemented for flexibility of the system.
[Go to top](#jump_to_top)
       
