% lab 5 
% ćwiczenie 1 wersja 2

clear all; close all; clc;

numberOfPeople = 25;
sizeX = 104; sizeY = 68;

Pt = 100; % [mW] power transmited

people    = zeros([numberOfPeople, 2]);
people_v2 = zeros([numberOfPeople, 2]);

r = zeros([2, 1]);
sum = 0;

for i = 1:numberOfPeople
    people(i,1) = rand()*sizeX;
    people(i,2) = rand()*sizeY;
    
    d1 = sqrt((people(i,1) - 0)^2     + (people(i,2) - 0)^2);
    d2 = sqrt((people(i,1) - sizeX)^2 + (people(i,2) - 0)^2);
    d3 = sqrt((people(i,1) - 0)^2     + (people(i,2) - sizeY)^2);
    d4 = sqrt((people(i,1) - sizeX)^2 + (people(i,2) - sizeY)^2);

    pathloss1 = 53 + 20 * log10(d1) + 0.5 * randn();
    pathloss2 = 53 + 20 * log10(d2) + 0.5 * randn();
    pathloss3 = 53 + 20 * log10(d3) + 0.5 * randn();
    pathloss4 = 53 + 20 * log10(d4) + 0.5 * randn();

    d1_v2 = 10^((pathloss1 - 45) / 25); 
    d2_v2 = 10^((pathloss2 - 45) / 25); 
    d3_v2 = 10^((pathloss3 - 45) / 25); 
    d4_v2 = 10^((pathloss4 - 45) / 25); 

    A = [
         [sizeX, 0];
         [0    , sizeY];
         [sizeX, sizeY];
        ];

    b = 1/2 *[
         d1_v2^2 - d2_v2^2 + sizeX^2 + 0^2;    
         d1_v2^2 - d3_v2^2 + 0^2     + sizeY^2;
         d1_v2^2 - d4_v2^2 + sizeX^2 + sizeY^2;
        ];

    r = inv(transpose(A) * A) * transpose(A) * b;

    people_v2(i,1) = r(1,1);
    people_v2(i,2) = r(2,1);

    dist = sqrt((people(i,1) - people_v2(i,1))^2 + (people(i,2) - people_v2(i,2))^2);
    sum = dist + sum;
end

err = sum / numberOfPeople,

plot(people(:,1), people(:,2), 'bx');
hold on;
plot(people_v2(:,1), people_v2(:,2), 'rx');