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

// ----- Slide content starts here. ----- //

= Template

== Heading 1

You can use the usual Typst markup syntax such as headings.

You can change or add certain stylistic choices -- let's number the headings:\
```typ #set heading(numbering: "1.1")```

// #set heading(numbering: "1.1")

=== Subheading 2

- This level 2 subheading is now numbered as `0.1` since the one before is not numbered.

  - Either apply set rules globally or locally within a slide scope.

  - This presentation template is available at ...
    and consists of the Typst template and some example code.
    
= Second Slide

#lorem(10)
