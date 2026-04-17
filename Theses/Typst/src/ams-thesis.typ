#import "@preview/subpar:0.2.2"

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

/// Upright and bold symbol for vectors and matrices.
#let vb(x) = $upright(bold(#x))$
#let empty-page = page(header: none, footer: none)[]

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

/// The AMS thesis template.
#let ams-thesis(
  /// The title of the thesis.
  /// -> content
  title: [Title of Thesis],
  /// The abstract of the thesis.
  /// -> content
  abstract: lorem(100),
  /// The author of the thesis.
  /// -> str | dictionary
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
    numbering: "i",
    footer: context {
      set text(font: "New Computer Modern Sans")
      let page-count = counter(page).get().first()
      let page-align = if calc.odd(page-count) { right } else { left }
      align(page-align, counter(page).display())
    },
  )

  set document(title: title, author: author)
  set par(justify: true, first-line-indent: 2em, spacing: 0.75em, leading: 0.75em)
  set text(font-size.normal, font: "New Computer Modern")

  set heading(numbering: "1.1")
  set block(spacing: 1.2em)
  set list(indent: 1em, spacing: 1em)

  set math.equation(
    numbering: n => numbering("(1.1)", counter(heading).get().first(), n),
    supplement: none,
  )

  set figure(gap: 1em)
  show figure: set block(spacing: 2em)
  show figure.caption: it => block[
    #set align(left)
    #text(font: "New Computer Modern Sans", weight: "bold")[
      #it.supplement
      #context it.counter.display(it.numbering)#it.separator
    ]
    #it.body
  ]

  set outline(depth: 2)
  show outline: set heading(outlined: true)
  show outline.entry.where(level: 1): set outline.entry(fill: none)
  show outline.entry.where(level: 1): set block(above: 2em)
  show outline.entry.where(level: 1): it => link(
    it.element.location(),
    strong(it.indented(it.prefix(), it.inner(), gap: 1.5em)),
  )

  show outline.entry.where(level: 2): set outline.entry(fill: repeat(gap: 0.5em)[.])
  show outline.entry.where(level: 2): it => link(
    it.element.location(),
    it.indented(
      it.prefix(),
      box(grid(
        columns: 3,
        column-gutter: (0.5em, 1em),
        it.body(), it.fill, it.page(),
      )),
      gap: 1.5em,
    ),
  )

  show heading.where(level: 1): set heading(supplement: [Chapter])
  show heading.where(level: 1): set block(below: 40pt) // todo!
  show heading.where(level: 1): it => {
    // Scoped set-page & pagebreak for truly empty pages when putting chapters on odd pages.
    {
      set page(footer: none)
      pagebreak(weak: true, to: "odd")
    }

    // "CHAPTER X" layout inside margins.
    block(width: 100%)[
      #set align(end)
      #set text(weight: "regular", font-size.huge)

      #if it.numbering != none [
        #v(50pt)
        #box(grid(
          columns: (100%, 4cm),
          align: (end + bottom, start + bottom),
          text(font-size.Large, upper(it.supplement)),
          h(0.2cm)
            + text(2cm, luma(25%), weight: "bold", numbering(
              it.numbering,
              ..counter(heading).get(),
            ))
            + h(0.2cm)
            + box(width: 1fr, rect(fill: luma(25%), width: 5cm, height: 1.3cm)),
        ))

        #v(20pt)
        #it.body
      ] else [
        #v(50pt)
        #it
      ]
    ]
  }

  show heading.where(level: 2): set text(font-size.Large)
  show heading.where(level: 2): set block(above: 2em, below: 1.5em)
  show heading.where(level: 2): it => block[
    #numbering(it.numbering, ..counter(heading).get())
    #h(1em)
    #it.body
  ]

  show link: it => {
    set text(font: "DejaVu Sans Mono", 0.9em) if type(it.dest) == str
    it
  }
  show "doi": smallcaps

  show std.title: set text(font-size.huge, weight: "regular")
  show std.title: set block(spacing: 1cm)

  // Title page of thesis/dissertation.
  page(margin: 2.5cm, header: none, footer: none)[
    #set par(first-line-indent: 0em)

    #image("logos/fin-en.pdf", width: 100%)
    #v(2cm)

    #block(inset: (x: 2.5cm), height: 15.5cm)[
      #text(font-size.huge)[*#thesis-type Thesis*]

      #std.title() \

      #text(font-size.large)[
        #author
        #linebreak()#v(0.5cm)
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

    #stack(
      dir: ttb,
      spacing: 0.15cm,
      line(length: 100%, stroke: 0.4pt),
      grid(
        columns: (70%, 30%),
        align: (left + horizon, right),
        [
          #set text(font-size.small)
          Otto von Guericke University Magdeburg \
          Faculty of Computer Science \
          Institute for Intelligent Cooperating Systems \
          Autonomous Multisensor Systems Group \
        ],
        image("logos/AMS.pdf", width: 90%),
      ),
    )
  ]

  counter(page).update(0)
  heading(numbering: none)[Abstract]
  abstract

  doc
}
