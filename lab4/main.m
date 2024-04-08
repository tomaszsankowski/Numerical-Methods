% omega = 10
% impedance_delta = impedance_magnitude(omega)

% format long
% f = @(x) x.^2 - 4.01;
% a = 1;
% b = 50;
% max_iterations = 100;
% ytolerance = 1e-12;
% [xsolution,ysolution,iterations,xtab,xdif] = bisection_method(a,b,max_iterations,ytolerance,@impedance_magnitude)

% format long
% f = @(x) x.^2 - 4.01;
% a = 1;
% b = 50;
% max_iterations = 100;
% ytolerance = 1e-12;
% [xsolution,ysolution,iterations,xtab,xdif] = secant_method(a,b,max_iterations,ytolerance,@impedance_magnitude)

% time = 10 ;
% velocity_delta = rocket_velocity(time)

N = 40000;
time_delta = estimate_execution_time(N)
