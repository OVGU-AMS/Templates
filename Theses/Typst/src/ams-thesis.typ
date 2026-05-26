#import "@preview/subpar:0.2.2"
#import "@preview/hydra:0.6.2": hydra
#import "title-page.typ"

#let in-outline = state("in-outline", false)

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

/// The AMS thesis template.
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
  doc,
) = {
  // Page setup, alternating margins and top margin is based on base distance,
  // header height and header separator. hydra provides the current chapter for
  // the header rules and footer is sans-roman for frontmatter.
  set page(
    "a4",
    margin: (
      top: 2cm + 14pt + 0.8cm, // top + headheight + headsep
      bottom: 2cm,
      inside: 3cm,
      outside: 4cm,
    ),
    numbering: "i",
    header-ascent: 0.8cm,
    header: context {
      set text(font: "New Computer Modern Sans")
      let header-rule(chapter) = stack(dir: ttb, spacing: 5pt, chapter, line(
        length: 100%,
        stroke: 0.5pt,
      ))

      // Section in header on the right for odd pages and chapters in header on the left for even pages.
      if calc.odd(here().page()) {
        align(right, hydra(2, display: (.., c) => {
          header-rule(
            counter(heading).display("1.1.") + h(1em) + c.body,
          )
        }))
      } else {
        align(left, hydra(1, display: (.., c) => {
          if c.numbering != none {
            header-rule(
              c.supplement + " " + counter(heading.where(level: 1)).display("1.") + " " + c.body,
            )
          } else {
            header-rule(c.body)
          }
        }))
      }
    },
    footer: context {
      set text(font: "New Computer Modern Sans")
      let page-count = counter(page).get().first()
      let page-align = if calc.odd(page-count) { right } else { left }
      align(page-align, counter(page).display())
    },
  )

  // Basic document setup for metadata, paragraphs and text font and size.
  set document(title: title, author: author)
  set text(font-size.normal, font: "New Computer Modern")
  set heading(numbering: "1.1")
  set list(indent: 1em, spacing: 1em)

  // Paragraphs are justified, have a first-line indent and same line spacing as leading.
  set par(
    justify: true,
    first-line-indent: 2em,
    spacing: 0.75em,
    leading: 0.75em,
  )

  // Adjust equations to have extra spacing and heading-dependent numbering.
  show math.equation: set block(spacing: 1.2em)
  set math.equation(
    numbering: n => numbering("(1.1)", counter(heading).get().first(), n),
    supplement: none,
  )

  // Figures also get heading-dependent numbering, and some spacing and styling.
  set figure(gap: 1em, numbering: (..n) => numbering("1.1", counter(heading).get().first(), ..n))
  show figure: set block(spacing: 2em)
  show figure.caption: it => block[
    #set align(left)
    #text(font: "New Computer Modern Sans", weight: "bold")[
      #it.supplement
      #context it.counter.display(it.numbering)#it.separator
    ]
    #it.body
  ]

  // Stylization of table of contents.
  set outline(depth: 2)

  show outline: set heading(outlined: true)
  show outline: it => {
    show heading: set block(below: 1.5cm)
    it
  }

  show outline.entry.where(level: 1): set outline.entry(fill: none)
  show outline.entry.where(level: 1): set block(above: 2em)
  show outline.entry.where(level: 1): it => link(
    it.element.location(),
    strong(it.indented(it.prefix(), it.inner(), gap: .75em)),
  )

  show outline.entry.where(level: 2): set outline.entry(fill: repeat(
    gap: 0.5em,
  )[.])
  show outline.entry.where(level: 2): it => link(
    it.element.location(),
    it.indented(
      it.prefix(),
      box(grid(
        columns: 3,
        column-gutter: (0.5em, 1em),
        it.body(), it.fill, it.page(),
      )),
      gap: 1em,
    ),
  )

  // Stylization of list of figures.
  show outline.where(target: figure.where(kind: image)): it => {
    in-outline.update(true)

    show outline.entry: set text(weight: "regular")
    show outline.entry: set outline.entry(fill: repeat(gap: 0.5em)[.])
    show outline.entry: set block(spacing: 1em)

    show outline.entry: entry => context {
      link(entry.element.location(), entry.indented(
        gap: 1.5em,
        numbering(
          "1.1",
          counter(heading).at(entry.element.location()).first(),
          ..counter(it.target).at(entry.element.location()),
        ),
        box(grid(
          columns: (auto, 1fr, auto),
          column-gutter: (0.5em, 1em),
          entry.body(), entry.fill, entry.page(),
        )),
      ))
    }

    it
    in-outline.update(false)
  }

  // Chapter styling: Big right-aligned "CHAPTER X" with a rectangle.
  show heading.where(level: 1): set heading(supplement: [Chapter])
  show heading.where(level: 1): set block(below: 30pt)
  show heading.where(level: 1): it => {
    // Scoped set-page & pagebreak for truly empty pages when putting chapters on odd pages.
    {
      set page(header: none, footer: none)
      pagebreak(weak: true, to: "odd")
    }

    // "CHAPTER X" layout inside margins.
    block(width: 100%)[
      #set align(end)
      #set text(weight: "regular", font-size.huge, hyphenate: false)
      #set par(justify: false)

      #if it.numbering != none [
        // Reset figure counters after each numbered chapter.
        #counter(figure.where(kind: image)).update(0)
        #counter(figure.where(kind: table)).update(0)
        #counter(figure.where(kind: raw)).update(0)

        #v(1.4cm)
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

        #v(10pt)
        #it.body
      ] else [
        #v(50pt)
        #it
      ]
    ]
  }

  // Section styling, gap between numbering and around the section.
  show heading.where(level: 2): set text(font-size.Large)
  show heading.where(level: 2): set block(above: 35pt, below: 20pt)
  show heading.where(level: 2): it => block[
    #if it.numbering != none [
      #numbering(it.numbering, ..counter(heading).get())
      #h(1em)
    ]
    #it.body
  ]

  // Various other show rules for links, lists and the title.
  show selector.or(list, enum): set block(spacing: 1.2em)
  show "doi": smallcaps
  show link: it => {
    set text(font: "DejaVu Sans Mono", 0.9em) if type(it.dest) == str
    it
  }

  show std.title: set text(font-size.huge, weight: "regular")
  show std.title: set block(spacing: 1cm)

  // Title page of thesis or dissertation.
  assert(
    thesis-type in ("Bachelor", "Master", "PhD"),
    message: "Possible values for thesis-type are: Bachelor, Master or PhD",
  )

  // Reset page count after title page & add abstracts.
  if thesis-type == "Bachelor" or thesis-type == "Master" {
    title-page.ba-ma-title(author, reviewers, font-size, thesis-type, date)
    counter(page).update(0)
  } else {
    title-page.diss-title(author, reviewers, font-size, thesis-type, date, phd-extra)
    counter(page).update(1)
  }

  if abstract != none { heading(numbering: none)[Abstract] + abstract }
  if zusammenfassung != none { heading(numbering: none)[Zusammenfassung] + zusammenfassung }

  doc
}
