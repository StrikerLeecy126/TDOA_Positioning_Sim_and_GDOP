function [s_r]=Generate_tdoa_base_band_signal(t_delay,SNR,fs,Nsample)
    B=200e3;
    Tc=Nsample/fs;
    S=B/Tc;
    t=0:1/fs:Tc-1/fs;
    t=t-Tc/2;
    fc=100e6;
    s_r=exp(1i*pi*S.*(t-t_delay).^2)*exp(-1i*2*pi*fc*t_delay);
    s_r=awgn(s_r,SNR);
end