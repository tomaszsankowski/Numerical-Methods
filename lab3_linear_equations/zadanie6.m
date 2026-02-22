load('filtr_dielektryczny.mat');

N = length(A);

% direct method
tic

x_direct = A\b;

time_direct = toc;
err_direct = norm(A*x_direct - b);

% Jacobi method

L = tril(A, -1);
U = triu(A, 1);
D = diag(diag(A));

M = -D \ (L+U);
bm = D \ b;

iterations = -1;
err_Jacobi = zeros(1,1002);
err_Jacobi(1) = 1;
x = ones(N,1);
tic
while iterations<1000 && err_Jacobi(iterations+2) > 0.000000000001
    x_prev = x;
    x = M*x_prev + bm;
    iterations = iterations + 1;
    err_Jacobi(iterations+2) = norm(A*x-b);
end
time_Jacobi = toc;

% Gauss-Seidel method

L = tril(A, -1);
U = triu(A, 1);
D = diag(diag(A));

M = - (D + L) \ U;
bm = (D + L) \ b;

iterations = -1;
err_Gauss = zeros(1,1002);
err_Gauss(1) = 1;
x = ones(N,1);
tic
while iterations<1000 && err_Gauss(iterations+2) > 0.000000000001
    x_prev = x;
    x = M*x_prev + bm;
    iterations = iterations + 1;
    err_Gauss(iterations+2) = norm(A*x-b);
end
time_Gauss = toc;

subplot(2,1,1);

plot(err_Jacobi);
title('Norma błędu residualnego: Jacobiego');
xlabel('Błąd');
ylabel('Iteracje');

subplot(2,1,2);

plot(err_Gauss);
title('Norma błędu residualnego: Gaussa-Seidela');
xlabel('Błąd');
ylabel('Iteracje');

time_direct
time_Jacobi
time_Gauss