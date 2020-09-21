clear all
close all
clc
clear
%-----------------------% Uper Link LDPC Coder Encoder Setting 
subsystemType = 'QPSK 1/4';   % Constellation and LDPC code rate
LDPC_Rate_UL = 1/4;           % selected LDPC ratio
EsNodB        = 9;            % Energy per symbol to noise PSD ratio in dB
numFrames     = 1;            % Number of frames to simulate

% Initialize
configureDVBS2Demo

% Display system parameters
dvb

encldpc_UL = comm.LDPCEncoder(dvb.LDPCParityCheckMatrix);
decldpc_UL = comm.LDPCDecoder(dvb.LDPCParityCheckMatrix, ...
    'IterationTerminationCondition', 'Parity check satisfied', ...
    'MaximumIterationCount',         dvb.LDPCNumIterations, ...
    'NumIterationsOutputPort',       true);
%% Uper Link LDPC Coder Encoder Setting 

%-----------------------% Lower Link LDPC Coder Encoder Setting 
subsystemType = 'QPSK 9/10';   % Constellation and LDPC code rate
LDPC_Rate_LL = 9/10;           % selected LDPC ratio
EsNodB        = 9;             % Energy per symbol to noise PSD ratio in dB
numFrames     = 1;             % Number of frames to simulate

% Initialize
configureDVBS2Demo

% Display system parameters
dvb

encldpc_LL = comm.LDPCEncoder(dvb.LDPCParityCheckMatrix);
decldpc_LL = comm.LDPCDecoder(dvb.LDPCParityCheckMatrix, ...
    'IterationTerminationCondition', 'Parity check satisfied', ...
    'MaximumIterationCount',         dvb.LDPCNumIterations, ...
    'NumIterationsOutputPort',       true);


%-----------------------------------------------------------------------------%  Transmitter 
imdata = imread('peppers.png');
Ratio = (3840*2160)/(1920*1080);
Im1 = imdata(1:end/Ratio,:,:);
Im2 = imdata(end/Ratio+1:end,:,:);
figure(1)
subplot(1,2,1);
imshow(Im1)
subplot(1,2,2);
imshow(Im2)
X_UL = reshape((dec2bin(typecast(Im1(:),'uint8'),8)-'0').',1,[]);
X_LL = reshape((dec2bin(typecast(Im2(:),'uint8'),8)-'0').',1,[]);

%--------------------% LDPC Coding of Uper layer 
KL = 64800*LDPC_Rate_UL;   % Size of input data
N_Zero_Pading_UL = KL-(size(X_UL,2)-floor(size(X_UL,2)/KL)*KL); 
X_UL(end+1:end+N_Zero_Pading_UL)=0;  % Zero pading 
Packet_UL = [];
It_UL =size(X_UL,2)/KL;
for(ik = 1:It_UL) % Packetizing and coding 
    data = X_UL((ik-1)*KL+1:ik*KL);
    Packet =step(encldpc_UL,data.');
    Packet_UL = [Packet_UL;Packet] ;
end
% ----------- Modulator Uper layer--------
Mod_UL = 4;
X_UL = reshape(Packet_UL,log2(Mod_UL),[]);
Q_Data = qammod(X_UL,Mod_UL,'input','bit');
Q_DataUL  = Q_Data /sqrt(bandpower(Q_Data));


%------------% LDPC Coding of Lower layer 
KL_LL = 64800*LDPC_Rate_LL; % Size of input data
N_Zero_Pading_LL = KL_LL-(size(X_LL,2)-floor(size(X_LL,2)/KL_LL)*KL_LL); 
X_LL(end+1:end+N_Zero_Pading_LL)=0;  % Zero pading 
Packet_LL = [];
It_LL =size(X_LL,2)/KL_LL ;
for(ik = 1:It_LL) % Packetizing and coding 
    data = X_LL((ik-1)*KL_LL+1:ik*KL_LL);
    Packet =step(encldpc_LL,data.');
    Packet_LL = [Packet_LL;Packet] ;
end
% ----------- Modulator lower layer--------
Mod_LL = 16;
X_LL = reshape(Packet_LL ,log2(Mod_LL),[]);
Q_Data = qammod(X_LL,Mod_LL,'input','bit');
power_LL = sqrt(bandpower(Q_Data));
Q_DataLL  = Q_Data /power_LL;



SNR = [15:-3:0];
Delta = 5;
for(iu = 1:size(SNR,2))

%---------------% channel UL
EbNo_UL=SNR(iu)+Delta+10*log10(LDPC_Rate_UL);
EsNo = EbNo_UL+10*log10(log2(Mod_UL));
Variance = 10^((-EsNo)/20);
Noise = Variance*(randn(size(Q_DataUL))+1i*randn(size(Q_DataUL)));
Channel_DataUL = Noise+Q_DataUL ;



%----------------- channel LL
EbNo_LL=SNR(iu)+log10(LDPC_Rate_LL);
EsNo = EbNo_LL+10*log10(log2(Mod_LL));
Variance = 10^((-EsNo)/20);
Noise = Variance*(randn(size(Q_DataLL))+1i*randn(size(Q_DataLL)));
Channel_DataLL = Noise+Q_DataLL;


%------------------------------------------------------------------------------% Receiver 

% -----------------Demodulator Uper Layer 
R_Data = qamdemod(Channel_DataUL,Mod_UL,'output','bit');
R_Data =reshape(R_Data,[],1);
%------------------% LDPC deCoding of Uper layer channel 
R_X_UL=[];
for(ik = 1:It_UL) % de-Packetizing and decoding 
    U_Data = R_Data((ik-1)*64800+1:ik*64800);% de-Packetizing
    U_Data= logical(step(decldpc_UL ,-20*double(U_Data)+10));% decoding 
    R_X_UL = [R_X_UL;U_Data] ;
end
R_X_UL=R_X_UL(1:end-N_Zero_Pading_UL); % remove zero pading 
% ----------------
U_Data = reshape(R_X_UL,8,[]).';
U_Data = bin2dec(num2str(U_Data));
% ------------------------
R_Im = reshape(U_Data,size(Im1));
figure(2)
subplot(1,2,1);
imshow(uint8(R_Im))
title(['HD and Upper Layer, Eb/No = ',num2str(SNR(iu))])




%--------------------% Demodulator Lower layyer 
R_Data = qamdemod(power_LL*Channel_DataLL,Mod_LL,'output','bit');
R_Data =reshape(R_Data,[],1);
%--------------------% LDPC deCoding of lower layer channel 
R_X_LL=[];
for(ik = 1:It_LL) % de-Packetizing and decoding 
    U_Data = R_Data((ik-1)*64800+1:ik*64800);% de-Packetizing
    U_Data= logical(step(decldpc_LL ,-20*double(U_Data)+10));% decoding 
    R_X_LL = [R_X_LL;U_Data] ;
end
R_X_LL=R_X_LL(1:end-N_Zero_Pading_LL); % remove zero pading 
% ----------------
U_Data = reshape(R_X_LL,8,[]).';
U_Data = bin2dec(num2str(U_Data));
% ------------------------
R_Im = reshape(U_Data,size(Im2));
figure(2)
subplot(1,2,2);
imshow(uint8(R_Im))
title(['4K and Lower Layer, Eb/No = ',num2str(SNR(iu))])

end