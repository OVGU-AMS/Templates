#import "src/ams-thesis.typ": section, math.rv

#heading(numbering: none)[Notation]

#section(level: 2)[Conventions]

#grid(columns: 2, column-gutter: 2.5em, row-gutter: 0.75em,
  $x$, [Scalar],
  $rv(x)$, [Random variable],
  $hat(rv(x))$, [Mean of random variable $rv(x)$.],
  $underline(x)$, [Column vector],
  $underline(rv(x))$, [Random vector],
  $underline(hat(rv(x)))$, [Mean of random vector $underline(rv(x))$.],
  $rv(A)$, [Matrix],
  $(.)_k$, [Quantity at time step $k$.],
  $RR$, [Set of real numbers.],
  $tilde$, [Distribution operator.\ E.g., $rv(x) tilde cal(U)$ means $rv(x)$ is distributed according to $cal(U)$.],
  $square.filled$, [End of example.],
  $square$, [End of proof.]
)

#section(level: 2)[Abbreviations]

/ KF: Kalman Filter
/ LRKF: Linear Regression Kalman Filter
/ RMSE: Root Mean Square Error
