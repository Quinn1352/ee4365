N0= 2;% Complex Noise Avg. Power
SNR= 5;%dB 
K= 4;%Ricean Factor which 6 in dB
A= sqrt(0.8); %Peak amplitude of LoS, see slides
              %80% power is contributed by LoS, thus amplitude 
              %A=sqrt(0.8)
sigma_ch = sqrt(0.1); % 20% power is contributed by NLoS, thus  2sigma_ch^2=0.2

TRIAL=1700000;
error_sys=0;%For system simulation
error_q=0;%Accumulate Ins. BER
for m=1:TRIAL
%TRANSMITTER DESIGN
b=2*(rand(1,1)>0.5)-1;%bit
S=(ones(64,1)+j*ones(64,1))/sqrt(128);%Transmitter Waveform
P= N0*10^(SNR/10);%Designing power for given SNR and complex noise power (avg.)
%Output of Antenna
Tx=sqrt(P)*b*S;
%COMPLEX AWGN GENERATION
N= sqrt(N0/2)*(randn(64,1)+j*randn(64,1));
%Slow and Flat Ricean Channel
X = sigma_ch*randn(1,1)+A*cos(pi/3); 
Y = sigma_ch*randn(1,1)+A*sin(pi/3); 
h=X+j*Y;% Ricean Channel with average power 1, where K=6 dB
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
error_sys=error_sys+0.5*abs(b-b_dec);%Accumulating Bit Errors
error_q= error_q+qfunc(sqrt((abs(h)^2*2*P/N0))); %Accumulate Ins. BER from Ch
end
%Average BER from System Simulation
P_sys=error_sys/TRIAL
%Average BER from Ins. BER Simulation
P_q=error_q/TRIAL
%Analytical BER
P_a=0.5*erfc(sqrt(K*(P/N0)/(K+P/N0)))