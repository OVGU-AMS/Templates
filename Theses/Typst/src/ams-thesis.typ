/// LaTeX-like font-size names for easier porting. (cf. "Standard Document Classes for LaTeX version 2e" pp. 9-10)
#let font-size = (
  tiny: 6pt,
  script: 8pt,
  small: 10.95pt,
  normal: 12pt,
  large: 14.4pt,
  Large: 17.28pt,
  LARGE: 20.74pt,
  huge: 24.88pt,
)

#let ams-thesis(
  title: [Title of Thesis],
  author: [Max Mustermann],
  date: datetime.today(),
  thesis-type: [Master],
  reviewers: (
    supervisor: "Michaela Mustermann",
    first-reviewer: "Prof. Dipl. Inf. Gutachter 1",
    second-reviewer: "Prof. Dr.-Ing. Gutachter 2",
  ),
  doc,
) = {
  set page(
    "a4",
    margin: (
      top: 2cm,
      bottom: 2cm,
      inside: 3cm,
      outside: 4cm,
    ),
    footer: context {
      let page-count = counter(page).get().first()
      let page-align = if calc.odd(page-count) { right } else { left }
      align(page-align, counter(page).display())
    },
  )

  set document(title: title)
  set par(justify: true, first-line-indent: 2em, spacing: 0.65em, leading: 0.8em) // todo: baselinestretch to leading
  set text(font-size.normal, font: "New Computer Modern")

  set heading(numbering: "1.1")
  set block(spacing: 1.2em)

  show heading.where(level: 1): set heading(supplement: [Chapter])
  show heading.where(level: 1): set block(below: 40pt) // todo!
  show heading.where(level: 1): it => block(width: 100%)[
    #set align(end)
    #set text(weight: "regular", font-size.huge)

    #v(50pt)
    #box(grid(
      columns: (100%, 4cm),
      align: (end + bottom, start + bottom),
      text(font-size.Large, upper(it.supplement)),
      h(5pt)
        + text(2cm, luma(25%), weight: "bold", numbering(it.numbering, ..counter(heading).get()))
        + h(5pt)
        + box(width: 1fr, rect(fill: luma(25%), width: 5cm, height: 1.3cm)),
    ))

    #v(20pt)
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

  show std.title: set text(font-size.huge, weight: "regular")
  show std.title: set block(spacing: 1cm)

  // Title page of thesis/dissertation.
  page(margin: 2.5cm, header: none, footer: none)[
    #set par(first-line-indent: 0em)

    #image("logos/fin-en.pdf", width: 100%)
    #v(2cm)

    #block(inset: (x: 2.5cm), height: 15cm)[
      #text(font-size.huge)[*#thesis-type Thesis*]

      #std.title() \

      #text(font-size.large)[
        #author
        #v(0.5cm)
        Magdeburg, #date.display("[day].[month].[year]")
      ]

      #v(1fr)

      #text(font-size.large)[
        Supervisor: #reviewers.supervisor \
        Professor: #reviewers.first-reviewer \
        Second Assessor: #reviewers.second-reviewer
      ]
    ]

    #v(1fr)

    #line(length: 100%, stroke: 0.4pt)#v(0.15cm, weak: true)

    #grid(
      columns: (70%, 30%),
      align: (left, right),
      [
        #set text(font-size.small)

        Otto von Guericke University Magdeburg \
        Faculty of Computer Science \
        Institute for Intelligent Cooperating Systems \
        Autonomous Multisensor Systems Group \
      ],
      image("logos/AMS.pdf", width: 90%),
    )
  ]

  pagebreak(to: "odd")
  doc
}
