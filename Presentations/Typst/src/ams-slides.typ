#import "@preview/touying:0.7.4": *
#import "@preview/cetz:0.5.2"
#import "@preview/shadowed:0.3.0": shadow

#let m-dark-teal = rgb("#23373b")
#let ovgu-darkgray = rgb("#606060")
#let ovgu-inf-blue = rgb(0, 104, 180)

#let AMSblue = ovgu-inf-blue
#let AMSred = rgb(194, 23, 20)
#let AMSgreen = rgb(0, 120, 38)
#let AMSorange = rgb(246, 129, 0)

#let ams-logo = image("logos/AMS.pdf", height: 20mm)
#let university-logo = image("logos/Signet_INF_1_inv.pdf", height: 11mm)
#let backdrop-logo = image("logos/otto.pdf")
#let header-logo = image("logos/AMShead.pdf", width: 100%)

#let format-author(author) = if type(author) == array {
  author.join(", ")
} else {
  author
}

#let header(self) = {
  // header-logo // it is defined as foreground to be on top of full-slide images
  place(bottom + left, dx: 4mm, dy: -5mm, text(
    fill: ovgu-inf-blue,
    12pt,
    weight: "bold",
    if self.store.title != none { self.store.title } else {
      utils.display-current-heading(level: 2)
    },
  ))
}

#let footer(self) = {
  set align(bottom)
  block(fill: ovgu-inf-blue, width: 100%, height: 100%, inset: (x: .5cm))[
    #set text(white, 5pt, weight: "bold")
    #set align(horizon)
    #grid(
      columns: (auto, 1fr),
      align: (left, right),
      if self.info.short-title != none { self.info.short-title } else { self.info.title }
        + " | "
        + format-author(self.info.author),
      context utils.slide-counter.display() + "/" + utils.last-slide-number,
    )
  ]
}



/// Normal slide with an optional title. If no title is set, the most
/// recent level 2 heading is used instead.
///
/// - title (content, none): A title which is displayed in the header.
/// - margin (bool): Whether to apply a margin to the slide content.
///
/// -> content
#let slide(title: none, margin: auto, ..args) = touying-slide-wrapper(self => {
  if title != none {
    self.store.title = title
  } else {
    self.store.title = none
  }
  
  self = utils.merge-dicts(self, config-page(
    header: header,
    footer: footer,
    foreground: align(top, header-logo),
    footer-descent: 0cm,
    header-ascent: -0.2cm,
    margin: (top: 0.9cm, bottom: 0.3cm, rest: 0cm),
  ))
  
  let use-margin = if margin == auto { self.info.margin } else { margin }
  
  touying-slide(
    self: self,
    setting: body => {
      if use-margin {
        pad(x: 1cm, y: 0.5cm, body)
      } else {
        body
      }
    },
    ..args,
  )
})

#let with-margin = touying-set-config.with(config-info(margin: true))
#let without-margin = touying-set-config.with(config-info(margin: false))

/*#######################################
# . . . . . .SPECIAL SLIDES . . . . . . #
#######################################*/

/// The title slide.
///
/// Information is automatically filled in from the theme rule.
#let title-slide(..args) = touying-slide-wrapper(self => {
  let info = self.info + args.named()
  let body = {
    // Blue rectangle header with OvGU head and logo.
    rect(fill: ovgu-inf-blue, width: 100%, height: 90mm - 55mm, inset: (
      left: 14mm,
      rest: 0mm,
    ))[
      #place(top + right, backdrop-logo)
      #place(top + left, dy: 3mm, university-logo)
    ]
    // Title, subtitle and author data.
    place(bottom + left, dx: 14mm, dy: -60mm)[
      #set text(white)
      
      #show std.title: set text(14pt, weight: "bold")
      #show std.title: set block(below: 0.7em)
      
      #std.title(info.title)
      #text(10pt, strong(info.subtitle))
    ]
    // Additional information regarding institution, course, etc.
    place(top + left, dx: 14mm, dy: 90mm - 50mm)[
      #let wide-lmmodern = text.with(font: "Latin Modern Sans 8")
      #stack(
        dir: ttb,
        spacing: 5mm,
        strong(format-author(info.author)),
        wide-lmmodern(info.institution, 7pt),
        wide-lmmodern(info.date.display("[day].[month].[year]"), 7pt),
      )
    ]
    // AMS logo.
    place(bottom + right, dx: -10mm, dy: -7mm)[
      #stack(dir: ltr, spacing: 5mm, ams-logo)
    ]
  }
  
  touying-slide(self: self, body)
})


