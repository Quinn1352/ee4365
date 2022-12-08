clear
close all
clc

N0= 2;% Complex Noise Avg. Power
SNR= -5:1:15;%dB 
KdB= 6;%Ricean Factor
K = 10^(KdB / 10);
A= sqrt(K / (K+1)); %solution to A^2 + 2sigma^2 = 1 and K = A^2/2simga^2
sigma_ch = sqrt(1/(2*K)); 

TRIAL=20000;
for k = 1:length(SNR)
    error_sel1 = 0;
    error_mrc1 = 0;
    error_egc1 = 0;%For system simulation

    error_sel2 = 0;
    error_mrc2 = 0;
    error_egc2 = 0;%For system simulation

    error_sel3 = 0;
    error_mrc3 = 0;
    error_egc3 = 0;%For system simulation

    error_sel4 = 0;
    error_mrc4 = 0;
    error_egc4 = 0;%For system simulation

    for m=1:TRIAL
        %TRANSMITTER DESIGN
        b=2*(rand(1,1)>0.5)-1;%bit
        P= N0*10.^(SNR/10);%Designing power for given SNR and complex noise power (avg.)
        S=(ones(64,1)+j*ones(64,1))/sqrt(128);
        
        %Output of Antenna
        Tx=sqrt(P(k)).*b.*S;

        %COMPLEX AWGN GENERATION
        N1 = sqrt(N0/2)*(randn(64,1)+j*randn(64,1));
        N2 = sqrt(N0/2)*(randn(64,1)+j*randn(64,1));
        N3 = sqrt(N0/2)*(randn(64,1)+j*randn(64,1));
        N4 = sqrt(N0/2)*(randn(64,1)+j*randn(64,1));

        %Slow and Flat Ricean Channels
        X = sigma_ch*randn(1,1)+A*cos(pi/3); 
        Y = sigma_ch*randn(1,1)+A*sin(pi/3); 
        h1=X+j*Y;
        X = sigma_ch*randn(1,1)+A*cos(pi/3); 
        Y = sigma_ch*randn(1,1)+A*sin(pi/3); 
        h2=X+j*Y;
        X = sigma_ch*randn(1,1)+A*cos(pi/3); 
        Y = sigma_ch*randn(1,1)+A*sin(pi/3); 
        h3=X+j*Y;
        X = sigma_ch*randn(1,1)+A*cos(pi/3); 
        Y = sigma_ch*randn(1,1)+A*sin(pi/3); 
        h4=X+j*Y;

        %RECEIVED SIGNAL
        Rx1= h1*Tx+N1;
        Rx2 = h2*Tx+N2;
        Rx3 = h3*Tx+N3;
        Rx4 = h4*Tx+N4;

        %MATCHED FILTER OUTPUT
        r_mf1=S'*Rx1;
        r_mf2=S'*Rx2;
        r_mf3=S'*Rx3;
        r_mf4=S'*Rx4;
        %COPHASING
        r_tilda1=(h1'/abs(h1))*r_mf1;
        r_tilda2=(h2'/abs(h2))*r_mf2;
        r_tilda3=(h3'/abs(h3))*r_mf3;
        r_tilda4=(h4'/abs(h4))*r_mf4;
        %EXTRACT REAL COMPONENT FROM r_tilda
        r1=real(r_tilda1);
        r2=real(r_tilda2);
        r3=real(r_tilda3);
        r4=real(r_tilda4);

        %BIT DECISION

        %SEL BIT DECISION
        b_dec_sel1 = sign(r1);
        error_q_sel1= error_q_sel1+qfunc(sqrt((abs(h1)^2*2*P/N0))); %Accumulate Ins. BER from Ch1

        absH2 = [abs(h1), abs(h2)];
        if(abs(h1) == max(absH2))
            b_dec_sel2 = sign(r1);
            error_q_sel2= error_q_sel2+qfunc(sqrt((abs(h1)^2*2*P/N0))); %Accumulate Ins. BER from Ch1
        else
            b_dec_sel2 = sign(r2);
            error_q_sel2= error_q_sel2+qfunc(sqrt((abs(h2)^2*2*P/N0))); %Accumulate Ins. BER from Ch2
        end

        absH3 = [abs(h1), abs(h2), abs(h3)];
        if(abs(h1) == max(absH3))
            b_dec_sel3 = sign(r1);
            error_q_sel3= error_q_sel3+qfunc(sqrt((abs(h1)^2*2*P/N0))); %Accumulate Ins. BER from Ch1
        elseif(abs(h2) == max(absH3))
            b_dec_sel3 = sign(r2);
            error_q_sel3= error_q_sel3+qfunc(sqrt((abs(h2)^2*2*P/N0))); %Accumulate Ins. BER from Ch2
        else
            b_dec_sel3 = sign(r3);
            error_q_sel3= error_q_sel3+qfunc(sqrt((abs(h3)^2*2*P/N0))); %Accumulate Ins. BER from Ch3
        end

        absH4 = [abs(h1), abs(h2), abs(h3), abs(h4)];
        if(abs(h1) == max(absH4))
            b_dec_sel4 = sign(r1);
            error_q_sel4= error_q_sel4+qfunc(sqrt((abs(h1)^2*2*P/N0))); %Accumulate Ins. BER from Ch1
        elseif(abs(h2) == max(absH4))
            b_dec_sel4 = sign(r2);
            error_q_sel4= error_q_sel4+qfunc(sqrt((abs(h2)^2*2*P/N0))); %Accumulate Ins. BER from Ch2
        elseif(abs(h3) == max(absH4))
            b_dec_sel4 = sign(r3);
            error_q_sel4= error_q_sel4+qfunc(sqrt((abs(h3)^2*2*P/N0))); %Accumulate Ins. BER from Ch3
        else
            b_dec_sel4 = sign(r4);
            error_q_sel4= error_q_sel4+qfunc(sqrt((abs(h4)^2*2*P/N0))); %Accumulate Ins. BER from Ch4
        end

        %EGC BIT DECISION 
        r_egc1 = r1;  % Rule EGC
        b_dec_egc1=sign(r_egc1);

        r_egc2 = r1 + r2;  % Rule EGC
        b_dec_egc2=sign(r_egc2);

        r_egc3 = r1 + r2 + r3;  % Rule EGC
        b_dec_egc3=sign(r_egc3);

        r_egc4 = r1 + r2 + r3 + r4;  % Rule EGC
        b_dec_egc4=sign(r_egc4);
    
        %MRC BIT DECISION
        r_mrc1 =abs(h1)*r1;  % Rule MRC
        b_dec_mrc1=sign(r_mrc1);

        r_mrc2 =abs(h1)*r1 +abs(h2)*r2;  % Rule MRC
        b_dec_mrc2=sign(r_mrc2);

        r_mrc3 =abs(h1)*r1 +abs(h2)*r2 + abs(h3)*r3;  % Rule MRC
        b_dec_mrc3=sign(r_mrc3);

        r_mrc4 =abs(h1)*r1 +abs(h2)*r2 + abs(h3)*r3 + abs(h4)*r4;  % Rule MRC
        b_dec_mrc4=sign(r_mrc4);

        %CHECKING ERROR
        error_sel1 = error_sel1 +0.5*abs(b-b_dec_sel1);%Accumulating Bit Errors
        error_sel2 = error_sel2 +0.5*abs(b-b_dec_sel2);%Accumulating Bit Errors
        error_sel3 = error_sel3 +0.5*abs(b-b_dec_sel3);%Accumulating Bit Errors
        error_sel4 = error_sel4 +0.5*abs(b-b_dec_sel4);%Accumulating Bit Errors

        error_egc1 = error_egc1 +0.5*abs(b-b_dec_egc1);%Accumulating Bit Errors
        error_egc2 = error_egc2 +0.5*abs(b-b_dec_egc2);%Accumulating Bit Errors
        error_egc3 = error_egc3 +0.5*abs(b-b_dec_egc3);%Accumulating Bit Errors
        error_egc4 = error_egc4 +0.5*abs(b-b_dec_egc4);%Accumulating Bit Errors
        

        error_mrc1 = error_mrc1 +0.5*abs(b-b_dec_mrc1);%Accumulating Bit Errors
        error_mrc2 = error_mrc2 +0.5*abs(b-b_dec_mrc2);%Accumulating Bit Errors
        error_mrc3 = error_mrc3 +0.5*abs(b-b_dec_mrc3);%Accumulating Bit Errors
        error_mrc4 = error_mrc4 +0.5*abs(b-b_dec_mrc4);%Accumulating Bit Errors

        beta1=(abs(h1)^2); %sqrt(beta) = channel gain under MRC
        error_q_mrc1=error_q_mrc1+qfunc(sqrt(beta1*2*P/N0)); %Accumulate Ins. BER 

        beta2=(abs(h1)^2+abs(h2)^2); %sqrt(beta) = channel gain under MRC
        error_q_mrc2=error_q_mrc2+qfunc(sqrt(beta2*2*P/N0)); %Accumulate Ins. BER 

        beta3=(abs(h1)^2+abs(h2)^2+abs(h3)^2); %sqrt(beta) = channel gain under MRC
        error_q_mrc3=error_q_mrc3+qfunc(sqrt(beta3*2*P/N0)); %Accumulate Ins. BER 

        beta4=(abs(h1)^2+abs(h2)^2+abs(h3)^2+abs(h4)^2); %sqrt(beta) = channel gain under MRC
        error_q_mrc4=error_q_mrc4+qfunc(sqrt(beta4*2*P/N0)); %Accumulate Ins. BER 

        
    end
    P_sel1(k)=error_sel1/TRIAL;
    P_sel2(k)=error_sel2/TRIAL;
    P_sel3(k)=error_sel3/TRIAL;
    P_sel4(k)=error_sel4/TRIAL;
    P_q_sel1(k) = error_q_sel1/TRIAL;
    P_q_sel2(k) = error_q_sel2/TRIAL;
    P_q_sel3(k) = error_q_sel3/TRIAL;
    P_q_sel4(k) = error_q_sel4/TRIAL;

    P_mrc1(k)=error_mrc1/TRIAL;
    P_mrc2(k)=error_mrc2/TRIAL;
    P_mrc3(k)=error_mrc3/TRIAL;
    P_mrc4(k)=error_mrc4/TRIAL;
    P_q_mrc1(k) = error_q_mrc1/TRIAL;
    P_q_mrc2(k) = error_q_mrc2/TRIAL;
    P_q_mrc3(k) = error_q_mrc3/TRIAL;
    P_q_mrc4(k) = error_q_mrc4/TRIAL;

    P_egc1(k)=error_egc1/TRIAL;
    P_egc2(k)=error_egc2/TRIAL;
    P_egc3(k)=error_egc3/TRIAL;
    P_egc4(k)=error_egc4/TRIAL;
    
   

end


%Average BER from System Simulation
figure('Name', 'Problem 6 part 1 - SEL')
plot(SNR, P_sel1)
grid on
hold on
plot(SNR, P_sel2)
plot(SNR, P_sel3)
plot(SNR, P_sel4)
title('BER for SEL for M= 1 (blue), 2 (red), 3 (yellow) , 4 (purple)')
xlabel('SNR')
ylabel('BER')

%Average BER from System Simulation
figure('Name', 'Problem 6 part 1 - MRC')
plot(SNR, P_mrc1)
grid on
hold on
plot(SNR, P_mrc2)
plot(SNR, P_mrc3)
plot(SNR, P_mrc4)
title('BER for MRC for M= 1 (blue), 2 (red), 3 (yellow) , 4 (purple)')
xlabel('SNR')
ylabel('BER')

%Average BER from System Simulation
figure('Name', 'Problem 6 part 1 - EGC')
plot(SNR, P_egc1)
grid on
hold on
plot(SNR, P_egc2)
plot(SNR, P_egc3)
plot(SNR, P_egc4)
title('BER for EGC for M= 1 (blue), 2 (red), 3 (yellow) , 4 (purple)')
xlabel('SNR')
ylabel('BER')  

