# Templates

This folder provides theses templates for the [Autonomous Multisensor Systems](https://ams.ovgu.de) group.

You can choose between the class option `BA`, `MA`, and `PhD`.

The task sheet in the subfolder `Thesis Task Description` should be filled out before the Bachelor or Master thesis is registered. 

## Math Macros / Functions

You can use the following pre-defined math macros or functions, they are defined in [`mathmacros.sty`](./LaTeX/mathmacros.sty) and [`math.typ`](./Typst/src/math.typ) for LaTeX and Typst respectively.

| LaTeX            | Typst[^1]               | Rendered                                                | Description                  |
|------------------|-------------------------|---------------------------------------------------------|------------------------------|
| `\rv{x}`         | `$rv(x)$`               | $\mathbf{x}$                                            | Random variable              |
| `\mv{x}`         | `$mv(x)$`               | $\hat{\mathbf{x}}$                                      | Mean of random variable      |
| `\vec{x}`        | `$uvec(x)$`             | $\underline{x}$                                         | Vector                       |
| `\rvec{x}`       | `$rvec(x)$`             | $\underline{\mathbf{x}}$                                | Random vector                |
| `\mvec{x}`       | `$mvec(x)$`             | $\hat{\underline{\mathbf{x}}}$                          | Mean                         |
| `\cvec{x}`       | `$cvec(x)$`             | $\hat{\underline{x}}$                                   | Midpoint                     |
| `\bvec{x}`       | `$bvec(x)$`             | $\underline{\bar{x}}$                                   | Bar vec                      |
| `\ervec{x}`      | `$ervec(x)$`            | $\tilde{\underline{\mathbf{x}}}$                        | Random error                 |
| `\zero`          | `$zero$`                | $\underline{0}$                                         | Zero vector                  |
| `\mat{A}`        | `$mtx(A)`               | $\mathbf{A}$                                            | Matrix                       |
| `\ermat{A}`      | `$ermat(A)$`            | $\widetilde{\mathbf{A}}$                                | Error covariance matrix      |
| `\bmat{A}`       | `$bmat(A)$`             | $\bar{\mathbf{A}}$                                      | Matrix with bar              |
| `\ellip`         | `$ellip$`               | $\mathcal{E}$                                           | Ellipsoid                    |
| `\T`             | `$...^top$`             | $^{\mathrm{T}}$                                         | Transpose                    |
| `\inv`           | `$...^(-1)$`            | $^{-1}$                                                 | Inverse                      |
| `\invT`          | `$...^(-top)$`          | $^{-\mathrm{T}}$                                        | Inverse transpose            |
| `\nk`            | `$k + 1$`               | $k+1$                                                   | k+1                          |
| `\pk`            | `$k - 1$`               | $k-1$                                                   | k-1                          |
| `\argmin`        | `$argmin$`              | arg min                                                 | Argument minimum             |
| `\argmax`        | `$argmax$`              | arg max                                                 | Argument maximum             |
| `\diag`          | `$diag$`                | diag                                                    | Diagonal                     |
| `\Cov`           | `$Cov$`                 | Cov                                                     | Covariance                   |
| `\E`             | `$#E$`                  | E                                                       | Expectation                  |
| `\rank`          | `$rank$`                | rank                                                    | Rank                         |
| `\trace`         | `$trace$`               | trace                                                   | Trace                        |
| `\Var`           | `$Var$`                 | Var                                                     | Variance                     |
| `\NewR` or `\IR` | `$RR$`                  | $\mathbb{R}$                                            | Real numbers                 |
| `\NewN` or `\IN` | `$NN$`                  | $\mathbb{N}$                                            | Natural numbers              |
| `\NewZ` or `\IZ` | `$ZZ$`                  | $\mathbb{Z}$                                            | Integers                     |
| `\NewC` or `\IC` | `$CC$`                  | $\mathbb{C}$                                            | Complex numbers              |
| `\PDF`           | `$PDF$`                 | probability density function                            | Probability density function |
| `\Gauss`         | `$Gauss$`               | $\mathcal{N}$                                           | Normal/Gaussian distribution |
| `\Uniform`       | `$Uniform$`             | $\mathcal{U}$                                           | Uniform distribution         |

[^1]: Typst uses `$$` to designate math mode. Most of these functions can also be used outside of math mode as long as the argument is passed in math mode, e.g., `#rv($x$)`.
