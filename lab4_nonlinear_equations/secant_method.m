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
