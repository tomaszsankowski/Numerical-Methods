#include <iostream>
#include <vector>
#include <cmath>
#include <chrono>
#include <iomanip>
#include <fstream>

struct Wynik
{
  double time;
  int iterations;
  double error;
};

void printMatrix(const std::vector<std::vector<double>>& m)
{
  for(int i = 0; i < m.size(); i++)
  {
    for(int j = 0; j < m.size(); j++)
    {
      if(m[i][j]>=0)
        std::cout << " ";
      std::cout << m[i][j] << "\t";
    }
    std::cout << std::endl;
  }
}


////////////////////////////////////////////////////
//////////////////    JACOBI    ////////////////////
////////////////////////////////////////////////////
///
///std::vector<double> solve_jacobi(const int N, const std::vector<double>& b, const std::vector<std::vector<double>>& m, const double err_norm, const int max_iterations)
Wynik solve_jacobi(const int N, const std::vector<double>& b, const std::vector<std::vector<double>>& m, const double err_norm, const int max_iterations)
{
  const auto start = std::chrono::high_resolution_clock::now();
  std::vector<double> errs_Jacobi;

  int iterations_Jacobi = -1;

  std::vector<double> x(N);
  std::vector<double> new_x(N);
  double err_Jacobi = 0;

  do
  {
    for(int i = 0; i < N; i++)
    {
      double sum = b[i];
      for(int j = 0; j < N; j++)
      {
        if(j != i)
          sum -= m[i][j]*x[j];
      }
      sum /= m[i][i];
      new_x[i] = sum;
    }
    x = new_x;
    // Calculate error
    double err_sum = 0;
    for(int i = 0; i < N; i++)
    {
      double tmp = 0;
      for(int j = 0; j < N; j++)
      {
        tmp += m[i][j]*x[j];
      }
      tmp -= b[i];
      err_sum += tmp*tmp;
    }
    err_Jacobi = sqrt(err_sum);
    iterations_Jacobi++;
    errs_Jacobi.push_back(err_Jacobi);

  }while(err_Jacobi > err_norm && iterations_Jacobi < max_iterations);

  const auto duration = std::chrono::high_resolution_clock::now() - start;
  const auto duration_seconds = std::chrono::duration<double>(duration).count();

  std::cout << "Jacoby's method:" << std::endl;
  std::cout << "Time: " << std::fixed << std::setprecision(2) << duration_seconds << " seconds" << std::endl;
  std::cout << "Iterations: " << iterations_Jacobi << std::endl;
  std::cout << "Error: " << std::scientific << err_Jacobi << std::endl << std::endl;

  return {duration_seconds, iterations_Jacobi, err_Jacobi};
  //return errs_Jacobi;
}


////////////////////////////////////////////////////
///////////////    GAUSS-SEIDEL    /////////////////
////////////////////////////////////////////////////

// std::vector<double> solve_gauss(const int N, const std::vector<double>& b, const std::vector<std::vector<double>>& m, const double err_norm, const int max_iterations)
Wynik solve_gauss(const int N, const std::vector<double>& b, const std::vector<std::vector<double>>& m, const double err_norm, const int max_iterations)
{
  const auto start = std::chrono::high_resolution_clock::now();

  std::vector<double> errs_Gauss;

  int iterations_Gauss = -1;

  std::vector<double> x_Gauss(N);
  double err_Gauss = 0;

  do
  {
    for(int i = 0; i < N; i++)
    {
      double sum = b[i];
      for(int j = 0; j < N; j++)
      {
        if(j != i)
          sum -= m[i][j]*x_Gauss[j];
      }
      sum /= m[i][i];
      x_Gauss[i] = sum;
    }
    // Calculate error
    double err_sum = 0;
    for(int i = 0; i < N; i++)
    {
      double tmp = 0;
      for(int j = 0; j < N; j++)
      {
        tmp += m[i][j]*x_Gauss[j];
      }
      tmp -= b[i];
      err_sum += tmp*tmp;
    }
    err_Gauss = sqrt(err_sum);
    iterations_Gauss++;
    errs_Gauss.push_back(err_Gauss);

  }while(err_Gauss > err_norm && iterations_Gauss < max_iterations);

  const auto duration = std::chrono::high_resolution_clock::now() - start;
  const auto duration_seconds = std::chrono::duration<double>(duration).count();

  std::cout << "Gauss-Seidel method:" << std::endl;
  std::cout << "Time: " << std::fixed << std::setprecision(2) << duration_seconds << " seconds" << std::endl;
  std::cout << "Iterations: " << iterations_Gauss << std::endl;
  std::cout << "Error: " << std::scientific << err_Gauss << std::endl << std::endl;

  return {duration_seconds, iterations_Gauss, err_Gauss};
  //return errs_Gauss;
}


