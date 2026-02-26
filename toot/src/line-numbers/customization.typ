#import "../setup.typ": *
#set document(title: [Line number customization])
#show: toot-page

#title()

Other than `none`, you can assign anything listed
#link("https://typst.app/docs/reference/model/numbering/#parameters-numbering")[
here] to `line-numbering`.

So maybe you happen to think about the Roman Empire a lot and want to reflect
that in your pseudocode?
#example(```typ
// SETUP
// START
#set text(font: "Cinzel")

#pseudocode-list(line-numbering: "I:")[
  + explore European tribes
  + *while* not all tribes conquered
    + *for each* tribe *in* unconquered tribes
      + try to conquer tribe
    + *end*
  + *end*
]
```)

= Alignment <alignment>
#link(<alignment>, none)

By default, line numbers are placed with the alignment `horizon + right`, which
can look weird when a single step in the algorithm spans multiple typesetting
lines.
You can modify the line numbering alignment using the `line-number-alignment`
option:

#example(```typ
// SETUP
// START
#pseudocode-list(line-number-alignment: top + right)[
  + Single line
  + Multiple \ lines
]
```)
