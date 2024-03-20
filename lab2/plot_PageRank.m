function plot_PageRank(r)
hold on
title("Ranking stron internetowych używając PageRank")
xlabel("Numer strony")
ylabel("Wartość współczynnika PageRank")
bar(r)
hold off
% print -dpng zadanie7.png 
end
