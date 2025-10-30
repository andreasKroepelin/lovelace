#import "../setup.typ": *
#set document(title: [Indentation guides])
#show: toot-page

#title()

By default, Lovelace puts a thin gray (`gray + 1pt`) line to the left of each
indented block, which guides the reader in understanding the indentations, just
like a code editor would.
You can customise this using the `stroke` option which takes any value that is
a valid #link("https://typst.app/docs/reference/visualize/stroke/")[Typst stroke].
You can especially set it to `none` to have no indentation guides.

The example from the beginning becomes:
#example(```typ
// SETUP
// START
#pseudocode-list(stroke: none)[
  + do something
  + do something else
  + *while* still something to do
    + do even more
    + *if* not done yet *then*
      + wait a bit
      + resume working
    + *else*
      + go home
    + *end*
  + *end*
]
```)

