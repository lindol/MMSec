addpath('src');
[y,Fs] = audioread('music\F.mp3');
sound(y*0.5,Fs);