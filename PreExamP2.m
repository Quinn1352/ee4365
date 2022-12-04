clear
close all
clc

N0= 2;% Complex Noise Avg. Power
SNR= -5:1:15;%dB 
KdB= 15;%Ricean Factor
K = 31.6; % = 10^(Kdb / 10);
A= sqrt(K / (K+1)); %solution to A^2 + 2sigma^2 = 1 and K = A^2/2simga^2
sigma_ch = sqrt(1/(2*K)); 

TRIAL=20000;
for k = 1:length(SNR)

    error_sys=0;%For system simulation
    for m=1:TRIAL
        %TRANSMITTER DESIGN
        b=2*(rand(1,1)>0.5)-1;%bit
        P= N0*10.^(SNR/10);%Designing power for given SNR and complex noise power (avg.)
        S1=(ones(64,1)+j*ones(64,1))/sqrt(128);%S1 waveform for b=+1
        S2=[ones(32,1)+j*ones(32,1); -ones(32,1)-j*ones(32,1),]/sqrt(128);%S2 waveform for b=-1
        if (b==1)
            S=S1;
        else
            S=S2;
        end
        
        %Output of Antenna
        Tx=sqrt(P(k)).*S;
        %COMPLEX AWGN GENERATION
        N= sqrt(N0/2)*(randn(64,1)+j*randn(64,1));
        %Slow and Flat Ricean Channel
        X = sigma_ch*randn(1,1)+A*cos(pi/3); 
        Y = sigma_ch*randn(1,1)+A*sin(pi/3); 
        h=X+j*Y;
        %RECEIVED SIGNAL
        Rx= h*Tx+N;
        %MATCHED FILTER OUTPUTs
        r1=S1'*Rx;
        r2=S2'*Rx;
        %BIT DECISION
        b_dec = abs(r1) - abs(r2);
        b_dec = sign(b_dec);
        %if(abs(r1)>abs(r2))
        %b_dec=+1;
        %else
        %b_dec=-1;
        %end
        %CHECKING ERROR
        error_sys=error_sys+0.5*abs(b-b_dec);%Accumulating Bit Errors

        
    end
    P_sys(k)=error_sys/TRIAL;
    
    Gamma = P(k)/N0;%Average SNR
    C = (1+K)/(2+2*K+Gamma);
    D = (K*Gamma)/(2+2*K+Gamma);
    P_a(k) = C*exp(-D); %BER_a(k) will store analytical BER for SNR(k)

end


%Average BER from System Simulation
figure('Name', 'Problem  part 1')
plot(SNR, P_sys)
grid on
xlabel('SNR')
ylabel('BER')

%Average BER from Ins. BER Simulation
figure('Name', 'Problem 2 part 2')
plot(SNR, P_a)
grid on
xlabel('SNR')
ylabel('BER')

%Analytical BER
