#import "../src/ams-thesis.typ": ams-thesis, flex-caption, subfigure, vb
#show: ams-thesis

// Default depth of outline is 2, i.e., chapters and sections.
#outline()

#outline(target: figure.where(kind: image), title: [List of Figures])
#include "notation.typ"

// Activate "mainmatter": reset page counter and use arabic numbering.
#set page(numbering: "1")
#counter(page).update(0)

= Introduction

#lorem(100)

== Motivation
#lorem(200)

== Structure of Thesis
#lorem(100)

= Background

#lorem(50)

= One Central Chapter: Some Instructions for Writing the Thesis

Please consider the following instructions when writing your thesis.

Never start a section directly after a chapter heading, but always add some introductory paragraph.

== Equations

Equations should be included in the text using correct punctuation. The estimate can be updated by

$
  underline(hat(vb(x)))_k = underline(hat(vb(x)))_(k - 1) + vb(K)_k (underline(vb(y))_k - vb(H)_k underline(hat(vb(x)))_(k - 1)) thin ,
$<eq:measurement>

where $vb(K)_k in RR^(n times m)$ is the Kalman gain, $underline(vb(y))_k in RR^m$ the measurement, and $vb(H)_k in RR^(m times n)$ the observation matrix.
The measurement update @eq:measurement is the optimal linear update for Gaussian random variables @LCSS19_Schmitt. In summary, take care of the following points when writing equations:

- Embed equations in the text.

- Use correct punctuation. Punctuation after equation should have a whitespace using, e.g., `thin ,`.

- Equations should be numbered and referred to using `@eq:label`.

== Figures

Figures should be included as vector graphics if possible. Plots should be created using CeTZ#footnote[https://cetz-package.github.io/] or lilaq#footnote[https://lilaq.org/].
Text in figures should use the same font as the main document.
Avoid pixelated images! A placeholder figure is shown in @fig:rect. @fig:sub-rect shows two subfigures: @fig:sub-rect-a and @fig:sub-rect-b. Subfigures may need some fine-tuning
of alignment and column spacing.

Please consider the following points when including figures:

- Use vector graphics if possible.

- Use the same font as in the main document.

- Use `#flex-caption(short, long)` to explain the figures. The short description is used in the List of Figures and should be short but precise.

- Figures should appear in order of reference.

- Use `<fig:label>` to label figures and subfigures and refer to them in text using `@fig:label`.

#figure(
  caption: flex-caption[A short description for the List of Figures.][
    Figures should be vector graphics if possible. Plots should be created using CeTZ or lilaq. Text in figures should use the same font as the main document.
    Avoid pixelated images.
  ],
  rect(width: 100%, height: 9cm),
)<fig:rect>

#lorem(200)

#subfigure(
  caption: [Caption for Both Subfigures.],
  columns: (50%, 50%),
  align: top,
  label: <fig:sub-rect>,
  figure(caption: [A Subfigure], rect[B]),
  <fig:sub-rect-a>,
  figure(caption: [And Another Subfigure. It should be aligned with the first one], rect[C]),
  <fig:sub-rect-b>,
)

= Conclusions

#lorem(200)

#bibliography("bibliography/ams.bib")
