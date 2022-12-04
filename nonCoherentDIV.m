%Assumption
N0= 2;% Complex Noise Variance
SNR= 5;%dB 
TRIAL=10000;
error=0;
for m=1:TRIAL
%TRANSMITTER DESIGN
b=2*(rand(1,1)>0.5)-1;%bit
S1=(ones(64,1)+j*ones(64,1))/sqrt(128);%For b = +1
%Generating S2
s=[ones(32,1);-ones(32,1)];

S2=(s+j*s)/sqrt(128);%For b = -1
P= N0*10^(SNR/10);
%Output of Antenna
if (b==1)
Tx=sqrt(P)*S1;
else
Tx=sqrt(P)*S2;   
end
%COMPLEX AWGN GENERATION at Antenna 1
N1 = sqrt(N0/2)*(randn(64,1)+j*randn(64,1));
%COMPLEX AWGN GENERATION at Antenna 1
N2 = sqrt(N0/2)*(randn(64,1)+j*randn(64,1));

%CHANNEL GENERATION for Antenna 1
Ch1=(randn(1,1)+j*randn(1,1))/sqrt(2);
%CHANNEL GENERATION for Antenna 2
Ch2=(randn(1,1)+j*randn(1,1))/sqrt(2);

%RECEIVED SIGNAL at Antenna 1
Rx1= Ch1*Tx+N1;
%RECEIVED SIGNAL at Antenna 2
Rx2= Ch2*Tx+N2;

%MATCHED FILTER 1 OUTPUT at Antenna 1
r11=S1'*Rx1; 
%MATCHED FILTER 2 OUTPUT at Antenna 1
r12=S2'*Rx1;

%MATCHED FILTER 1 OUTPUT at Antenna 2
r21=S1'*Rx2;
%MATCHED FILTER 2 OUTPUT at Antenna 2
r22=S2'*Rx2;

%Estimating power
P1= (r11)'*r11+ (r21)'*r21; %If b= +1, P1 = power of signal + noise power
P2= (r12)'*r12+ (r22)'*r22; %If b= -1, P2 = power of signal + noise power


%BIT DECISION
if (abs(P1)>abs(P2))
b_dec=1;
else
b_dec=-1;
end
%CHECKING ERROR
error=error+0.5*abs(b-b_dec);
end
%SIMULATED BER
P_s=error/TRIAL

