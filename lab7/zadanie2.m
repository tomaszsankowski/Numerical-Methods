function [integration_error, Nt, ft_5, integral_1000] = zadanie2()

    reference_value = 0.0473612919396179; % wartość referencyjna całki

    Nt = 5:50:10^4;
    integration_error = zeros(1, length(Nt));

    ft_5 = ft(5);
    integral_1000 = integration(@ft, 1000);

    for i = 1:length(Nt)
        integration_result = integration(@ft, Nt(i));
        integration_error(i) = abs(integration_result - reference_value);
    end

    figure;
    loglog(Nt, integration_error);
    xlabel('n');
    ylabel('Integration Error');
    title('Integration Error dla metody trapezów');
    grid on;

    print('zadanie2', '-dpng');
end

function [y] = ft(t)
    y = 1/(3*sqrt(2*pi))*exp(-(t-10)^2/(2*3^2));
end

function [integral] = integration(fun, N)
    indices = linspace(0, 5, N+1);
    delta_x = 5/N;
    integral = 0;
    prev_i = indices(1);
    for i=1:N
        integral = integral + delta_x * ( fun(prev_i) + fun(indices(i + 1)) ) / 2;
        prev_i = indices(i + 1);
    end
end