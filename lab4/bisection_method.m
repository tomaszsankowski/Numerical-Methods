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
