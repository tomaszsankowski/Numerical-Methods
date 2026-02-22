import pandas as pd
import matplotlib.pyplot as plt

# Exercise B

jacobi_errors = pd.read_csv('jacobi_errors1.csv', header=None)
gauss_errors = pd.read_csv('gauss_errors1.csv', header=None)

plt.figure(figsize=(10,6))
plt.semilogy(jacobi_errors[0], label='Błędy Jacobi')
plt.semilogy(gauss_errors[0], label='Błędy Gauss-Seidel')
plt.title('[Zadanie B]: Porównanie błędów metod Jacobi i Gauss-Seidel')
plt.xlabel('Iteracje')
plt.ylabel('Błąd')
plt.legend()
plt.grid(True)
plt.show()

# Exercise C

jacobi_errors = pd.read_csv('jacobi_errors2.csv', header=None)
gauss_errors = pd.read_csv('gauss_errors2.csv', header=None)

plt.figure(figsize=(10,6))
plt.semilogy(jacobi_errors[0], label='Błędy Jacobi')
plt.semilogy(gauss_errors[0], label='Błędy Gauss-Seidel')
plt.title('[Zadanie C]: Porównanie błędów metod Jacobi i Gauss-Seidel')
plt.xlabel('Iteracje')
plt.ylabel('Błąd')
plt.legend()
plt.grid(True)
plt.show()

# Exercise E

data = pd.read_csv('completion_times.csv')

plt.figure(figsize=(10,6))
plt.plot(data['N'], data['Jacobi'], label='Jacobi')

plt.plot(data['N'], data['Gauss-Seidel'], label='Gauss-Seidel')

plt.plot(data['N'], data['LU'], label='LU')

plt.title('[Zadanie E]: Czas wykonania dla różnych metod')
plt.xlabel('Rozmiar macierzy')
plt.ylabel('Czas wykonania')
plt.legend()
plt.grid(True)
plt.show()