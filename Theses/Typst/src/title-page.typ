#let ba-ma-title(author, reviewers, font-size, thesis-type, date) = page(
  margin: 2.5cm,
  header: none,
  footer: none,
)[
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

#let diss-title(author, reviewers, font-size, thesis-type, date, phd-extra) = [
  #assert(phd-extra != none, message: "Field `phd-extra` cannot be none when PhD class is selected!")

  #set page(margin: (top: -1.5cm, rest: 2.5cm), header: none, footer: none)
  #set par(first-line-indent: 0em)
  #set text(font: "New Computer Modern Sans", font-size.Large)

  // Reset common spacing for bachelor/master thesis title page.
  #show std.title: set block(above: -1.8cm, below: 3.5cm)
  #show std.title: set text(font-size.LARGE)

  #align(center, image("logos/OVGU.pdf", width: 9.2cm))
  #std.title()

  #text(font-size.normal)[*DISSERTATION*]

  #v(0.7cm)

  zur Erlangung des akademischen Grades

  #v(0.7cm)

  Doktoringenieur (Dr.-Ing.)

  #v(1.5cm)

  angenommen durch die Fakultät für Informatik \
  der Otto-von-Guericke Universität Magdeburg

  #v(1.25cm)

  von #phd-extra.degree #author

  #v(.75cm)

  geb. am #phd-extra.birthdate #h(2.75cm) in #phd-extra.birthplace

  #v(.75cm)

  Gutachterinnen/Gutachter

  #v(0.4cm)

  #reviewers.supervisor \
  #reviewers.first-reviewer \
  #reviewers.second-reviewer

  #v(1fr)

  Magdeburg, den #date.display("[day].[month].[year]")

  /* ----- */

  #set page(margin: 2.5cm)
  #set text(font: "New Computer Modern", font-size.normal)
  #v(1fr)

  #pad(x: 10%)[
    *#author*\
    _#context document.title;_\
    Dissertation, Otto von Guericke University Magdeburg\
    Magdeburg, #date.year().
  ]
]
