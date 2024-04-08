format long
a = 1;
b = 50;
max_iterations = 100;
ytolerance = 1e-12;

[omega_bisection,~,~,xtab_bisection,xdif_bisection] = bisection_method(a,b,max_iterations,ytolerance,@impedance_magnitude);

[omega_secant,~,~,xtab_secant,xdif_secant] = secant_method(a,b,max_iterations,ytolerance,@impedance_magnitude);

subplot(2,1,1);
plot(1:length(xtab_bisection),xtab_bisection);
hold on;
plot(1:length(xtab_secant),xtab_secant);
hold off
title('Kolejni kandydaci na omegę');
xlabel('Numer iteracji');
ylabel('Wartość kandydata');
legend('m. bisekcji','m. siecznych','Location','eastoutside');

subplot(2,1,2);
semilogy(1:length(xdif_bisection),xdif_bisection);
hold on;
semilogy(1:length(xdif_secant),xdif_secant);
hold off
title('Kolejni kandydaci na omegę');
xlabel('Numer iteracji');
ylabel('Roznica miedzy kolejnymi wartosciami');
legend('m. bisekcji','m. siecznych','Location','eastoutside');

% print -dpng zadanie4.png

function impedance_delta = impedance_magnitude(omega)

if omega <= 0
        error("Delta must be greater than zero!")
else
    R = 525;
    C = 7*10^-5;
    L = 3;
    M = 75; % docelowa wartość modułu impedancji
    
    
    Z = 1/sqrt(1/R^2+(omega*C-1/(omega*L))^2);
    
    impedance_delta = Z - M;
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
