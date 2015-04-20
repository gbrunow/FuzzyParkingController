function ds=truckmod(s,u,velocity) 
    % s(1) =x, s(2)=y, s(3)=f, u = q
    % Angles are in radians.
    
    % CONSTANTS
    L = 3.5; % Length of truck. 
    v = velocity; % Velocity of truck.

    % STATES
    pos = s(1) + sqrt(-1)*s(2);
    angle = s(3)+degtorad(90);
    
    % DERIVATIVES
    dpos = v*cos(u)*exp(j*(angle-pi/2));
    dangle = v*sin(u)/L;
    ds = [real(dpos) imag(dpos) dangle];
end