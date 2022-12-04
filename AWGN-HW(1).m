%Given Parameter
SNR = 1:10;%in dB
%Parameter of Choice
N0= 2;% Complex Noise Variance
Trial= 100000; %Number of transmitted bits
BER_s=0*SNR;
BER_t=0*SNR;
for l = 1:length(SNR); %in dB
error=0;
for m = 1:Trial
%TRANSMITTER DESIGN
b=2*(rand(1,1)>0.5)-1;%bit
S=(ones(64,1)+j*ones(64,1))/sqrt(128);
P= N0*10^(SNR(l)/10);
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
BER_s(l)=error/Trial;
BER_t(l)=qfunc(sqrt(2*P/N0));
end
semilogy(SNR,BER_s,'*',SNR,BER_t,'-')
xlabel('SNR (dB)')
ylabel('BER')
legend('Simulated BER','Theoretical BER')