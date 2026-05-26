# ams-typst

This folder provides a Typst thesis template for the [Autonomous Multisensor Systems](https://ams.ovgu.de) group.

## Usage

You can initialize the template with the following options:

```typ
#let ams-thesis(
  /// The title of the thesis.
  /// -> content
  title: [Title of Thesis],
  /// The abstract of the thesis.
  /// -> content | none
  abstract: none,
  /// The German abstract of the thesis.
  /// -> content | none
  zusammenfassung: none,
  /// The author of the thesis.
  /// -> str
  author: "Max Mustermann",
  /// The submission date.
  /// -> datetime
  date: datetime.today(),
  /// The thesis type (possible values are: "Bachelor", "Master", "PhD").
  /// -> str
  thesis-type: "Master",
  /// The reviewers of the thesis.
  /// -> dictionary
  reviewers: (
    supervisor: "Michaela Mustermann",
    first-reviewer: "Prof. Dipl. Inf. Gutachter 1",
    second-reviewer: "Prof. Dr.-Ing. Gutachter 2",
  ),
  /// Extra information for the dissertation title page.
  /// Possible keys are: degree, birthdate, birthplace.
  /// -> dictionary | none
  phd-extra: none,
)
```

Compile either in the webapp or locally with `typst compile thesis.typ`.

## Utility

The following helper functions are available:

```typ
/// Upright and bold symbol for vectors and matrices.
#let vb(x) = $upright(bold(#x))$

/// Fully empty page with no header and footer.
#let empty-page = page(header: none, footer: none)[]

/// Unnumbered and non-outlined section with custom level.
#let section(level: auto, body) = heading(
  numbering: none,
  outlined: false,
  level: level,
  body,
)

/// Provides a short caption for List of Figures and the usual longer one.
#let flex-caption(short, long) = context if in-outline.get() { short } else { long }

/// Subfigures. Correct numbering is applied.
#let subfigure = subpar.grid.with(
  numbering: num => {
    numbering("1.1", counter(heading).get().first(), num)
  },
  numbering-sub: (.., num) => {
    set text(font: "New Computer Modern Sans")
    numbering("(a)", num)
  },
  numbering-sub-ref: (sup, sub) => {
    numbering("1.1(a)", counter(heading).get().first(), sup, sub)
  },
)

/// Split up default `#lorem()` function into `n` paragraphs.
#let lorem-pars(n, each: 4) = {
  let sentences = lorem(n * each * 30).split(". ")
  range(n).map(i => sentences.slice(i * each, count: each).join(". ") + [.]).join(parbreak())
}

/// Activate appendix or backmatter via show-rule: Reset chapter counter,
/// use alphabetic numbering and  change supplement to "Appendix".
#let appendix(doc) = {
  set heading(numbering: "A.1")
  show heading.where(level: 1): set heading(supplement: "Appendix")
  counter(heading).update(0)
  doc
}
```

## Fonts

In addition to "New Computer Modern" which is included in Typst, the "New Computer Modern Sans" font needs to be installed.