////////////////////////////////////////////////////
////////////     LU FACTORIZATION     //////////////
////////////////////////////////////////////////////

Wynik solve_LU(const int N, const std::vector<double>& b, const std::vector<std::vector<double>>& m)
{
  const auto start = std::chrono::high_resolution_clock::now();

  std::vector<std::vector<double>> U = m;
  std::vector<std::vector<double>> L(N, std::vector<double>(N));
  for(int i = 0; i < N; i++)
  {
    L[i][i] = 1;
  }

  // Calculate L and U
  for(int i = 1; i < N; ++i)
  {
    for(int j = 0; j < i; ++j)
    {
      L[i][j] = U[i][j] / U[j][j];
      for(int k = j; k < N; ++k)
      {
        U[i][k] -= L[i][j] * U[j][k];
      }
    }
  }

  //printMatrix(L);
  //printMatrix(U);

  std::vector<double> y(N);
  std::vector<double> x(N);

  // Calculate y
  for(int i = 0; i < N; i++)
  {
    double sum = b[i];
    for(int j = 0; j < i; j++)
    {
      sum -= L[i][j]*y[j];
    }
    y[i] = sum / L[i][i];
  }

  // Calculate x
  for(int i = N-1; i >= 0; i--)
  {
    double sum = y[i];
    for(int j = i+1; j < N; j++)
    {
      sum -= U[i][j]*x[j];
    }
    x[i] = sum / U[i][i];
  }

  // Calculate error
  double err_sum = 0;
  for(int i = 0; i < N; i++)
  {
    double tmp = 0;
    for(int j = 0; j < N; j++)
    {
      tmp += m[i][j]*x[j];
    }
    tmp -= b[i];
    err_sum += tmp*tmp;
  }
  const double err = sqrt(err_sum);
  const auto duration = std::chrono::high_resolution_clock::now() - start;
  const auto duration_seconds = std::chrono::duration<double>(duration).count();


  std::cout << "LU factorization:" << std::endl;
  std::cout << "Time: " << std::fixed << std::setprecision(2) << duration_seconds << " seconds" << std::endl;
  std::cout << "Error: " << std::scientific << err << std::endl << std::endl;

  return {duration_seconds, 0, err};
}

////////////////////////////////////////////////////

/*
void exB(const int N, std::vector<double>& b, std::vector<std::vector<double>>& m)
{
  //////////////////////////////////////////////////////////// Zadanie B

  constexpr double err_norm = 0.000000001;
  constexpr int max_iterations = 100;

  std::vector<double> errs_Jacobi = solve_jacobi(N, b, m, err_norm, max_iterations);
  std::vector<double> errs_Gauss = solve_gauss(N, b, m, err_norm, max_iterations);

  std::ofstream err_file("jacobi_errors1.csv");
  for(const auto err : errs_Jacobi)
  {
    err_file << err << std::endl;
  }
  err_file.close();
  std::ofstream errfile("gauss_errors1.csv");
  for(const auto err : errs_Gauss)
  {
    errfile << err << std::endl;
  }
  errfile.close();

}
*/

