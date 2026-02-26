#import "../setup.typ": *
#set document(title: [Booktabs])
#show: toot-page

#title()

If you like wrapping your algorithm in elegant horizontal lines, you can do so
by setting the `booktabs` option to `true`.
#example(```typ
// SETUP
// START
#pseudocode-list(booktabs: true)[
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

Together with the `title` option, you can produce
#example(```typ
// SETUP
// START
#pseudocode-list(booktabs: true, title: [My cool title])[
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

= Stroke <stroke>
#link(<stroke>, none)

By default, the outer booktab strokes are `text.fill + 2pt`.
You can change that with the option `booktabs-stroke` to any valid
#link("https://typst.app/docs/reference/visualize/stroke/")[Typst stroke].
The inner line will always have the same stroke as the outer ones, just with
half the thickness.

= Inset <inset>
#link(<inset>, none)

By setting the `title-inset` option, you can specify the space around the title:
#example(```typ
// SETUP
// START
#pseudocode-list(booktabs: true, title: [My cool title], title-inset: 2em)[
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
