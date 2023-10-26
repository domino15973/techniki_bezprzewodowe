clear all; close all; clc;

wsp = 0.8; % wspolczynnik odbicia promienia od sciany
P = 5; % [W]
f = 3 * 10^9; % [Hz]
c = 299792458; % [m/s]
lambda = c / f;

vCar = 30;
xStart = 50; yStart = 10;
xEnd = 50; yEnd = 300;

xBS = 110; yBS = 190; % S - nadajnik
xBS1 = 110; yBS1 = 10; % S'1 (odbicie nadajnika w scianie 1)
xBS2 = -70; yBS2 = 190; % S'2 (odbicie nadajnika w scianie 2)

Pr = [];
idx = 1;

for time = 0.010:0.010:6
    s = vCar * time;
    xCar = xStart;
    yCar = s + yStart;

    res1 = dwawektory(xBS, yBS, xCar, yCar, 70, 100, 130, 100);   
    res2 = dwawektory(xBS1, yBS1, xCar, yCar, 70, 100, 130, 100); 
    res3 = dwawektory(xBS2, yBS2, xCar, yCar, 20, 30, 20, 300);

    H1 = 0; H2 = 0; H3 = 0;

    if res1 == -1 
        dist = sqrt((xCar-xBS)^2 + (yCar-yBS)^2);
        H1 = 1 * (lambda/(4*pi*dist)) * exp(-1j*2*pi*dist/lambda);
    end
    if res2 == 1
        dist = sqrt((xCar-xBS1)^2 + (yCar-yBS1)^2);
        H2 = wsp * (lambda/(4*pi*dist)) * exp(-1j*2*pi*dist/lambda);
    end
    if res3 == 1
        dist = sqrt((xCar-xBS2)^2 + (yCar-yBS2)^2);
        H3 = wsp * (lambda/(4*pi*dist)) * exp(-1j*2*pi*dist/lambda);
    end

    H = H1 + H2 + H3; % transmitancja
    if H == 0
        Pr(idx) = -100;
    else
        Pr(idx) = 10*log10(P) + 20*log10(abs(H)); % moc sygnalu
    end

    idx = idx + 1;

end

plot(Pr);