/// A new section slide which is automatically created for headings with level `slide-heading-level`.
///
/// Can also be manually called with a custom presentation title as well as a subtitle.
///
/// - title (content, none): An optional custom presentation title.
/// - subtitle (content, none): An optional subtitle.
///
/// -> content
#let new-section-slide(
  title: none,
  subtitle: none,
  ..args,
) = touying-slide-wrapper(self => {
  let main-body = {
    set align(horizon)
    (
      text(size: 12pt, if subtitle != none { subtitle } else {
        utils.display-current-heading(level: 1)
      })
        + v(1.5em, weak: true)
    )
    text(ovgu-inf-blue, weight: "bold", 1.5em, if title != none { title } else {
      self.info.title
    })
  }
  
  self = utils.merge-dicts(self, config-page(
    footer: footer,
    footer-descent: 0cm,
    margin: (rest: 1cm, bottom: 0.3cm),
  ))
  
  touying-slide(self: self, main-body)
})

/// A thank-you slide.
///
/// Similar structure to title slide but with thank-you message.
/// Uses the `extra` argument from the theme rule display web page and mail.
///
/// -> content
#let thank-you-slide(..args) = touying-slide-wrapper(self => {
  let info = self.info + args.named()
  let body = {
    // Blue rectangle header with OvGU head and logo.
    rect(fill: ovgu-inf-blue, width: 100%, height: 90mm - 55mm, inset: (
      left: 14mm,
      rest: 0mm,
    ))[
      #place(top + right, backdrop-logo)
      #place(top + left, dy: 3mm, university-logo)
    ]
    
    // Title of Presentation.
    place(bottom + left, dx: 14mm, dy: -60mm)[
      #set text(white)
      
      #show std.title: set text(14pt, weight: "bold")
      #show std.title: set block(below: 0.7em)
      
      #std.title(info.title)
      #text(10pt, strong(info.subtitle))
    ]
    // "Thank You" text somewhat further down.
    place(top + left, dx: 14mm, dy: 90mm - 40mm)[
      #text(1.5em, ovgu-inf-blue, weight: "bold")[Thank You For Your Attention!]
    ]
    // Name, website and mail on same level as AMS logo.
    place(bottom + left, dx: 14mm, dy: -8.5mm)[
      #set text(7pt)
      *#info.author*
      #grid(
        columns: 2,
        column-gutter: 3pt,
        row-gutter: 1em,
        align: (right, left),
        [Web:], self.info.extra.web,
        [Mail:], link("mailto:" + self.info.extra.mail),
      )
    ]
    
    // AMS logo.
    place(bottom + right, dx: -10mm, dy: -7mm)[
      #stack(dir: ltr, spacing: 5mm, ams-logo)
    ]
  }
  touying-slide(self: self, body)
})

