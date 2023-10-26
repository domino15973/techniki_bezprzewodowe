clear all; close all; clc;

[Y, X] = meshgrid(0.1:0.1:28, 0.1:0.1:16);

% wspolrzedne nadajnika
x_tx = 12.05;
y_tx = 7.05;

% wspolrzedne sciany ([x1, x2], [y1, y2])
line([0, 10], [20.05, 20.05]);
line([13, 16], [20.05, 20.05]);

wsp = 0.7; % wspolczynnik odbicia sciany
c = 299792458; % predkosc swiatla
f = 3.6; % czestotliwosc nadajnika
lambda = c / f; % dlugosc fali
txPower = 10*log10(1); 

power = zeros(160, 280);

axis([0, 16, 0, 28]);

for x=1:160
    for y=1:280
        dist = sqrt((x_tx - x/10)^2 + (y_tx - y/10)^2);
        FSL = 32.44 + 20*log10(dist) + 20*log10(f);
        
        % wykorzystanie funkcji dwawektory
        sciana1 = dwawektory(0, 20.05, 10, 20.05, x_tx, y_tx, x/10, y/10);
        sciana2 = dwawektory(13, 20.05, 16, 20.05, x_tx, y_tx, x/10, y/10);

        if sciana1 == -1 && sciana2 == -1
            power(x, y) = txPower - FSL;
        else
            power(x, y) = -100;
        end
    end
end

pcolor(X, Y, power);
shading("interp");
colorbar;
