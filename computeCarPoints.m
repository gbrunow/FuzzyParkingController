function [ x_points, y_points ] = computeCarPoints(x0, y0, angle)
    % CARPOINTS Figure out the 4 points that define the rectangular car
    % angle is defined in degrees

    angleRadians = angle*pi/180; %change the axis

    carL=3.5;    %car length 
    carW=1.7;     %car width 

    x1=x0+rotateX(0,carW/2,angleRadians);
    y1=y0+rotateY(0,carW/2,angleRadians);

    x2=x0+rotateX(carL,carW/2,angleRadians);
    y2=y0+rotateY(carL,carW/2,angleRadians);

    x3=x0+rotateX(carL,-carW/2,angleRadians);
    y3=y0+rotateY(carL,-carW/2,angleRadians);

    x4=x0+rotateX(0,-carW/2,angleRadians);
    y4=y0+rotateY(0,-carW/2,angleRadians);

    x_points = [x1 x2 x3 x4];
    y_points = [y1 y2 y3 y4];
end