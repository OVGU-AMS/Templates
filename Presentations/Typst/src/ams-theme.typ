#import "@preview/touying:0.7.3": *

#let m-dark-teal = rgb("#23373b")
#let ovgu-darkgray = rgb("#606060")
#let ovgu-orange = rgb("#F39100")
#let ovgu-inf-blue = rgb(0, 104, 180)

#let ams-logo = image("logos/AMS.pdf", height: 20mm)
// #let kmd-logo = image("logos/KMD.pdf", height: 20mm)
#let university-logo = image("logos/Signet_INF_1_inv.pdf", height: 11mm)
#let backdrop-logo = image("logos/otto.pdf")
// #let header-logo = image("logos/AMSKMDhead.pdf", width: 100%)

#let title-slide(..args) = touying-slide-wrapper(self => {
  let info = self.info + args.named()
  let body = {
    // Blue rectangle header with OvGU head and logo.
    rect(fill: ovgu-inf-blue, width: 100%, height: 90mm - 55mm, inset: (left: 14mm, rest: 0mm))[
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
    place(top + left, dx: 14mm, dy: 90mm - 50mm)[
      #let wide-lmmodern = text.with(font: "Latin Modern Sans 8")
      // @typstyle off
      #stack(dir: ttb, spacing: 5mm, strong(info.author), wide-lmmodern(info.institution, 7pt), wide-lmmodern(info.date.display(), 8pt))
    ]
    // AMS + KMD logo.
    place(bottom + right, dx: -10mm, dy: -7mm)[
      #stack(dir: ltr, spacing: 5mm, ams-logo)
    ]
  }

  touying-slide(self: self, body)
})

#let slide(title: auto, ..args) = touying-slide-wrapper(self => {
  if title != auto {
    self.store.title = title
  }

  let header(self) = {
    set align(top)
    show: components.cell.with(fill: self.colors.primary, inset: 1em)
    utils.display-current-heading(level: 1)
  }

  let footer(self) = {
    set align(bottom)
    // utils.call-or-display(self, self.store.footer)
    block(fill: ovgu-inf-blue, width: 100%, height: 100%, inset: (x: .5cm))[
      #set text(white, 4pt)
      #set align(horizon)
      #grid(
        columns: (1fr, 1fr),
        align: (left, right),
        self.info.title + " | " + self.info.author,
        context utils.slide-counter.display() + "/" + utils.last-slide-number,
      )
    ]
  }

  self = utils.merge-dicts(self, config-page(
    header: header,
    footer: footer,
    footer-descent: 0cm,
    header-ascent: 0cm,
    margin: (top: 1.1cm, bottom: 0.3cm, rest: 0cm),
  ))

  touying-slide(self: self, ..args)
})

#let ams-theme(
  ..args,
  body,
) = {
  set text(size: 10pt, font: "LMSans10", fill: m-dark-teal)

  set math.equation(numbering: "(1)")
  set figure(gap: 1em)
  set list(indent: 1em)
  set enum(indent: 1em)

  show: touying-slides.with(
    config-page(margin: 0cm, width: 160mm, height: 90mm, numbering: "1/1"),
    config-common(
      slide-fn: slide,
      // new-section-slide-fn: slide,
    ),
    config-colors(
      primary: ovgu-inf-blue,
      secondary: m-dark-teal,
      tertiary: ovgu-darkgray,
    ),
    config-store(title: none, footer: none),
    ..args,
  )

  body
}
