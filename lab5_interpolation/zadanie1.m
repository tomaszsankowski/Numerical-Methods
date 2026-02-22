function [V, original_Runge, original_sine, interpolated_Runge, interpolated_sine] = zadanie1()
% Rozmiar tablic komórkowych (cell arrays) V, interpolated_Runge, interpolated_sine: [1,4].
% V{i} zawiera macierz Vandermonde wyznaczoną dla liczby węzłów interpolacji równej N(i)
% original_Runge - wektor wierszowy zawierający wartości funkcji Runge dla wektora x_fine=linspace(-1, 1, 1000)
% original_sine - wektor wierszowy zawierający wartości funkcji sinus dla wektora x_fine
% interpolated_Runge{i} stanowi wierszowy wektor wartości funkcji interpolującej 
%       wyznaczonej dla funkcji Runge (wielomian stopnia N(i)-1) w punktach x_fine
% interpolated_sine{i} stanowi wierszowy wektor wartości funkcji interpolującej
%       wyznaczonej dla funkcji sinus (wielomian stopnia N(i)-1) w punktach x_fine
    N = 4:4:16;
    x_fine = linspace(-1, 1, 1000);
    original_Runge = runge_function(x_fine);

    subplot(2,1,1);
    plot(x_fine, original_Runge);
    title('Funkcja Rungego')
    xlabel('x');
    ylabel('y');
    hold on;
    for i = 1:length(N)
        V{i} = vandermonde_matrix(N(i));% macierz Vandermonde
        % węzły interpolacji
        x_coarse = linspace(-1, 1, N(i));
        b = runge_function(x_coarse)';
        % wartości funkcji interpolowanej w węzłach interpolacji
        c_runge = V{i} \ b; % współczynniki wielomianu interpolującego
        % interpolated_Runge{i} = polyval(flipud(c_runge), x_fine); % interpolacja
        interpolated_Runge{i} = polyval(flipud(c_runge), x_fine);
        plot(x_fine, interpolated_Runge{i});
    end
    hold off
    legend('Oryginalna', 'N=4', 'N=8', 'N=12', 'N=16', 'Location', 'northeast');

    original_sine = sin(2 * pi * x_fine);
    subplot(2,1,2);
    hold on;
    title('Funkcja sinus')
    xlabel('x');
    ylabel('y');
    plot(x_fine, original_sine);
    for i = 1:length(N)
        x_coarse = linspace(-1, 1, N(i));
        b = my_sinus(x_coarse)';
        c_runge = V{i} \ b;
        interpolated_sine{i} = polyval(flipud(c_runge), x_fine);
        plot(x_fine, interpolated_sine{i});
    end
    hold off
    legend('Oryginalna', 'N=4', 'N=8', 'N=12', 'N=16', 'Location', 'northeast');

    % print -dpng zadanie1.png
end

function y = my_sinus(x)
    y = sin(2*pi*x);
end

function y = runge_function(x)
    y = 1 ./ (1 + 25 * x .^ 2);
end

function V = vandermonde_matrix(N)
    % Generuje macierz Vandermonde dla N równomiernie rozmieszczonych w przedziale [-1, 1] węzłów interpolacji
    x_coarse = linspace(-1,1,N);
    V = zeros(N, N);

    for i = 1:N
        for j = 1:N
            V(i, j) = x_coarse(i) ^ (j - 1);
        end
    end
end