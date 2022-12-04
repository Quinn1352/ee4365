N0= 2;% Complex Noise Variance
SNR= 5;%dB 
TRIAL=170000;
error=0;
for m=1:TRIAL
%TRANSMITTER DESIGN
b=2*(rand(1,1)>0.5)-1;%bit
S=(ones(64,1)+j*ones(64,1))/sqrt(128);
P= N0*10^(SNR/10);
%Output of Antenna
Tx=sqrt(P)*b*S;
%COMPLEX AWGN GENERATION
N= sqrt(N0/2)*(randn(64,1)+j*randn(64,1));
%RECEIVED SIGNAL
Rx= Tx+N;
%MATCHED FILTER OUTPUT
r_mf=S'*Rx;
%EXTRACT REAL COMPONENT FROM r_mf
r=real(r_mf);
%BIT DECISION
b_dec=sign(r);
%CHECKING ERROR
error=error+0.5*abs(b-b_dec);
end
%SIMULATED BER
P_s=error/TRIAL
%ANALYTICAL BER
P_a=qfunc(sqrt(2*P/N0))