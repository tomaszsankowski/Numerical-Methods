function [A,b,M,bm,x,err_norm,time,iterations,index_number] = solve_Jacobi(N)
% A - macierz z równania macierzowego A * x = b
% b - wektor prawej strony równania macierzowego A * x = b
% M - macierz pomocnicza opisana w instrukcji do Laboratorium 3 – sprawdź wzór (5) w instrukcji, który definiuje M jako M_J.
% bm - wektor pomocniczy opisany w instrukcji do Laboratorium 3 – sprawdź wzór (5) w instrukcji, który definiuje bm jako b_{mJ}.
% x - rozwiązanie równania macierzowego
% err_norm - norma błędu residualnego wyznaczona dla rozwiązania x; err_norm = norm(A*x-b)
% time - czas wyznaczenia rozwiązania x
% iterations - liczba iteracji wykonana w procesie iteracyjnym metody Jacobiego
% index_number - Twój numer indeksu
index_number = 193363;
L1 = 3;

[A,b] = generate_matrix(N, L1);

L = tril(A, -1);
U = triu(A, 1);
D = diag(diag(A));

M = -D \ (L+U);
bm = D \ b;

iterations = -1;
err_norm = 1;

x = ones(N,1);
tic
while iterations<1000 && err_norm>0.00000000001
    x_prev = x;
    x = M*x_prev + bm;
    err_norm = norm(A*x-b);
    iterations = iterations + 1;
end
time = toc;
end
