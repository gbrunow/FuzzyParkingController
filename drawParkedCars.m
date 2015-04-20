function out = drawParkedCars(carL, carW)
    [xp, yp] = computeCarPoints(0 + (5-carL)/2, 25-1.5, 0);
    xp(end+1) = xp(1);
    yp(end+1) = yp(1);
    plot(xp,yp);
    [xp, yp] = computeCarPoints(5 + (5-carL)/2, 25-1.5, 0);
    xp(end+1) = xp(1);
    yp(end+1) = yp(1);
    plot(xp,yp);
    [xp, yp] = computeCarPoints(15 + (5-carL)/2, 25-1.5, 0);
    xp(end+1) = xp(1);
    yp(end+1) = yp(1);
    plot(xp,yp);
    [xp, yp] = computeCarPoints(20 + (5-carL)/2, 25-1.5, 0);
    xp(end+1) = xp(1);
    yp(end+1) = yp(1);
    plot(xp,yp);
    grid on;
    out = 1;
end