# ams-theme

This folder provides a Typst presentation template for the [Autonomous Multisensor Systems](https://ams.ovgu.de) group based on the `touying` package.

## Usage

You can initialize the presentation and its title slide with the following options:

```typ
#import "@preview/touying:0.7.3": *
#import "src/ams-theme.typ": *

#show: ams-theme.with(config-info(
  title: [Full Title of the Presentation],
  subtitle: [Subtitle if necessary],
  author: [Your Name],
  institution: [
    Autonomous Multisensor Systems Group\
    Institute for Intelligent Cooperating Systems\
    Faculty of Computer Science\
    Otto von Guericke University Magdeburg
  ],
  date: datetime.today(),
))

#title-slide()
```

You can then use heading-based syntax for slide creation where level 1 headings create a new slide
as well as a new section slide or manually use the slide functions mentioned below. (See the PDF and the annotated source code for a quick overview)

Compile either in the webapp or locally with `typst compile slides.typ`.

## Utility

The following slide functions are available:

```typ
/// The title slide.
///
/// Information is automatically filled in from the theme rule.
#let title-slide(..args)


/// A normal slide with an optional title.
///
/// If `title` is `none`, the last level 1 heading is used instead. 
#let slide(title: none, ..args)

/// A new section slide which is automatically created for level 1 headings.
///
/// Can also be manually called with a custom presentation title as well as a subtitle. 
#let new-section-slide(title: none, subtitle: none, ..args)

/// A thank-you slide.
///
/// Similar structure to title slide but with thank-you message.
#let thank-you-slide(..args)
```

## Fonts

You will need to install the "Latin Modern" font family on your system.