/// The AMS theme rule.
///
/// - title (content, none): The title of the presentation, which will be displayed in the title slide and footer.
/// - short-title (content, none): The short title of the presentation. Displayed in the footer if given.
/// - subtitle (content, none): The subtitle of the presentation.
/// - author (content, str, array): The author(s) of the presentation.
/// - date (datetime): The date of the presentation. See the `datetime` type for usage.
/// - institution (content, none): The institution, faculty or university of this presentation.
/// - extra (dict): A custom dictionary of extra information, currently only used for web and mail.
/// - numbered-equations (bool): Defines whether equations should be numbered. Not recommended for scientific slides.
/// - slide-heading-level (int): New slides are generated at this heading level.
/// - margin (bool): Whether slides have a margin, `false` by default.
///
/// -> content
#let ams-slides(
  title: none,
  short-title: none,
  subtitle: none,
  author: none,
  date: none,
  institution: none,
  extra: none,
  numbered-equations: false,
  slide-heading-level: 2,
  // for using images, margin can be removed. For text-centric slides, this can be set to true
  margin: true,
  body,
) = {
  set text(
    size: 10pt,
    font: ("Latin Modern Sans", "LMSans10"),
    fill: m-dark-teal,
  )
  
  set math.equation(numbering: "(1)") if numbered-equations
  
  set figure(gap: 1em)
  set list(indent: 0em, marker: text(font: "Latin Modern Roman", ovgu-inf-blue, "•"))
  set enum(indent: 0em)
  
  // Extra spacing for footnote entry, otherwise it sits on top of footer.
  show footnote.entry: it => it + v(.65em)
  show raw: set text(font: ("Latin Modern Mono", "Latin Modern Mono 12"), 1.1em)
  show link: set text(font: ("Latin Modern Mono", "Latin Modern Mono 12"))
  show heading.where(level: 1): set heading(numbering: none)
  
  show: touying-slides.with(
    config-page(
      margin: 0cm,
      width: 160mm,
      height: 90mm,
      numbering: "1/1",
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
      slide-level: slide-heading-level,
    ),
    config-colors(
      primary: ovgu-inf-blue,
      secondary: m-dark-teal,
      tertiary: ovgu-darkgray,
    ),
    config-store(title: none, footer: none),
    config-info(
      title: title,
      short-title: short-title,
      subtitle: subtitle,
      author: author,
      date: date,
      institution: institution,
      extra: extra,
      margin: margin,
    ),
  )
  
  body
}


/*#######################################
# . . . . . . . .HELPERS. . . . . . . . #
#######################################*/

/// Ruler grid.
#let make-grid = place(
  top + left,
  cetz.canvas(length: 1mm, {
    import cetz.draw: *
    // this rect alone defines the canvas size: exactly 160 x 78 mm
    rect((0, 0), (160, 78), stroke: none)
    grid(
      (0, 0),
      (160, 78),
      help-lines: true,
      step: 1,
    )
    grid(
      (0, 0),
      (160, 78),
      stroke: black.lighten(20%) + 0.2pt,
      step: 10,
    )
    
    // numbers along the x-axis (bottom)
    for x in range(0, 161, step: 10) {
      content((x, 10), anchor: "north-west", padding: 1, text(5pt, [#x]))
    }
    
    // numbers along the y-axis (left)
    for y in range(0, 79, step: 10) {
      content((10, y), anchor: "south-east", padding: 1, text(5pt, [#y]))
    }
  }),
)

/**************************************
 * Text boxes with and without shadow *
 **************************************/

/// Pre-defined `shadow` function.
#let ams-shadow(body) = shadow(
  blur: 4pt,
  fill: rgb(0, 0, 0, 40%),
  radius: 2mm + 1.3pt,
  dx: 3pt,
  dy: 3pt,
  body,
)

/// A text box without shadow.
///
/// - color (color): Main color for the background gradient.
/// - title (content, none): Title of the text box.
/// - width (relative): Width of the text box. Scales automatically by default.
/// - justify (bool): Whether to justify the text in the box.
/// - body (content): Content of the text box.
///
/// -> content
#let ams-box(color: AMSblue, title: none, width: auto, justify: true, ..args, body) = block(
  fill: gradient.linear(white, color.lighten(70%), angle: 90deg),
  width: width,
  inset: 8pt,
  radius: 2mm,
  stroke: color + 1.5pt,
  ..args.named(),
  {
    set par(justify: justify)
    set list(indent: 0em, marker: text(font: "Latin Modern Roman", color, "•"))
    if title != none {
      text(fill: color, weight: "bold")[#title]
      v(-0.2em)
    }
    body
  },
)

/// The `ams-box` function wrapped in a shadow.
#let ams-shadow-box(..args, body) = ams-shadow(ams-box(..args.named(), body))
