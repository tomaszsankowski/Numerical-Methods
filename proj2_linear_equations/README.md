# Project 2: Solving Systems of Linear Equations

This mini-project contains a C++ program for solving large systems of linear equations using Jacobi and Gauss-Seidel iterative methods. It also includes Python scripts for visualizing the results.

## Contents

- `main.cpp`: Main C++ program implementing the Jacobi and Gauss-Seidel methods.
- `CMakeLists.txt`: CMake configuration file for building the C++ project.
- `wykresyPython/`: Directory containing Python scripts (`main.py`) and CSV files (`completion_times.csv`, `gauss_errors1.csv`, etc.) for plotting the results.

## How to run

1. Build the C++ project using CMake:
   ```bash
   mkdir build && cd build
   cmake ..
   make
   ```
2. Run the compiled executable.
3. To visualize the results, navigate to `wykresyPython/` and run `python main.py`.
