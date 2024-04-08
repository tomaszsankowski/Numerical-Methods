format long
a = 1;
b = 50;
max_iterations = 100;
ytolerance = 1e-12;

[time_bisection,~,~,xtab_bisection,xdif_bisection] = bisection_method(a,b,max_iterations,ytolerance,@rocket_velocity);

[time_secant,~,~,xtab_secant,xdif_secant] = secant_method(a,b,max_iterations,ytolerance,@rocket_velocity);

subplot(2,1,1);
plot(1:length(xtab_bisection),xtab_bisection);
hold on;
plot(1:length(xtab_secant),xtab_secant);
hold off
title('Kolejni kandydaci na t');
xlabel('Numer iteracji');
ylabel('Wartość kandydata [s]');
legend('m. bisekcji','m. siecznych','Location','eastoutside');

subplot(2,1,2);
semilogy(1:length(xdif_bisection),xdif_bisection);
hold on;
semilogy(1:length(xdif_secant),xdif_secant);
hold off
title('Kolejna roznica przyblizen t');
xlabel('Numer iteracji');
ylabel('Roznica miedzy kolejnymi przyblizeniami');
legend('m. bisekcji','m. siecznych','Location','eastoutside');

% print -dpng zadanie6.png

function velocity_delta = rocket_velocity(t)

% velocity_delta - różnica pomiędzy prędkością rakiety w czasie t oraz zadaną prędkością M
% t - czas od rozpoczęcia lotu rakiety dla którego ma być wyznaczona prędkość rakiety

if t <= 0
        error("Time must be greater than zero!")
else
    M = 750; % [m/s]
    m0 = 150000; % [kg]
    u = 2000; % [m/s]
    q = 2700; % [kg/s]
    g = 1.622; % [m/s^2]
    
    Z = u * log(m0/(m0-q*t))-g*t;
    
    velocity_delta = Z - M;
end

end

function [xsolution,ysolution,iterations,xtab,xdif] = bisection_method(a,b,max_iterations,ytolerance,fun)
iterations = 0;
r = a;
l = b;
c = (r+l)/2;
xtab = [];
while iterations <= max_iterations && abs(fun(c)) > ytolerance
    c = (l+r)/2;
    if fun(l)*fun(c) < 0
        r = c;
    else
        l = c;
    end
    iterations = iterations + 1;
    xtab = [xtab ; c];
end

xdif = abs(diff(xtab));
xsolution = c;
ysolution = fun(c);
end

function [xsolution,ysolution,iterations,xtab,xdif] = secant_method(a,b,max_iterations,ytolerance,fun)

iterations = 1;
xtab = [a ; b];
xk = xtab(iterations+1);
xkm1 = xtab(iterations);
newx = xk - fun(xk)*(xk-xkm1)/(fun(xk)-fun(xkm1));
xtab = [xtab ; newx];

while iterations < max_iterations && abs(fun(newx)) > ytolerance
    iterations = iterations + 1;
    xk = xtab(iterations+1);
    xkm1 = xtab(iterations);
    newx = xk - fun(xk)*(xk-xkm1)/(fun(xk)-fun(xkm1));
    xtab = [xtab ; newx];
end

xtab = xtab(3:end);
xdif = abs(diff(xtab));
xsolution = newx;
ysolution = fun(xsolution);


end
