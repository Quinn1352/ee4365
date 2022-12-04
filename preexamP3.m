clear
close all
clc

N0= 2;% Complex Noise Avg. Power
SNR= 5;%dB 
TRIAL=200000;
error_egc=0;
error_mrc = 0;
error_noncoher = 0;
error_sel = 0;

for m=1:TRIAL
    %TRANSMITTER DESIGN
    b=2*(rand(1,1)<0.5)-1;%bit
    S=(ones(64,1)+j*ones(64,1))/sqrt(128);%Transmitter Waveform
    P= N0*10^(SNR/10);%Designing power for given SNR and complex noise power (avg.)
    %Output of Antenna for coherent
    Tx=sqrt(P)*b*S;

    %COMPLEX AWGN GENERATION
    N1= sqrt(N0/2)*(randn(64,1)+j*randn(64,1));% Receiver 1
    N2= sqrt(N0/2)*(randn(64,1)+j*randn(64,1));% Receiver 2
    %Slow and Flat Channel
    h1=(randn(1,1)+j*randn(1,1))/sqrt(2);%Channel 1
    h2=(randn(1,1)+j*randn(1,1))/sqrt(2);%Channel 2
    %COHERENT RECEIVED SIGNAL
    Rx1= h1*Tx+N1;%Receiver 1
    Rx2= h2*Tx+N2;%Receiver 2

    %COHERENT MATCHED FILTER OUTPUT
    r_mf1=S'*Rx1;%Receiver 1
    r_mf2=S'*Rx2;%Receiver 2 
  
    %COPHASING
    r_tilda1=(h1'/abs(h1))*r_mf1; %Receiver 1
    r_tilda2=(h2'/abs(h2))*r_mf2; %Receiver 2
    
    %EXTRACT REAL COMPONENT FROM r_tilda
    r1=real(r_tilda1); %Receiver 1
    r2=real(r_tilda2); %Receiver 2

    %%%%%%%%%%%% NON COHERENT TX and RX %%%%%%%%%%%%%%%%%%
    %NON COHERENT CHANNELS
    S1=(ones(64,1)+j*ones(64,1))/sqrt(128);%For b = +1
    %Generating S2
    s=[ones(32,1);-ones(32,1)];
    S2=(s+j*s)/sqrt(128);%For b = -1
    P= N0*10^(SNR/10);
    %Output of Antenna
    if (b==1)
        Tx_noncoh=sqrt(P)*S1;
    else
        Tx_noncoh=sqrt(P)*S2;   
    end

    %NONCOHERENT RECEIVED SIGNAL
    Rx1_noncoh= h1*Tx_noncoh+N1;%Receiver 1
    Rx2_noncoh= h2*Tx_noncoh+N2;%Receiver 2

    %NON COHERENT MATCHED FILTER OUTPUT
    %MATCHED FILTER 1 OUTPUT at Antenna 1
    r11=S1'*Rx1_noncoh; 
    %MATCHED FILTER 2 OUTPUT at Antenna 1
    r12=S2'*Rx1_noncoh;
    
    %MATCHED FILTER 1 OUTPUT at Antenna 2
    r21=S1'*Rx2_noncoh;
    %MATCHED FILTER 2 OUTPUT at Antenna 2
    r22=S2'*Rx2_noncoh;
    
    %Estimating power
    P1= (r11)'*r11+ (r21)'*r21; %If b= +1, P1 = power of signal + noise power
    P2= (r12)'*r12+ (r22)'*r22; %If b= -1, P2 = power of signal + noise power


    %%%%%%%%%%% BIT DECISIONS %%%%%%%%%%%%%%%%%

    %EGC BIT DECISION 
    egc_r =1*r1 +1*r2;  % Rule EGC
    egc_b_dec=sign(egc_r);

    %MRC BIT DECISION
    mrc_r =abs(h1)*r1 +abs(h2)*r2;  % Rule MRC
    mrc_b_dec=sign(mrc_r);

    %SEL BIT DECISION
    if(abs(h1)>abs(h2))
        sel_b_dec = sign(r1);
    else
        sel_b_dec = sign(r2);
    end

    %NON COHERENT BIT DECISION
    if (abs(P1)>abs(P2))
        noncoher_b_dec=1;
    else
        noncoher_b_dec=-1;
    end



    %CHECKING & ACCUMULATING ERROR
    error_egc = error_egc+0.5*abs(b-egc_b_dec);
    error_mrc = error_mrc+0.5*abs(b-mrc_b_dec);
    error_noncoher = error_noncoher+0.5*abs(b-noncoher_b_dec);
    error_sel = error_sel+0.5*abs(b-sel_b_dec);
    
end
%SIMULATED BER
P_EGC = error_egc / TRIAL
P_MRC = error_mrc / TRIAL
P_NONCOHER = error_noncoher / TRIAL
P_SEL = error_sel / TRIAL
