function [nodes_Chebyshev, V, V2, original_Runge, interpolated_Runge, interpolated_Runge_Chebyshev] = zadanie2()
% nodes_Chebyshev - wektor wierszowy zawierający N=16 węzłów Czebyszewa drugiego rodzaju
% V - macierz Vandermonde obliczona dla 16 węzłów interpolacji rozmieszczonych równomiernie w przedziale [-1,1]
% V2 - macierz Vandermonde obliczona dla węzłów interpolacji zdefiniowanych w wektorze nodes_Chebyshev
% original_Runge - wektor wierszowy zawierający wartości funkcji Runge dla wektora x_fine=linspace(-1, 1, 1000)
% interpolated_Runge - wektor wierszowy wartości funkcji interpolującej określonej dla równomiernie rozmieszczonych węzłów interpolacji
% interpolated_Runge_Chebyshev - wektor wierszowy wartości funkcji interpolującej wyznaczonej
%       przy zastosowaniu 16 węzłów Czebyszewa zawartych w nodes_Chebyshev 
    N = 16;
    x_fine = linspace(-1, 1, 1000);
    nodes_Chebyshev = get_Chebyshev_nodes(N);

    original_Runge = runge_function(x_fine);

    x_coarse = linspace(-1,1,N);
    
    V = vandermonde_matrix(x_coarse, N);
    V2 = vandermonde_matrix(nodes_Chebyshev, N);

    b = runge_function(x_coarse)';

    subplot(2,1,1);
    plot(x_fine, original_Runge);
    title('Funkcja Rungego')
    xlabel('x');
    ylabel('y');
    hold on;
    c_runge = V \ b;
    interpolated_Runge = polyval(flipud(c_runge), x_fine);
    plot(x_fine, interpolated_Runge);
    plot(x_coarse, b, 'o')
    hold off;
    legend('Oryginalna', 'Interpolowana', 'Location', 'northeast');

    subplot(2,1,2);
    plot(x_fine, original_Runge);
    title('Funkcja Rungego - Chebyshev nodes')
    xlabel('x');
    ylabel('y');
    hold on;
    b_Chebyshev = runge_function(nodes_Chebyshev)';
    c_runge_Chebyshev = V2 \ b_Chebyshev;
    interpolated_Runge_Chebyshev = polyval(flipud(c_runge_Chebyshev), x_fine);
    plot(x_fine, interpolated_Runge_Chebyshev);
    plot(nodes_Chebyshev, b_Chebyshev, 'o')
    hold off;
    legend('Oryginalna', 'Interpolowana', 'Location', 'northeast')


    % print -dpng zadanie2.png
end

function y = runge_function(x)
    y = 1 ./ (1 + 25 * x .^ 2);
end

function V = vandermonde_matrix(x_coarse, N)
    % Generuje macierz Vandermonde dla N równomiernie rozmieszczonych w przedziale [-1, 1] węzłów interpolacji
    V = zeros(N, N);

    for i = 1:N
        for j = 1:N
            V(i, j) = x_coarse(i) ^ (j - 1);
        end
    end
end

function nodes = get_Chebyshev_nodes(N)
    % oblicza N węzłów Czebyszewa drugiego rodzaju

    nodes = zeros(1, N);

    for k = 0:(N-1)
        nodes(k+1) = cos(k*pi/(N-1));
    end
end