% lab 5 
% ćwiczenie 2

clear all; close all; clc;

sizeX = 80; sizeY = 70;
numberOfRep = 50;
errors = [sizeX, sizeY];

for robotX = 1:sizeX
    for robotY = 1:sizeY
        station1 = atand((robotX - 0)     / (robotY - 0));
        station2 = atand((robotX - sizeX) / (robotY - 0));
        station3 = atand((robotX - 0)     / (robotY - sizeY));
        station4 = atand((robotX - sizeX) / (robotY - sizeY));
        
        r = zeros([2, 1]);
        sum = 0;
        for i = 1:numberOfRep
            station1v2 = station1 + rand()*4 - 2;
            station2v2 = station2 + rand()*4 - 2;
            station3v2 = station3 + rand()*4 - 2;
            station4v2 = station4 + rand()*4 - 2;

            A = [
                 1, -tand(station1v2)
                 1, -tand(station2v2)
                 1, -tand(station3v2)
                 1, -tand(station4v2)
                ];

            b = [
                 0     - 0 * tand(station1v2)
                 sizeX - 0 * tand(station2v2)
                 0     - sizeY * tand(station3v2)
                 sizeX - sizeY * tand(station4v2)
                ];
            
            r = inv(transpose(A) * A) * transpose(A) * b;

            robotXv2 = r(1,1);
            robotYv2 = r(2,1);

            dist = sqrt((robotX - robotXv2)^2 + (robotY - robotYv2)^2);
            sum = dist + sum;
        end
        errors(robotX,robotY) = sum / numberOfRep;
    end
end

pcolor(transpose(errors));
shading('interp');
colorbar;