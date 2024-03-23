function plot_direct(N, vtime_direct)
    hold on
    title('Czas wyznaczenia rozwiązania w zależności od rozmiaru macierzy');
    xlabel('Rozmiar macierzy N');
    ylabel('Czas wyznaczenia rozwiązania (s)');
    plot(N, vtime_direct, '-o', 'LineWidth', 1.5, 'MarkerSize', 8);
    hold off
end
