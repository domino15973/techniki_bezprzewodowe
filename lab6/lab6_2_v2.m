% lab 6 
% ćwiczenie 2 - wersja 2 - z odbiciami

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
blocked_path = zeros([length(uwb(1,:)), length(odb(1,:)), 5]);

for i=1:length(uwb(1,:))
    for j=1:length(odb(1,:))
        plot(uwb(1, i), uwb(2, i), 'O', 'Color', 'blue');
        plot(odb(1, j), odb(2, j), 'O', 'Color', 'blue');
        hold on;

        res = wektorsektor(uwb(1, i), uwb(2,i), odb(1,j), odb(2,j), obj_x, obj_y, 1, 1);
        if res == 1 || res == 0
            line([uwb(1,i) odb(1,j)], [uwb(2,i) odb(2,j)], 'Color', 'red', 'LineWidth', 2);
            blocked_path(i, j, 1) = 1;
        else
            line([uwb(1,i) odb(1,j)], [uwb(2,i) odb(2,j)], 'Color', 'green', 'LineWidth', 0.5);
        end

        % odbicie względem górnej ściany
        cross_point_y = sizeY;
        cross_point_x = cross_x(uwb(1,i), odb(1,j), (2*sizeY - uwb(2,i)), odb(2,j), cross_point_y);
        blocked_path(i, j, 2) = ray_tracing(uwb(1,i), uwb(2,i), odb(1,j), odb(2,j), obj_x, obj_y, cross_point_x, cross_point_y);
        
        % odbicie względem dolnej ściany
        cross_point_y = 0;
        cross_point_x = cross_x(uwb(1,i), odb(1,j), -uwb(2,i), odb(2,j), cross_point_y);
        blocked_path(i, j, 3) = ray_tracing(uwb(1,i), uwb(2,i), odb(1,j), odb(2,j), obj_x, obj_y, cross_point_x, cross_point_y);

        % odbicie względem lewej ściany
        cross_point_x = 0;
        cross_point_y = cross_y((-uwb(1,i)), odb(1,j), uwb(2,i), odb(2,j), cross_point_x);
        blocked_path(i, j, 4) = ray_tracing(uwb(1,i), uwb(2,i), odb(1,j), odb(2,j), obj_x, obj_y, cross_point_x, cross_point_y);

        % odbicie względem prawej ściany
        cross_point_x = sizeX;
        cross_point_y = cross_y((2*sizeX - uwb(1,i)), odb(1,j), uwb(2,i), odb(2,j), cross_point_x);
        blocked_path(i, j, 5) = ray_tracing(uwb(1,i), uwb(2,i), odb(1,j), odb(2,j), obj_x, obj_y, cross_point_x, cross_point_y);
    end
end

for obj_x_v2=1:sizeX
    for obj_y_v2=1:sizeY
        blocked_path_v2 = zeros([length(uwb(1,:)), length(odb(1,:)), 5]);
        for i=1:length(uwb(1,:))
            for j=1:length(odb(1,:))
                res = wektorsektor(uwb(1,i), uwb(2,i), odb(1,j), odb(2,j), obj_x_v2, obj_y_v2, 1, 1);
                if res == 1 || res == 0
                    blocked_path_v2(i, j, 1) = 1;
                end
                % odbicie względem górnej ściany
                cross_point_y = sizeY;
                cross_point_x = cross_x(uwb(1,i), odb(1,j), (2*sizeY - uwb(2,i)), odb(2,j), cross_point_y);
                blocked_path_v2(i, j, 2) = ray_tracing_v2(uwb(1,i), uwb(2,i), odb(1,j), odb(2,j), obj_x, obj_y, cross_point_x, cross_point_y);
        
                % odbicie względem dolnej ściany
                cross_point_y = 0;
                cross_point_x = cross_x(uwb(1,i), odb(1,j), -uwb(2,i), odb(2,j), cross_point_y);
                blocked_path_v2(i, j, 3) = ray_tracing_v2(uwb(1,i), uwb(2,i), odb(1,j), odb(2,j), obj_x, obj_y, cross_point_x, cross_point_y);

                % odbicie względem lewej ściany
                cross_point_x = 0;
                cross_point_y = cross_y((-uwb(1,i)), odb(1,j), uwb(2,i), odb(2,j), cross_point_x);
                blocked_path_v2(i, j, 4) = ray_tracing_v2(uwb(1,i), uwb(2,i), odb(1,j), odb(2,j), obj_x, obj_y, cross_point_x, cross_point_y);

                % odbicie względem prawej ściany
                cross_point_x = sizeX;
                cross_point_y = cross_y((2*sizeX - uwb(1,i)), odb(1,j), uwb(2,i), odb(2,j), cross_point_x);
                blocked_path_v2(i, j, 5) = ray_tracing_v2(uwb(1,i), uwb(2,i), odb(1,j), odb(2,j), obj_x, obj_y, cross_point_x, cross_point_y);
            end
        end
        if isequal(blocked_path, blocked_path_v2)
            rectangle('Position', [obj_x_v2 obj_y_v2 1 1], 'EdgeColor', 'yellow', 'LineWidth', 1);
        end
    end
end

function cross_point_x = cross_x(xa, xb, ya, yb, yc)
    cross_point_x = ((xa - xb)/(ya - yb)) * (yc - ya) + xa;
end

function cross_point_y = cross_y(xa, xb, ya, yb, xc)
    cross_point_y = ((ya - yb)/(xa - xb)) * (xc - xa) + ya;
end

function blocked_path = ray_tracing(uwb_x, uwb_y, odb_x, odb_y, obj_x, obj_y, cross_point_x, cross_point_y)
    res1 = wektorsektor(uwb_x, uwb_y, cross_point_x, cross_point_y, obj_x, obj_y, 1, 1);
    if res1 == 1 || res1 == 0
        line([uwb_x cross_point_x], [uwb_y cross_point_y], 'Color', 'red', 'LineWidth', 2);
        line([cross_point_x odb_x], [cross_point_y odb_y], 'Color', 'red', 'LineWidth', 2);
        blocked_path = 1;
    else
        res2 = wektorsektor(cross_point_x, cross_point_y, odb_x, odb_y, obj_x, obj_y, 1, 1);
        if res2 == 1 || res2 == 0
            line([uwb_x cross_point_x], [uwb_y cross_point_y], 'Color', 'red', 'LineWidth', 2);
            line([cross_point_x odb_x], [cross_point_y odb_y], 'Color', 'red', 'LineWidth', 2);
            blocked_path = 1;
        else
            line([uwb_x cross_point_x], [uwb_y cross_point_y], 'Color', 'green', 'LineWidth', 0.5);
            line([cross_point_x odb_x], [cross_point_y odb_y], 'Color', 'green', 'LineWidth', 0.5);
            blocked_path = 0;
        end
    end
end

function blocked_path_v2 = ray_tracing_v2(uwb_x, uwb_y, odb_x, odb_y, obj_x, obj_y, cross_point_x, cross_point_y)
    res1 = wektorsektor(uwb_x, uwb_y, cross_point_x, cross_point_y, obj_x, obj_y, 1, 1);
    if res1 == 1 || res1 == 0
        blocked_path_v2 = 1;
    else
        res2 = wektorsektor(cross_point_x, cross_point_y, odb_x, odb_y, obj_x, obj_y, 1, 1);
        if res2 == 1 || res2 == 0
            blocked_path_v2 = 1;
        else
            blocked_path_v2 = 0;
        end
    end
end