function [integration_error, Nt, ft_5, xr, yr, yrmax] = zadanie4()

    reference_value = 0.0473612919396179; % wartość referencyjna całki

    Nt = 5:50:10^4;
    integration_error = zeros(1, length(Nt));

    ft_5 = ft(5);
    
    xr = cell(1, length(Nt));
    yr = cell(1, length(Nt));

    yrmax = ft_5 + 0.001;

    for i = 1:length(Nt)
        [integration_result, xr{i}, yr{i}] = integration(@ft, Nt(i), yrmax);
        integration_error(i) = abs(integration_result - reference_value);
    end

    figure;
    loglog(Nt, integration_error);
    xlabel('n');
    ylabel('Integration Error');
    title('Integration Error dla metody Monte Carlo');
    grid on;

    print('zadanie4', '-dpng');
end

function [y] = ft(t)
    y = 1/(3*sqrt(2*pi))*exp(-(t-10)^2/(2*3^2));
end

function [integral, xr, yr] = integration(fun, N, yrmax)
    xr = zeros(1, N);
    yr = zeros(1, N);
    N1 = 0;
    S = yrmax * 5;
    for i=1:N
        x = rand() * 5;
        y = rand() * yrmax;
        xr(1,i) = x;
        yr(1,i) = y;
        if y <= fun(x)
            N1 = N1 + 1;
        end
    end
    integral = N1 * S / N;
end