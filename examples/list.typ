#set page(width: 40em, height: auto, margin: 1em)
#set text(font: "TeX Gyre Pagella")
#show math.equation: set text(font: "TeX Gyre Pagella Math")
#import "../lib.typ": *

#show: setup-lovelace

#pseudocode-list(
  // indentation-guide-stroke: none,
  indentation-guide-inset: .0em,
  indentation-size: 1em / 2,
  // line-numbering: none,
)[
  - *input:* integers $a$ and $b$
  - *output:* greatest common divisor of $a$ and $b$
  + *while* $a != b$ *do*
    + *if* $a > b$ *then*
      + $a <- a - b$
    + *else*
      + $b <- b - a$ #comment[a comment]
    + *end*
  + *end*
  + *return* $a$
]


#figure(
  kind: "algorithm",
  supplement: "Algorithm",
  pseudocode-list(
    line-number-supplement: "Zeile",
    line-numbering: "i",
    // title: [#counter(figure.where(kind: "algorithm")).display() this is a title],
    numbered-title: [Euclid],
    booktabs-stroke: 2pt + black,
  )[
    - *input:* bla
    + wow
    + abc
      + def
      + ghi #line-label(<hi>)
        + uff
      + #lorem(10)
  ]
)

@hi

#counter(figure.where(kind: "algorithm")).display()

