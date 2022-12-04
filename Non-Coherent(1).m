N0= 2;% Complex Noise Variance
SNR= 5;%dB 
TRIAL=170000;
error=0;
for m=1:TRIAL
%TRANSMITTER DESIGN
b=2*(rand(1,1)>0.5)-1;%bit
S1=(ones(64,1)+j*ones(64,1))/sqrt(128);%S1 waveform for b=+1
S2=[ones(32,1)+j*ones(32,1); -ones(32,1)-j*ones(32,1),]/sqrt(128);%S2 waveform for b=-1
P= N0*10^(SNR/10);
if (b==1)
S=S1;
else
S=S2;
end
%Output of Antenna
Tx=sqrt(P)*S;
%COMPLEX AWGN GENERATION
N= sqrt(N0/2)*(randn(64,1)+j*randn(64,1));
%SLOW and Flat Fading Wireless Channel
h = (randn(1,1)+j*randn(1,1))/sqrt(2);
%RECEIVED SIGNAL
Rx= h*Tx+N;

%MATCHED FILTER OUTPUT1
r1=S1'*Rx;
%MATCHED FILTER OUTPUT2
r2=S2'*Rx;
%BIT DECISION
if(abs(r1)>abs(r2))
b_dec=+1;
else
b_dec=-1;
end
%CHECKING ERROR
error=error+0.5*abs(b-b_dec);
end
%SIMULATED BER
P_s=error/TRIAL
%ANALYTICAL BER
Gamma= P/N0;
P_a= 1/(2+Gamma)
