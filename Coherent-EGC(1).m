N0= 2;% Complex Noise Avg. Power
SNR= 5;%dB 
TRIAL=170000;
error=0;
for m=1:TRIAL
%TRANSMITTER DESIGN
b=2*(rand(1,1)<0.5)-1;%bit
S=(ones(64,1)+j*ones(64,1))/sqrt(128);%Transmitter Waveform
P= N0*10^(SNR/10);%Designing power for given SNR and complex noise power (avg.)
%Output of Antenna
Tx=sqrt(P)*b*S;

%COMPLEX AWGN GENERATION
N1= sqrt(N0/2)*(randn(64,1)+j*randn(64,1));% Receiver 1
N2= sqrt(N0/2)*(randn(64,1)+j*randn(64,1));% Receiver 2
%Slow and Flat Channel
h1=(randn(1,1)+j*randn(1,1))/sqrt(2);%Channel 1
h2=(randn(1,1)+j*randn(1,1))/sqrt(2);%Channel 2
%RECEIVED SIGNAL
Rx1= h1*Tx+N1;%Receiver 1
Rx2= h2*Tx+N2;%Receiver 2

%MATCHED FILTER OUTPUT
r_mf1=S'*Rx1;%Receiver 1
r_mf2=S'*Rx2;%Receiver 2 

%COPHASING
r_tilda1=(h1'/abs(h1))*r_mf1; %Receiver 1
r_tilda2=(h2'/abs(h2))*r_mf2; %Receiver 2

%EXTRACT REAL COMPONENT FROM r_tilda
r1=real(r_tilda1); %Receiver 1
r2=real(r_tilda2); %Receiver 2

%EGC BIT DECISION 
r =1*r1 +1*r2;  % Rule EGC
egc_b_dec=sign(r);

%CHECKING & ACCUMULATING ERROR
error=error+0.5*abs(b-b_dec);
end
%SIMULATED BER
P_MRC=error/TRIAL
