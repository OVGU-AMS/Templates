#import "src/ams-thesis.typ": vb, section

#heading(numbering: none)[Notation]

#section(level: 2)[Conventions]

#grid(columns: 2, column-gutter: 2.5em, row-gutter: 0.75em,
  $x$, [Scalar],
  $vb(x)$, [Random variable],
  $hat(vb(x))$, [Mean of random variable $vb(x)$.],
  $underline(x)$, [Column vector],
  $underline(vb(x))$, [Random vector],
  $underline(hat(vb(x)))$, [Mean of random vector $underline(vb(x))$.],
  $vb(A)$, [Matrix],
  $(.)_k$, [Quantity at time step $k$.],
  $RR$, [Set of real numbers.],
  $tilde$, [Distribution operator.\ E.g., $vb(x) tilde cal(U)$ means $vb(x)$ is distributed according to $cal(U)$.],
  $square.filled$, [End of example.],
  $square$, [End of proof.]
)

#section(level: 2)[Abbreviations]

/ KF: Kalman Filter
/ LRKF: Linear Regression Kalman Filter
/ RMSE: Root Mean Square Error
