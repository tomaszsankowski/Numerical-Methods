clear all
close all
format compact

n_max = 200;
a = 40;
r_max = a/2;

[numer_indeksu, Edges, I, B, A, b, r] = page_rank();
I
plot_PageRank(r)
% [circles, index_number, circle_areas, rand_counts, counts_mean] = generate_circles(a, r_max, n_max);
% plot_counts_mean(counts_mean);
% figure
% circle_areas;
% counts_mean;
% plot_circle_areas(circle_areas);
% figure
% plot_circles(a,circles,index_number)
% circles
% print -dpng zadanie1.png 