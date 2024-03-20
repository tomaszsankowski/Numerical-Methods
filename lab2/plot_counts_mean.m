function plot_counts_mean(counts_mean)
hold on
xlabel("pierwsze x pól")
ylabel("suma pól")
title("wykres wektora circle areas")
plot(counts_mean)
hold off
print -dpng zadanie3.png  
end
