% lab 5 
% ćwiczenie 1

clear all; close all; clc;

numberOfRobots = 90;
sizeX = 80; sizeY = 70;

robots    = zeros([numberOfRobots, 6]);
robots_v2 = zeros([numberOfRobots, 6]);

r = zeros([2, 1]);
sum = 0;

for i = 1:numberOfRobots
    robots(i,1) = rand()*sizeX; % x
    robots(i,2) = rand()*sizeY; % y

    robots(i,3) = atand((robots(i,1) - 0)     / (robots(i,2) - 0));     % alfa1
    robots(i,4) = atand((robots(i,1) - sizeX) / (robots(i,2) - 0));     % alfa2 
    robots(i,5) = atand((robots(i,1) - 0)     / (robots(i,2) - sizeY)); % alfa3
    robots(i,6) = atand((robots(i,1) - sizeX) / (robots(i,2) - sizeY)); % alfa4

    for j = 3:6
        robots_v2(i,j) = robots(i,j) + rand()*4 - 2;
    end
    
    A = [
         1, -tand(robots_v2(i,3))
         1, -tand(robots_v2(i,4))
         1, -tand(robots_v2(i,5))
         1, -tand(robots_v2(i,6))
        ];

    b = [
         0     - 0 * tand(robots_v2(i,3))
         sizeX - 0 * tand(robots_v2(i,4))
         0     - sizeY * tand(robots_v2(i,5))
         sizeX - sizeY * tand(robots_v2(i,6))
        ];

    r = inv(transpose(A) * A) * transpose(A) * b;

    robots_v2(i,1) = r(1,1);
    robots_v2(i,2) = r(2,1);

    dist = sqrt((robots(i,1) - robots_v2(i,1))^2 + (robots(i,2) - robots_v2(i,2))^2);
    sum = dist + sum;
end

err = sum / numberOfRobots,

plot(robots(:,1), robots(:,2), 'bx');
hold on;
plot(robots_v2(:,1), robots_v2(:,2), 'rx');