function [integration_error, Nt, ft_5, integral_1000] = zadanie3()

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
    title('Integration Error dla metody Simpsona');
    grid on;

    print('zadanie3', '-dpng');
end

function [y] = ft(t)
    y = 1/(3*sqrt(2*pi))*exp(-(t-10)^2/(2*3^2));
end

function [integral] = integration(fun, N)
    indices = linspace(0, 5, N+1);
    delta_x = 5/N;
    integral = 0;
    prev_i = 1;
    for i=2:N+1
        x_i = indices(prev_i);
        x_ipo = indices(i);
        integral = integral + fun(x_i) + 4 * fun((x_ipo + x_i) / 2) + fun(x_ipo);
        prev_i = i;
    end
    integral = integral * delta_x / 6;
end