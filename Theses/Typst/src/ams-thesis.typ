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
  set block(spacing: 1.2em)

  show heading.where(level: 1): set heading(supplement: [Chapter])
  show heading.where(level: 1): set block(above: 30pt, below: 30pt) // todo!
  show heading.where(level: 1): it => block(width: 100%, inset: (top: 1.5cm))[
    #set align(end)
    #set text(gray.mix(black), weight: "regular", 24.88pt)

    #grid(
      columns: (100%, 4cm),
      align: (end + bottom, start + bottom),
      text(17pt, upper(it.supplement)),
      h(5pt)
        + text(54.88pt, weight: "bold", numbering(it.numbering, ..counter(heading).get()))
        + h(5pt)
        + box(width: 1fr, rect(fill: gray.mix(black), width: 5cm, height: 1.3cm)),
    )

    #it.body
  ]

  // todo: incorporate into previous rule!
  show heading.where(level: 1): it => pagebreak(weak: true, to: "odd") + it

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

  pagebreak(to: "odd")
  doc
}
