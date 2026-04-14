#let ams-thesis(title: [Title of Thesis], doc) = {
  set page(
    "a4",
    margin: (
      top: 2cm,
      bottom: 2cm,
      inside: 3cm,
      outside: 4cm,
    ),
    numbering: "1",
  )

  set document(title: title)
  set par(justify: true, first-line-indent: 2em, spacing: 0.65em)
  set text(12pt, font: "New Computer Modern")

  set heading(numbering: "1.1")

  show heading.where(level: 1): set heading(supplement: [Chapter])
  show heading.where(level: 1): set block(spacing: 1.5em)
  show heading.where(level: 1): it => block(width: 100%)[
    #set align(end)
    #set text(luma(75), weight: "regular")

    #grid(
      columns: (100%, 4cm),
      align: (end + bottom, start + bottom),
      text(0.75em, upper(it.supplement)),
      h(0.5em)
        + text(2.5em, weight: "bold", numbering(it.numbering, ..counter(heading).get()))
        + h(0.5em)
        + box(width: 1fr, rect(fill: luma(100), width: 100%)),
    )

    #it.body
  ]

  show heading.where(level: 2): set block(above: 2em, below: 1.5em)
  show heading.where(level: 2): it => block[
    #numbering(it.numbering, ..counter(heading).get())
    #h(1em)
    #it.body
  ]

  // Title page of thesis/dissertation.
  page(numbering: none)[
    #image("logos/fin-en.pdf")

    *Master Thesis*

    #std.title()

    #v(1fr)

    #line(length: 100%)

    #grid(
      columns: (70%, 30%),
      align: (left, right),
      [
        #set par(first-line-indent: 0em, spacing: 0.9em)
        #set text(10pt)

        Otto von Guericke University Magdeburg

        Faculty of Computer Science

        Institute for Intelligent Cooperating Systems

        Autonomous Multisensor Systems Group
      ],
      image("logos/AMS.pdf"),
    )
  ]

  doc
}
