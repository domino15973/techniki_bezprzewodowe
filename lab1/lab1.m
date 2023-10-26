clear all; close all; clc;

errRatioArr = [];

for SNR=1:15
    originalData = randi([0, 1], 100000, 1);

    modulator = comm.PSKModulator(2, 0);
    modulatedData = step(modulator, originalData);

    TXpower = 10*log10(2); % dBm
    pathLoss = 126; % dB
    noiseRatio = -129; % dBm

    %SNR = TXpower - pathLoss - noiseRatio

    channel = comm.AWGNChannel("NoiseMethod", "Signal to Noise Ratio (SNR)", "SNR", SNR);
    transmittedData = step(channel, modulatedData);

    demodulator = comm.PSKDemodulator(2, 0);
    demodulatedData = step(demodulator, transmittedData);

    errorRate = comm.ErrorRate;

    err = errorRate(originalData, demodulatedData);

    errRatio = err(1);
    errRatioArr(length(errRatioArr) + 1) = errRatio;

end

semilogy(errRatioArr);
