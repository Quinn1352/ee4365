clear
close all
clc

%Assumption
N0= 2;% Complex Noise Variance
SNR= -5:1:15;%dB 
TRIAL=10000;



for k=1:length(SNR)
    error_M1 = 0;
    error_M2 = 0;
    error_M3 = 0;
    error_M4 = 0;

    for m=1:TRIAL
        %TRANSMITTER DESIGN
        b=rand(1,1);%bit
        if (b > (2/3))
            b = 1;
        elseif (b < (1/3))
            b = -1;
        else
            b = 0;
        end
        
        s = rand(16,1) > 0.5;
        s = (s+j*s);
        S1=[s; s; s; s]/sqrt(128);%For b = +1
        %Generating S2
        S2=[s; -s; -s; s]/sqrt(128);%For b = -1
        S3 =[s; -s; s; -s]/sqrt(128);
        
        P= N0*10.^(SNR/10);
        %Output of Antenna
        if (b==1)
            Tx = sqrt(P(k))*S1;
        elseif (b == 0)
            Tx = sqrt(P(k))*S2; 
        else
            Tx = sqrt(P(k))*S3;
        end
        
        %COMPLEX AWGN GENERATION at Antennas
        N1 = sqrt(N0/2)*(randn(64,1)+j*randn(64,1));
        N2 = sqrt(N0/2)*(randn(64,1)+j*randn(64,1));
        N3 = sqrt(N0/2)*(randn(64,1)+j*randn(64,1));
        N4 = sqrt(N0/2)*(randn(64,1)+j*randn(64,1));

        %CHANNEL GENERATION for Antennas
        Ch1=(randn(1,1)+j*randn(1,1))/sqrt(2);
        Ch2=(randn(1,1)+j*randn(1,1))/sqrt(2);
        Ch3=(randn(1,1)+j*randn(1,1))/sqrt(2);
        Ch4=(randn(1,1)+j*randn(1,1))/sqrt(2);

        %RECEIVED SIGNAL at Antenna 1
        Rx1= Ch1*Tx+N1;
        %RECEIVED SIGNAL at Antenna 2
        Rx2= Ch2*Tx+N2;
        Rx3= Ch3*Tx+N3;
        Rx4= Ch4*Tx+N4;

        %MATCHED FILTER OUTPUTS at Antenna 1
        r11 = S1'*Rx1; 
        r12 = S2'*Rx1;
        r13 = S3'*Rx1;

        %MATCHED FILTER OUTPUTS at Antenna 2
        r21 = S1'*Rx2;
        r22 = S2'*Rx2;
        r23 = S3'*Rx2;
        
        %MATCHED FILTER OUTPUTS at Antenna 3
        r31 = S1'*Rx3;
        r32 = S2'*Rx3;
        r33 = S3'*Rx3;
        
        %MATCHED FILTER OUTPUTS at Antenna 4
        r41 = S1'*Rx4;
        r42 = S2'*Rx4;
        r43 = S3'*Rx4;
        

        %Estimating power for M = 1
        P1M1 = (r11)'*r11; %If b= +1, P1 = power of signal + noise power
        P2M1 = (r12)'*r12; %If b= 0, P2 = power of signal + noise power
        P3M1 = (r13)'*r13; %If b= -1, P3 = power of signal + noise power
        
        %Estimating power for M = 2
        P1M2 = (r11)'*r11+ (r21)'*r21; %If b= +1, P1 = power of signal + noise power
        P2M2 = (r12)'*r12+ (r22)'*r22; %If b= 0, P2 = power of signal + noise power
        P3M2 = (r13)'*r13+ (r23)'*r23; %If b= -1, P3 = power of signal + noise power
        
        %Estimating power for M = 3
        P1M3 = (r11)'*r11 + (r21)'*r21 + (r31)'*r31; %If b= +1, P1 = power of signal + noise power
        P2M3 = (r12)'*r12 + (r22)'*r22 + (r32)'*r32; %If b= 0, P2 = power of signal + noise power
        P3M3 = (r13)'*r13 + (r23)'*r23 + (r33)'*r33; %If b= -1, P3 = power of signal + noise power
        
        %Estimating power for M = 4
        P1M4 = (r11)'*r11 + (r21)'*r21 + (r31)'*r31 + (r41)'*r41; %If b= +1, P1 = power of signal + noise power
        P2M4 = (r12)'*r12 + (r22)'*r22 + (r32)'*r32 + (r42)'*r42; %If b= 0, P2 = power of signal + noise power
        P3M4 = (r13)'*r13 + (r23)'*r23 + (r33)'*r33 + (r43)'*r43; %If b= -1, P3 = power of signal + noise power


        %BIT DECISION
        absPM1 = [abs(P1M1), abs(P2M1), abs(P3M1)];
        absPM2 = [abs(P1M2), abs(P2M2), abs(P3M2)];
        absPM3 = [abs(P1M3), abs(P2M3), abs(P3M3)];
        absPM4 = [abs(P1M4), abs(P2M4), abs(P3M4)];
        
        if (max(absPM1) == abs(P1M1))
            s_dec_1 = 1;
        elseif(max(absPM1) == abs(P2M1))
            s_dec_1 = 0;
        else
            s_dec_1 = -1;
        end
        
        if (max(absPM2) == abs(P1M2))
            s_dec_2 = 1;
        elseif(max(absPM2) == abs(P2M2))
            s_dec_2 = 0;
        else
            s_dec_2 = -1;
        end
        
        if (max(absPM3) == abs(P1M3))
            s_dec_3 = 1;
        elseif(max(absPM1) == abs(P2M3))
            s_dec_3 = 0;
        else
            s_dec_3 = -1;
        end
        
        if (max(absPM1) == abs(P1M4))
            s_dec_4 = 1;
        elseif(max(absPM1) == abs(P2M4))
            s_dec_4 = 0;
        else
            s_dec_4 = -1;
        end
        %CHECKING ERROR
        
        if(s_dec_1 ~= b)
            error_M1=error_M1 + 1;
        end
        
        if(s_dec_2 ~= b)
            error_M2=error_M2 + 1;
        end
        
        if(s_dec_3 ~= b)
            error_M3=error_M3 + 1;
        end
        
        if(s_dec_4 ~= b)
            error_M4=error_M4 + 1;
        end
    end
    %SIMULATED BER
    P_s_M1(k)=error_M1/TRIAL;
    P_s_M2(k)=error_M2/TRIAL;
    P_s_M3(k)=error_M3/TRIAL;
    P_s_M4(k)=error_M4/TRIAL;
end

figure('Name', 'Problem 6 question 1')
plot(SNR, P_s_M1)
hold on
grid on
title('non coherent SER')
xlabel('SNR')
ylabel('SER')

figure('Name', 'Problem 6 question 2')
plot(SNR, P_s_M2)
hold on
grid on
plot(SNR, P_s_M3)
plot(SNR, P_s_M4)
plot(SNR, P_s_M1)
title('non coherent SER for M = 2 (blue), 3 (red), 4 (yellow)')
xlabel('SNR')
ylabel('SER')