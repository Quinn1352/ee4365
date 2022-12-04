N0= 2;% Complex Noise Avg. Power
SNR= 5;%dB 
TRIAL=170000;
error=0;
for m=1:TRIAL
%TRANSMITTER DESIGN
b=2*(rand(1,1)>0.5)-1;%bit
S=(ones(64,1)+j*ones(64,1))/sqrt(128);%Transmitter Waveform
P= N0*10^(SNR/10);%Designing power for given SNR and complex noise power (avg.)
%Output of Antenna
Tx=sqrt(P)*b*S;
%COMPLEX AWGN GENERATION
N= sqrt(N0/2)*(randn(64,1)+j*randn(64,1));
%Slow and Flat Channel
h=(randn(1,1)+j*randn(1,1))/sqrt(2);
%RECEIVED SIGNAL
Rx= h*Tx+N;
%MATCHED FILTER OUTPUT
r_mf=S'*Rx;
%COPHASING
r_tilda=(h'/abs(h))*r_mf;
%EXTRACT REAL COMPONENT FROM r_tilda
r=real(r_tilda);
%BIT DECISION
b_dec=sign(r);
%CHECKING ERROR
error=error+0.5*abs(b-b_dec);
end
%SIMULATED BER
P_s=error/TRIAL
%ANALYTICAL BER
Gamma=P/N0;%Average SNR
P_a=0.5*(1-sqrt(Gamma/(1+Gamma)))