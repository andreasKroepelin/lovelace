#import "../lib.typ": *
#set page(width: auto, height: auto, margin: 1em, fill: none)
#set text(font: "TeX Gyre Pagella")
#show math.equation: set text(font: "TeX Gyre Pagella Math")

#pseudocode-list(number-align: top + right)[
  + Normal line with a number
  + #box(height: 3em, fill: gray)[#align(horizon)[Multiple lines]]
]

