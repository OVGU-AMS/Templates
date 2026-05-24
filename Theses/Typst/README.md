# ams-typst

This folder provides a Typst thesis template for the [Autonomous Multisensor Systems](https://ams.ovgu.de) group.

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
  /// The thesis type (bachelor, master, PhD).
  /// -> content
  thesis-type: [Master],
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
