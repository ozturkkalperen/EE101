function bouncing_ball(x0)
    % This function takes an initial state vector as argument 
    % and simulates the planar motion of a ball under the 
    % effect of gravity
    %
    % arguments - x0: initial state vector in the form of [x; vx; y; vy]
    %
    % Example: bouncing_ball([0.6; 0.8; 10; 3.5])

   
    % Parameters
    r = 0.2;    %m      - Ball radius
    g = 9.81;   %kgm/s2 - Gravitational acceleration
    dt = 0.01;  %s      - Time step size
    tf = 20;    %s      - Simulation length in time
    cor = 0.85; %       - Coefficient of restitution for concrete

    % Initialize a matrix to store ball's state at each time step
    states = [];
    
    % Surface normal for flat surface
    n = [0;1];

    % Discrete time state space representation
    A = [1 dt 0 0; 0 1 0 0; 0 0 1 dt; 0 0 0 1];
    b = g*[0; 0; -0.5*dt^2; -dt];
    
    for i=1:dt:tf
        xnew = A*x0 + b;                           % State transition from step k to step k+1
        states = [states xnew];                    % Add the newly calculated state to the state matrix
        if xnew(3) <= r                            % Check if the ball hits the surface
            vel = [x0(2);x0(4)];                   % Velocity vector just before collision
            rvel = cor*(vel - 2*dot(vel,n)*n);     % Reflected velocity vector with inelastic collision
            x0 = [x0(1); rvel(1); x0(3); rvel(2)]; % Ball's state right after collision 
        else
            x0 = xnew;                             % Set the current state as the initial state for 
        end                                        % the next step during flight
        
    end

    % Execute the animation function
    animate_scene(states,r,dt)
end

function animate_scene(states,r,dt)
    % This function takes the ball's center of mass coordinates and 
    % radius of the ball as arguments and animates the scenario given 
    % a time step
    
    figure('WindowState','maximized')   % Initialize the figure window maximized
    hold on                            % hold the current figure and add new plots
    axis equal                         % Make the plot axes equal
    xlim([0 40])                       % Set the limits on x axis
    ylim([-0.5 20])                    % Set the limits on y axis
    line([0 40],[0 0],'LineWidth',3)   % Draw a line 
    al = animatedline;                 % Generate a dynamic line to draw ball's trajectory

    for j=1:size(states,2)                         % Iterate in a for loop with the number of state vectors
        [c,f] = circle(states(1,j),states(3,j),r); % Draw the ball with a custom function
        addpoints(al,states(1,j),states(3,j))      % Add points to the CoM trajectory
        pause(dt)                                  % Pause for the time step size
        delete(c)                                  % Draw and delete the ball at each time step 
        delete(f)                                  % to make it behave as if it is floating in the air
    end
end

function [h,f] = circle(x,y,r)
    % This function takes the ball's center of mass coordinates and
    % radius of the ball as arguments and draws a colored circle

    th = 0:pi/50:2*pi;           % n number of angles from 0 to 360 deg
    xunit = r * cos(th) + x;     % Generate n points on top of x coordinate of ball's CoM
    yunit = r * sin(th) + y;     % Generate n points on top of y coordinate of ball's CoM
    h = plot(xunit, yunit,'k');  % Plot n points whose x-y coordinates are given above
    f= fill(xunit,yunit,'r');     % Fill the 2-D polygon defined by vectors x and y with red color
end