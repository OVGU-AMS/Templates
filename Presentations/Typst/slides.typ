#import "@preview/touying:0.7.3": *
#import "src/ams-theme.typ": *

#show: ams-theme.with(config-info(
  title: [Full Title of the Presentation],
  subtitle: [Subtitle if necessary],
  author: [Your Name],
  institution: [
    Title of Course\
    Faculty of Computer Science\
    Otto von Guericke University Magdeburg
  ],
  date: datetime.today(),
))

#title-slide()

= First Section

== First Slide

A slide with a title and an *important* information.

== Second Slide

#lorem(10)
