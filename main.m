%% Initialisation
clear;
clc;
close all;
%% Define Parameters
[t1,t2,t3,t4,t5]=calc_delay;        % Calculate Actual Delays

c=3e8;                              % Light Speed
fs=3e7;                             % Sampling Frequency
Nsample=8192*4;                     % Number of Samples
SNR=10;                              % SNR Array

%% Calculate Distance Differences ri1
% Reshape Actual Delay Matrix for Easier Calculation
t_delay1=reshape(t1,1,numel(t1));
t_delay2=reshape(t2,1,numel(t2));
t_delay3=reshape(t3,1,numel(t3));
t_delay4=reshape(t4,1,numel(t4));
t_delay5=reshape(t5,1,numel(t5));

% Calculate ri1
for a=1:length(t_delay1)
        % Generate Original Signal and Delayed Signal
        [s_r1]=Generate_tdoa_base_band_signal(t_delay1(a),SNR,fs,Nsample);
        [s_r2]=Generate_tdoa_base_band_signal(t_delay2(a),SNR,fs,Nsample);
        [s_r3]=Generate_tdoa_base_band_signal(t_delay3(a),SNR,fs,Nsample);
        [s_r4]=Generate_tdoa_base_band_signal(t_delay4(a),SNR,fs,Nsample);
        [s_r5]=Generate_tdoa_base_band_signal(t_delay5(a),SNR,fs,Nsample);
        
        % Calculate Time Delay Using Matched Filter
        delay21_es(a)=calc_delayes(s_r1,s_r2,Nsample,fs);
        delay31_es(a)=calc_delayes(s_r1,s_r3,Nsample,fs);
        delay41_es(a)=calc_delayes(s_r1,s_r4,Nsample,fs);
        delay51_es(a)=calc_delayes(s_r1,s_r5,Nsample,fs);
        
        % Determine Distance Difference from Delay Difference
        % ri1=c*(ti-t1)
        r21(a)=c*delay21_es(a);
        r31(a)=c*delay31_es(a);
        r41(a)=c*delay41_es(a);
        r51(a)=c*delay51_es(a);
end

%% Extract Distance Difference of Each SNR
r_i1=[r21;r31;r41;r51];

%% Calculate Position Using LS and ML Method
n=1;
for m=1:length(r_i1)
[Z_LS(n,:),Z(n,:),Z_ML(n,:),Zp(n,:)]=calc_pos(r_i1(:,m),SNR,c*[t_delay2(m),t_delay3(m),t_delay4(m),t_delay5(m)]);
n=n+1;
end

%% Calculate GDOP
n=1;
for m=1:length(Zp)
GDOP(n)=calc_gdop(Zp(m,:));
GDOP_LS(n)=calc_gdop(Z_LS(m,1:2));
n=n+1;
end

%% Plot Figure
step=200;                       % Define Axes Steps
X=100:step:6200;                % X Axis
Y=100:step:6200;                % Y Axis

% Reshape GDOP Array to Matrix
GDOP_LS=reshape(GDOP_LS,length(X),length(Y));
GDOP=reshape(GDOP,length(X),length(Y));


% Plot Figures
figure;
contour(X,Y,GDOP_LS,30,'ShowText','on');
title(['LS GDOP,SNR=',num2str(SNR)]);
xlabel("m");
ylabel("m");
figure;
contour(X,Y,GDOP,30,'ShowText','on');
title(['2-Step Weighting GDOP,SNR=',num2str(SNR)]);
xlabel("m");
ylabel("m");

%% Calculate RMSE
X_Sample=repmat(X',31,1);
Y_Sample=reshape(repmat(Y',1,31)',961,1);

RMSE_LS=sqrt(sum((Z_LS(:,1)-X_Sample).^2)./length(X_Sample)+sum((Z_LS(:,2)-Y_Sample).^2)./length(Y_Sample));
RMSE_1Step=sqrt(sum((Z(:,1)-X_Sample).^2)./length(X_Sample)+sum((Z(:,2)-Y_Sample).^2)./length(Y_Sample));
RMSE=sqrt(sum((Zp(:,1)-X_Sample).^2)./length(X_Sample)+sum((Zp(:,2)-Y_Sample).^2)./length(Y_Sample));