/*
void exCandD()
{

  constexpr int N = 963; // 963

  constexpr int a2 = -1;
  constexpr int a3 = -1;
  std::vector<double> b(N);

  for(int i = 0; i < N; ++i)
  {
    b[i] = sin((i+1)*(3+1));
  }

  std::vector<std::vector<double>> m(N, std::vector<double>(N));

  for(int i = 0; i < N; ++i)
  {
    constexpr int a1 = 3;
    m[i][i] = a1;
    if(i<N-1)
    {
      m[i+1][i] = a2;
      m[i][i+1] = a2;
    }
    if(i<N-2)
    {
      m[i+2][i] = a3;
      m[i][i+2] = a3;
    }
  }

  constexpr double err_norm = 0.000000001;
  constexpr int max_iterations = 100;


  //////////////////////////////////////////////////////////// Zadanie C

  std::vector<double> errs_Jacobi = solve_jacobi(N, b, m, err_norm, max_iterations);
  std::vector<double> errs_Gauss = solve_gauss(N, b, m, err_norm, max_iterations);

  std::ofstream err_file("jacobi_errors2.csv");
  for(const auto err : errs_Jacobi)
  {
    err_file << err << std::endl;
  }
  err_file.close();
  std::ofstream errfile("gauss_errors2.csv");
  for(const auto err : errs_Gauss)
  {
    errfile << err << std::endl;
  }
  errfile.close();


  //////////////////////////////////////////////////////////// Zadanie D

  solve_LU(N, b, m);
}
*/

////////////////////////////////////////////////////
//////////////////     MAIN     ////////////////////
////////////////////////////////////////////////////

int main() {

  // exB();

  // exCandD();

  const int Ns[] = {100, 500, 1000, 2000, 3000, 5000, 7000, 10000};

  std::ofstream time_file("completion_times.csv");
  time_file << "N,Jacobi,Gauss-Seidel,LU\n";

  std::vector<Wynik> wyniki_jacobi;
  std::vector<Wynik> wyniki_gauss;
  std::vector<Wynik> wyniki_lu;

  for(const auto n : Ns)
  {
    constexpr int a1 = 5 + 3;
    constexpr int a2 = -1;
    constexpr int a3 = -1;
     int N = n;
    std::vector<double> b(N);
    for(int i = 0; i < N; ++i)
    {
      b[i] = sin((i+1)*(3+1));
      //std::cout << b[i] << std::endl;
    }

    std::vector<std::vector<double>> m(N, std::vector<double>(N));

    for(int i = 0; i < N; ++i)
    {
      m[i][i] = a1;
      if(i<N-1)
      {
        m[i+1][i] = a2;
        m[i][i+1] = a2;
      }
      if(i<N-2)
      {
        m[i+2][i] = a3;
        m[i][i+2] = a3;
      }
    }
    Wynik wynik_jacobi = solve_jacobi(n, b, m, 0.000000001, 100);
    Wynik wynik_gauss = solve_gauss(n, b, m, 0.000000001, 100);
    Wynik wynik_lu = solve_LU(n, b, m);

    time_file << n << ","
              << wynik_jacobi.time << ","
              << wynik_gauss.time << ","
              << wynik_lu.time << "\n";

    wyniki_jacobi.push_back(wynik_jacobi);
    wyniki_gauss.push_back(wynik_gauss);
    wyniki_lu.push_back(wynik_lu);
  }

  time_file.close();

  std::cout << std::setw(10) << "N"
            << std::setw(15) << "Jacobi Time"
            << std::setw(15) << "Jacobi Error"
            << std::setw(20) << "Gauss-Seidel Time"
            << std::setw(20) << "Gauss-Seidel Error"
            << std::setw(15) << "LU Time"
            << std::setw(15) << "LU Error"
            << std::endl;

  for(int i = 0; i < wyniki_jacobi.size(); ++i)
  {
    std::cout << std::setw(10) << Ns[i]
              << std::setw(15) << wyniki_jacobi[i].time
              << std::setw(15) << wyniki_jacobi[i].error
              << std::setw(20) << wyniki_gauss[i].time
              << std::setw(20) << wyniki_gauss[i].error
              << std::setw(15) << wyniki_lu[i].time
              << std::setw(15) << wyniki_lu[i].error
              << std::endl;
  }

  return 0;
}
