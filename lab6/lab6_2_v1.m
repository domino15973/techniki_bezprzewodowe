% lab 6 
% ćwiczenie 2 - wersja 1 - bez odbić

clear all; close all; clc;

% wymiary pomieszczenia
sizeX = 60; sizeY = 40;
rectangle('Position', [0 0 sizeX sizeY], 'EdgeColor', 'black', 'LineWidth', 1);
hold on;
axis equal;

% współrzędne nadajników
uwb = [5.5, 5.5, 5.5; % x
       4.5, 20,  34]; % y

% współrzędne odbiorników
odb = [54,   54,   54,   54;    % x
       10.5, 16.5, 24.5, 30.5]; % y

% pasywny obiekt, który blokuje część z możliwych dróg propagacji
uwb_idx = randi(length(uwb(1,:)));
odb_idx = randi(length(odb(1,:)));
t = rand();
obj_x = (1 - t) * uwb(1, uwb_idx) + t * odb(1, odb_idx);
obj_y = (1 - t) * uwb(2, uwb_idx) + t * odb(2, odb_idx);
rectangle('Position', [obj_x obj_y 1 1], 'EdgeColor', 'red', 'FaceColor', 'red', 'LineWidth', 1);

% indeksy zablokowanych dróg propagacji
% 0 - następuje propagacja, 1 - propagacja zablokowana
blocked_path = zeros([length(uwb(1,:)), length(odb(1,:))]);

for i=1:length(uwb(1,:))
    for j=1:length(odb(1,:))
        plot(uwb(1, i), uwb(2, i), 'O', 'Color', 'blue');
        plot(odb(1, j), odb(2, j), 'O', 'Color', 'blue');
        hold on;

        res = wektorsektor(uwb(1, i), uwb(2,i), odb(1,j), odb(2,j), obj_x, obj_y, 1, 1);
        if res == 1 || res == 0
            line([uwb(1,i) odb(1,j)], [uwb(2,i) odb(2,j)], 'Color', 'red', 'LineWidth', 2);
            blocked_path(i, j) = 1;
        else
            line([uwb(1,i) odb(1,j)], [uwb(2,i) odb(2,j)], 'Color', 'green', 'LineWidth', 0.5);
        end        
    end
end

for obj_x_v2=1:sizeX
    for obj_y_v2=1:sizeY
        blocked_path_v2 = zeros([length(uwb(1,:)), length(odb(1,:))]);
        for i=1:length(uwb(1,:))
            for j=1:length(odb(1,:))
                res = wektorsektor(uwb(1,i), uwb(2,i), odb(1,j), odb(2,j), obj_x_v2, obj_y_v2, 1, 1);
                if res == 1 || res == 0
                    blocked_path_v2(i,j) = 1;
                end
            end
        end
        if blocked_path == blocked_path_v2
            rectangle('Position', [obj_x_v2 obj_y_v2 1 1], 'EdgeColor', 'yellow', 'LineWidth', 1);
        end
    end
end