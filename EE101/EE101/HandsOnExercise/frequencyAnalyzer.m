function [freq_x] = frequencyAnalyzer(x,fs)
X=fft(x); %Spectrum of the signal x by fourier transform.
magX=abs(X);
N=length(X); %length of the X
f=fs*(0:N-1)/N; %making the freq represented in hz
magX=magX(1:round(N/2)); %Taking half of the magx because it is symmetric
f=f(1:round(N/2));
figure
plot(f,magX)
xlabel("Frequency (Hz)")
ylabel("Spectrum Magnitude")

threshold=max(magX)/10;
indices=magX>threshold;
freq_x=f(indices);
end