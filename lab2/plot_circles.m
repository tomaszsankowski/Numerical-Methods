function plot_circles(a, circles, index_number)
    hold on
    title(index_number)
    axis equal % wyrównanie skali
    axis([0 a 0 a]) % ograniczanie wyświetlanego obszaru
    L1 = mod(index_number,10);
    if(mod(L1,2)==0)
        for i=1:height(circles)
            plot_circle(circles(i,1),circles(i,2),circles(i,3))
            % pause(0.1)
        end
    else
        for i=1:length(circles)
            plot_circle(circles(1,i),circles(2,i),circles(3,i))
            % pause(0.1)
        end
    end
    hold off
end
