function plot_direct(N, vtime_direct)
    plot(N, vtime_direct, "-");
    title('Czas wyznaczenia rozwiązania w zależności od rozmiaru macierzy');
    xlabel('Rozmiar macierzy N');
    ylabel('Czas wyznaczenia rozwiązania (s)');
    % print -dpng zadanie2.png
end
