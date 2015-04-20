function [ out ] = carParking(x, y, theta, trace)
    carL=3.5;    %car length 
    carW=1.7;    %car width 
    xT1 = 10-(5-carL)/2-2;
    yT1 = 19.85 + carW/2;
    xT2 = 15-(5-carL)/2;
    yT2 = 25 - 1.5;

    Controller1 = readfis('PositioningController');
    Controller2 = readfis('ParallelParkingController');
    
    s = [x y degtorad(theta)];

    [xp, yp] = computeCarPoints(s(1), s(2), radtodeg(s(3)));
    for i=1:4
       if xp(i) > 25 || xp(i)<0 || yp(i) > 22.5 || yp(i) <0
           disp('Invalid car location.');
           out = 0;
           return;
       end
    end
    xp(end+1) = xp(1);
    yp(end+1) = yp(1);
    plot(xp,yp);
    hold on;

    %assume time step = 0.2 second
    dt = 0.2;
    i = 0;
    j = 0;
    answer = [0 0];
    % while s(1)<25 && s(2)<25 
    while (abs(s(1)-xT1)>0.025 || abs(s(2)-yT1)>1 || abs(abs(radtodeg(s(3)))-180)>3) && (s(1)<25 || s(2)<25) && s(1)>0 && s(2)>0

        %[s(1) s(2) radtodeg((3))]
        i = i + 1;
        if rem(i,10) == 1
            % Evaluate controller once a second % (5 time steps *0.2 seconds)
            if radtodeg(s(3)) > 180
                s(3) = degtorad(360) - s(3);
            elseif radtodeg(s(3)) < -180
                s(3) = degtorad(360) + s(3);
            end
            answer = evalfis([radtodeg(s(3)) s(1) s(2)], Controller1);
            theta = degtorad(answer(1));
        end
        s = s + dt*truckmod(s,theta, 0.25);
        path(i,1:3) = s;
        if rem(i,5) == 1
            %[s(1) s(2) radtodeg(s(3))]
            j = j+1;
            %----- Draw Target -----%
            [xp, yp] = computeCarPoints(xT1, yT1, 180);
            xp(end+1) = xp(1);
            yp(end+1) = yp(1);
            plot(xp,yp, 'r+');
            hold on;
            plot(xT1, yT1, 'bo');
            %----- Drawing End -----%

            [xp, yp] = computeCarPoints(s(1), s(2), radtodeg(s(3)));
            carX(j,:) = xp;
            carY(j,:) = yp;
            xp(end+1) = xp(1);
            yp(end+1) = yp(1);
            plot(xp,yp);
            plot(s(1),s(2), 'ro');
            drawParkedCars(carL, carW);
            if trace == 1
                plot(path(:,1),path(:,2),'r');
                plot(carX(:,[2 3]),carY(:,[2 3]),'c');
                plot(carX(:,[1 4]),carY(:,[1 4]),'g');
            end;
            plot(0:25,ones(26)*22.5, 'm--');
            hold off;
            xlim([0 25]);
            ylim([0 25]);
            grid on;
            drawnow;
        end
    end
    
    %------- Controler 2 ---------%
    theta = degtorad(0);
    %s = [xT1 yT1 degtorad(180)];
    [xp, yp] = computeCarPoints(s(1), s(2), radtodeg(s(3))); %reference point at the back of the car
    xp(end+1) = xp(1);
    yp(end+1) = yp(1);
    plot(xp,yp);
    hold on;

    %assume time step = 0.2 second
    dt = 0.2;
    while (abs(s(1)-xT2)>0.25 || abs(s(2)-yT2)>0.25 || abs(abs(radtodeg(s(3)))-180)>2) && s(1)<15.5 && s(2)<25-1.1*carW/2  && (s(1)<25 || s(2)<25) && s(1)>0 && s(2)>0  
        if rem(i,5) == 1
            % Evaluate controller once a second % (5 time steps *0.2 seconds)
            theta = degtorad(evalfis([s(1) s(2) radtodeg(s(3))], Controller2));
            %radtodeg(theta)
        end
        s = s + dt*truckmod(s,theta, -0.1);
        i = i + 1;
        path(i,1:3) = s;
        if rem(i,5) == 1
            j = j+1;
            %----- Draw Target -----%
            [xp, yp] = computeCarPoints(xT2, yT2, 180);
            xp(end+1) = xp(1);
            yp(end+1) = yp(1);
            plot(xp,yp, 'r+');
            hold on;
            plot(xT2, yT2, 'bo');
            %----- Drawing End -----%

            [xp, yp] = computeCarPoints(s(1), s(2), radtodeg(s(3)));
            carX(j,:) = xp;
            carY(j,:) = yp;
            xp(end+1) = xp(1);
            yp(end+1) = yp(1);
            plot(xp,yp);
            plot(s(1),s(2), 'ro');
            drawParkedCars(carL, carW);
            if trace == 1
                plot(path(:,1),path(:,2),'r');
                plot(carX(:,[2 3]),carY(:,[2 3]),'c');
                plot(carX(:,[1 4]),carY(:,[1 4]),'g');
            end
            plot(0:25,ones(26)*22.5, 'm--');
            hold off;
            xlim([0 25]);
            ylim([0 25]);
            grid on;
            drawnow;
        end
    end
    
    while s(1)>10.5+carL
        i = i + 1;
        j = j + 1;
        s = s + dt*truckmod(s,degtorad(-10), 0.5);
        path(i,1:3) = s;
        [xp, yp] = computeCarPoints(s(1), s(2), radtodeg(s(3)));
        carX(j,:) = xp;
        carY(j,:) = yp;
        xp(end+1) = xp(1);
        yp(end+1) = yp(1);
        plot(xp,yp);
        hold on;
        plot(s(1),s(2), 'ro');
        drawParkedCars(carL, carW);
        if trace == 1
            plot(path(:,1),path(:,2),'r');
            plot(carX(:,[2 3]),carY(:,[2 3]),'c');
            plot(carX(:,[1 4]),carY(:,[1 4]),'g');
        end
        plot(0:25,ones(26)*22.5, 'm--');
        hold off;
        xlim([0 25]);
        ylim([0 25]);
        grid on;
        drawnow;
    end
    [xp, yp] = computeCarPoints(s(1), s(2), radtodeg(s(3)));
    xp(end+1) = xp(1);
    yp(end+1) = yp(1);
    plot(xp,yp);
    hold on;
    plot(s(1),s(2), 'ro');
    drawParkedCars(carL, carW);
    if trace == 1
        plot(path(:,1),path(:,2),'r');
        plot(carX(:,[2 3]),carY(:,[2 3]),'c');
        plot(carX(:,[1 4]),carY(:,[1 4]),'g');
    end;
    plot(0:25,ones(26)*22.5, 'm--');
    hold off;
    xlim([0 25]);
    ylim([0 25]);
    grid on;
    drawnow;
    
    out = 1;
end

