clear all;
close all;
clc;

subplot(3, 3, 1)
[x, fs] = audioread('noisy_song.wav');
dt = 1/fs;
t = 0:dt:(length(x) * dt) - dt;
plot(t, x); 
xlabel('Time (s)'); 
ylabel('Amplitude');
title('Signal of noisy song.wav')

subplot(3, 3, 2)
spectrogram(x, 1000, 80, 1000, fs, 'yaxis');
title('Spectrogram of noisy song.wav')


subplot(3, 3, 3)
audio_length = length(x);
df = fs / audio_length;
frequency_audio = -(fs / 2):df:(fs / 2) - df;
X = fftshift(fft(x)) / length(fft(x));
plot(frequency_audio, abs(X));
title('Fourier transform of noisy song.wav');
xlabel('Frequency(Hz)');
ylabel('Amplitude');

Low_Pass_Filtered_X = X;
Wl = 1800;
Low_Pass_Filtered_X(abs(frequency_audio) > Wl) = 0;

subplot(3, 3, 4)
low_pass_filtered_x = ifft(ifftshift(Low_Pass_Filtered_X) * audio_length);
plot(t, low_pass_filtered_x); 
xlabel('Time (s)'); 
ylabel('Amplitude');
title('Signal of Low Pass Filtered')

subplot(3, 3, 5)
spectrogram(low_pass_filtered_x, 1000, 80, 1000, fs, 'yaxis');
title('Spectrogram of Low Pass Filtered')

subplot(3, 3, 6)
plot(frequency_audio, abs(Low_Pass_Filtered_X));
title('Fourier transform of Low Pass Filtered');
xlabel('Frequency(Hz)');
ylabel('Amplitude');

audiowrite('low_pass_filtered.wav', low_pass_filtered_x, fs);


High_Pass_Filtered_X = X;
Wh = 1000;
High_Pass_Filtered_X(abs(frequency_audio) < Wh) = 0;

subplot(3, 3, 7)
high_pass_filtered_x = ifft(ifftshift(High_Pass_Filtered_X) * audio_length);
plot(t, high_pass_filtered_x); 
xlabel('Time (s)'); 
ylabel('Amplitude');
title('Signal of filtered High Pass Filtered')

subplot(3, 3, 8)
spectrogram(high_pass_filtered_x, 1000, 80, 1000, fs, 'yaxis');
title('Spectrogram of High Pass Filtered')

subplot(3, 3, 9)
plot(frequency_audio, abs(High_Pass_Filtered_X));
title('Fourier transform of High Pass Filtered');
xlabel('Frequency(Hz)');
ylabel('Amplitude');

audiowrite('high_pass_filtered.wav', high_pass_filtered_x, fs);
