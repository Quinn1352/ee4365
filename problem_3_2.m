clc
clearvars
close all

N0 = 2; %%%%%% Write Complex Noise Variance in dB %%%%%%
SNR = 0:10; %%%%%% Write SNRs in dB %%%%%%
TRIAL = 10000;

%Signal power calculation
P = N0*10.^(SNR/10);

%Initializing BER vectors
BER_s = zeros(1,length(SNR));
BER_a = zeros(1,length(SNR));

%Ricean channel parameters
K = 15; %%%%%% Write K value in dB %%%%%%
K = 10^(K/10); % Converting Ricean Factor in linear scale
A = sqrt(K/(1+K)); %Peak amplitude of LoS, see slides
sigma_ch = sqrt(1/(2*(1+K))); %Will be used for NLoS Ch.

%TRANSMITTER DESIGN
S1 = (rand(64,1) + 1i*rand(64,1))/sqrt(128); %S1 waveform for b=+1
S2 = [rand(32,1) + 1i*rand(32,1); -rand(32,1)-1i*rand(32,1)]/sqrt(128); %S2 waveform for b=-1

for k = 1:length(SNR)
    
    error=0;
    
    for m = 1:TRIAL
        
        b = 2*(rand(1,1)>0.5)-1;%bit
        if(b == 1)
            S = S1;%b=+1
        else
            S = S2;%b=-1
        end
        
        %Output of Antenna
        Tx = sqrt(P(k))*S;
        
        %COMPLEX AWGN GENERATION
        N = sqrt(N0/2)*(randn(64,1) + 1i*randn(64,1));
        
        %Slow and Flat Ricean Channel
        X = sigma_ch*randn(1,1) + A*cos(pi/3); 
        Y = sigma_ch*randn(1,1) + A*sin(pi/3);
        
        h = X + 1i*Y;% Ricean Channel with average power 1
        
        %RECEIVED SIGNAL
        Rx = h*Tx + N;
        
        %MATCHED FILTER OUTPUT 1
        r_mf1 = S1'*Rx;
        
        %MATCHED FILTER OUTPUT 2
        r_mf2 = S2'*Rx;
        
        %BIT DECISION
        if (abs(r_mf1)>abs(r_mf2))
            b_dec = +1;
        else
            b_dec = -1;
        end
        
        %CHECKING ERROR
        error = error + 0.5*abs(b-b_dec);
    end
    
    %SIMULATED BER
    BER_s(k) = error/TRIAL; %P_s(k) will store SIM. BER for SNR(k)
    
    %ANALYTICAL BER
    Gamma = P(k)/N0;%Average SNR
    C = (1+K)/(2+2*K+Gamma);
    D = (K*Gamma)/(2+2*K+Gamma);
    BER_a(k) = C*exp(-D); %BER_a(k) will store analytical BER for SNR(k)
    
end


%%%%%% Plot BERs here %%%%%%
semilogy(SNR, BER_s, SNR, BER_a)



