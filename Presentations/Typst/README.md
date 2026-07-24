# ams-slides

This folder provides a Typst presentation template for the [Autonomous Multisensor Systems](https://ams.ovgu.de) group based on the `touying` package.

## Usage

You can initialize the presentation and its title slide with the following options:

```typ
#import "@preview/touying:0.7.4": *
#import "@local/ams-slides:0.2.0": *

#show: ams-slides.with(
  title: [Full Title of the Presentation],
  short-title: [Short title for the footer],
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
    mail: "NCC-1701@ovgu.de"
  ),
  numbered-equations: false,
  slide-heading-level: 2,
  margin: true,
)

#title-slide()
```

You can then use heading-based syntax for slide creation where level 1 and 2 headings create a new slide (depending on `slide-heading-level`)
as well as a new section slide or manually use the slide functions mentioned below. (See the PDF and the annotated source code for a quick overview)

Compile either in the webapp or locally with `typst compile slides.typ`.

### Local Installation

In order to make the template available locally under the `@local` namespace, clone this repository and refer to [Local Packages](https://github.com/typst/packages/#local-packages) or use the [Unofficial Typst Package Manager](https://github.com/typst-community/utpm).
You can also use the provided [`justfile`](./justfile) to move this template to the correct location as well as generate up-to-date thumbnails for publishing.

## Utility

The following slide functions are available:

```typ
/// The title slide.
///
/// Information is automatically filled in from the theme rule.
#let title-slide(..args)

/// Normal slide with an optional title. If no title is set, the most
/// recent level 2 heading is used instead.
///
/// - title (content, none): A title which is displayed in the header.
/// - margin (bool): Whether to apply a margin to the slide content.
///
/// -> content
#let slide(title: none, margin: auto, ..args)

/// A new section slide which is automatically created for headings with level `slide-heading-level`.
///
/// Can also be manually called with a custom presentation title as well as a subtitle.
///
/// - title (content, none): An optional custom presentation title.
/// - subtitle (content, none): An optional subtitle.
///
/// -> content
#let new-section-slide(title: none, subtitle: none, ..args)

/// A thank-you slide.
///
/// Similar structure to title slide but with thank-you message.
/// Uses the `extra` argument from the theme rule display web page and mail.
///
/// -> content
#let thank-you-slide(..args)

// ----- NON-SLIDE UTILITY FUNCTIONS ----- //

/// Ruler grid.
#let make-grid()

/// Pre-defined `shadow` function.
#let ams-shadow(..)

/// A text box without shadow.
///
/// - color (color): Main color for the background gradient.
/// - title (content, none): Title of the text box.
/// - width (relative): Width of the text box. Scales automatically by default.
/// - justify (bool): Whether to justify the text in the box.
/// - body (content): Content of the text box.
///
/// -> content
#let ams-box(..)

/// The `ams-box` function wrapped in a shadow.
#let ams-shadow-box(..)

/// Use these as show rules, i.e., `#show: with-margin` to enable or disable slide margins.
#let with-margin
#let without-margin
```

The following pre-defined colors are available:

```typ
#let AMSblue = rgb(0, 104, 180)
#let AMSred = rgb(194, 23, 20)
#let AMSgreen = rgb(0, 120, 38)
#let AMSorange = rgb(246, 129, 0)
```

## Fonts

You will need to install the "Latin Modern" font family on your system.
