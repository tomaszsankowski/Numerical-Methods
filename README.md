# Numerical Methods Archive

This repository serves as an archive for my Numerical Methods mini-projects and university laboratory assignments. The collection includes various implementations of numerical algorithms, focusing on efficiency, accuracy analysis (MSE), and practical applications like stock market indicators or geographical path interpolation.

## Projects Overview

| Project                                                    | Description                                                                                         |
| :--------------------------------------------------------- | :-------------------------------------------------------------------------------------------------- |
| [**lab2_page_rank**](./lab2_page_rank)                     | Implementation of the PageRank algorithm used by search engines, including circle generation logic. |
| [**lab3_linear_equations**](./lab3_linear_equations)       | Solving systems of linear equations using Direct, Jacobi, and Gauss-Seidel iterative methods.       |
| [**lab4_nonlinear_equations**](./lab4_nonlinear_equations) | Finding roots of non-linear equations using Bisection and Secant numerical methods.                 |
| [**lab5_interpolation**](./lab5_interpolation)             | Polynomial interpolation using Vandermonde matrix and analysis of Runge's phenomenon.               |
| [**lab6_approximation**](./lab6_approximation)             | Function approximation techniques including Mean Squared Error (MSE) calculation.                   |
| [**lab7_integration**](./lab7_integration)                 | Numerical integration implementations, including the rectangular and trapezoidal methods.           |
| [**proj1_macd**](./proj1_macd)                             | Calculation and technical analysis of the MACD stock market indicator using historical data.        |
| [**proj2_linear_equations**](./proj2_linear_equations)     | High-performance C++ implementation for solving large-scale systems of linear equations.            |
| [**proj3_interpolation**](./proj3_interpolation)           | Advanced interpolation techniques applied to smooth and reconstruct geographical paths.             |

## Setup and Requirements

- **Python:** Version 3.8+ (required for most labs and projects).
- **C++ Compiler:** GCC/Clang or MSVC (specifically for `proj2_linear_equations`).
- **Core Libraries:** `NumPy`, `Matplotlib`, `Pandas` (for data analysis and visualization).

## How to Run

1. **For Python projects**:
   - Navigate to the project directory.
   - (Optional) Activate a virtual environment.
   - Install dependencies and run:
     ```bash
     pip install -r requirements.txt
     python main.py
     ```
2. **For C++ projects** (`proj2`):
   - Navigate to the folder, compile using a C++ compiler (e.g., `g++ -O3 main.cpp -o solver`), and execute the binary.

---

_Note: Each directory contains its own dedicated README.md file with a more detailed description of the specific project, implemented algorithms, and mathematical background._
