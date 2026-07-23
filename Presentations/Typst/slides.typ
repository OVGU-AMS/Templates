#import "@preview/touying:0.7.4": *
#import "@local/ams-slides:0.2.0": *


#show: ams-slides.with(
  title: [Full Title of the Presentation],
  // If you use line breaks in the title, then also define the short-tile without line breaks!
  // short-title: [Short Title of the Presentation], -> This title is used in the footer.
  subtitle: [Subtitle if necessary],
  author: "Your Name",
  institution: [
    Autonomous Multisensor Systems Group\
    Institute for Intelligent Cooperating Systems\
    Faculty of Computer Science\
    Otto von Guericke University Magdeburg
  ],
  date: datetime.today(),
  extra: (
    web: "https://ams.ovgu.de",
    mail: "NCC-1701@ovgu.de",
  ),
)

#title-slide()

// ----- Slide content starts here. ----- //

= Introduction

#[
  #show: without-margin
  == Slide Concept<slide-concept>

  #place(
    top + left,
    dx: 0mm,
    dy: 0mm,
    image("pages/example.pdf"),
  )

  #pause

  #place(
    top + left,
    dx: 15mm,
    dy: 10mm,
    ams-shadow-box(
      title: "Design Rules",
      // width: 7cm,
      [
        - avoid text-heavy slides
        - prefer vector graphics
        - all text has to be readable
      ],
    ),
  )

  #pause

  #place(
    top + left,
    dx: 80mm,
    dy: 15mm,
    ams-shadow-box(
      title: "Text Boxes",
      color: AMSred,
      width: 7cm,
      [
        You can use these text boxes in different colors:
        ```typ
        #ams-shadow-box(
          title: "Text Boxes",
          color: AMSred, // AMSgreen, AMSblue
          width: 4.5cm,
          [...]
        )
        ```
      ],
    ),
  )

  #pause

  #place(
    top + left,
    dx: 25mm,
    dy: 50mm,
    ams-box(
      title: "Shadows",
      color: AMSgreen,
      width: 4.5cm,
      [
        You can use ```typ #ams-box``` to remove the shadow.
      ],
    ),
  )
]

== Template

You can use the usual Typst markup syntax such as headings.

#block(stroke: (left: 1.5pt + ovgu-inf-blue), inset: .5em, fill: luma(235))[
  Note that within this presentation template, thanks to `touying`, *level 1 headings correspond to new chapters and new-section-slides* while level 2 headings effectively act as new slides with their title in the header -- basically offset by one.
  This can be changed with the `slide-heading-level` parameter of the main theme show rule.
]

You can change or add certain stylistic choices -- let's number the headings & add spacing below headings for a less cluttered look:\
```typ
#show heading: set block(below: 1em)
#set heading(numbering: (_, ..n) => numbering("1.1", ..n))
```

(This ignores level 1 headings since we don't want them numbered.)

_$->$ See next slide for visible changes..._

#show heading: set block(below: 1em)
#set heading(numbering: (_, ..n) => numbering("1.1", ..n))

=== Example Subheading

- This level 2 subheading is now numbered as `0.1` since the one before is not numbered.

  - Either apply set rules globally or locally within a slide scope.

  - When using the heading-based slide-syntax, set rules start being applied from the point they are defined in the source code.

    - If the ```typ #slide()```-function is used instead, they are locally constrained.

    - A scope can also be manually created with ```typ #{...}```.

  - The template sets the numbering of level 1 headings to ```typc none```.#footnote[Otherwise, "First Section" in the header would be numbered.]

#set heading(numbering: none)

== Second Section

=== New Section Slides

- By default, when a new slide-section is created, an additional "new section slide" is also created (see the previous slides).

- Content will automatically overflow to a new slide within a section.

- If desired, ```typ #pagebreak()``` or `---` will manually break the "page", i.e., slide without creating a new section or "new section slide".

- To create a slide with a new section but *without* a new section slide, append the ```typ <touying:skip>``` label to the heading (see next slide as example).#footnote[See https://touying-typ.github.io/docs/intro for more features.]

  - This also depends on the `slide-heading-level` parameter

== Test Slide Using CeTZ <touying:skip>

#{
  import "@preview/cetz:0.5.2"
  import "@preview/cetz-plot:0.1.4"

  set align(center)

  cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *

    plot.plot(
      size: (13, 5),
      axis-style: "school-book",
      x-grid: true,
      y-grid: true,
      y-tick-step: 0.25,
      x-format: v => if v != 0 {
        $#{ calc.round(v / calc.pi, digits: 2) } pi$
      } else { $0$ },
      x-tick-step: 0.25 * calc.pi,
      {
        plot.add(domain: (0, 3 * calc.pi), t => calc.sin(t), samples: 150)
      },
    )
  })
}

== Margins

#place(
  top + left,
  dx: -10mm,
  dy: -5mm,
  block(
    fill: black.lighten(60%),
    width: 160mm,
    height: 78mm,
  ),
)
#place(
  top + left,
  dx: 160mm - 20mm,
  dy: 50mm,
  box(width: 1cm, {
    place(bottom + center, dy: -2pt, text(7pt)[1 cm])
    line(length: 1cm)
  }),
)
#place(
  top + left,
  dx: -10mm,
  dy: 50mm,
  box(width: 1cm, {
    place(bottom + center, dy: -2pt, text(7pt)[1 cm])
    line(length: 1cm)
  }),
)
#place(
  top + left,
  dx: 70mm,
  dy: -5mm,
  box(width: 1cm, {
    place(bottom + center, dy: -1.5mm, text(7pt)[0.5 cm])
    line(end: (0mm, 5mm))
  }),
)

#place(
  top + left,
  dx: 70mm,
  dy: 68mm,
  box(width: 1cm, {
    place(bottom + center, dy: -1.5mm, text(7pt)[0.5 cm])
    line(end: (0mm, 5mm))
  }),
)

#place(
  top + left,
  block(
    stroke: (paint: black, thickness: 0.3pt, dash: "dashed"),
    fill: white,
    width: 160mm - 20mm,
    height: 78mm - 10mm,
  ),
)

Standard slides have white margins of $1$~cm on the left and right, and $0.5$~cm at the top and bottom

You can change this setting with

```typ
#show: without-margin
```
to remove the margin and activate margins with
```typ
#show: with-margin
```


== Further Notes

=== Alignment

- Default alignment per slide is ```typc top + left```, this can be changed with ```typ #set align(..)```.


=== Special functions

- ```typ #title-slide()``` generates the title slide from the information given in the show-rule.

- ```typ #thank-you-slide()``` to create a slide for thanking your audience.

- ```typ #slide()``` and ```typ #new-section-slide()``` can also be manually called with a title & subtitle.

  - In the first case, no new section slide is automatically created.

  - In the second case, a custom subtitle & title can be created (see next slides).

// Calling it manually enables replacing the presentation title.
#new-section-slide(title: [Custom Presentation Title!], subtitle: [Random Text])

// Calling it manually enables custom title, no new-section slide and the ability
// to override some customization settings such as default padding.
#show: without-margin
#slide(title: [Non-padded Slide])[
  No padding to the sides.
  #align(center + horizon)[Good for placing big images.]
  #align(bottom + right)[Easier manual placement!]
]

== Manual Placement
#make-grid

#place(
  top + left,
  dx: 15mm,
  dy: 10mm,
  ams-shadow-box(
    title: "Helper Grid",
    [
      For manual placement you can activate a grid with ```typ #make-grid``` \
      The line distance is $1$ mm

      The usable slide area measures $160$ mm × $78$ mm.
    ],
  ),
)

#thank-you-slide()
