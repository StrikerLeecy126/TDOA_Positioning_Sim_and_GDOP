function delay_es=calc_delayes(s,sr,Nsample,fs)
    y=fftshift(ifft(fft(sr).*conj(fft(s))));        % Match Filter
    [~,I]=max(abs(y));                              % Find Maximum Index
    delay_es=(I-Nsample/2-1)/fs;                    % Calculate Estimated Time Delay
end