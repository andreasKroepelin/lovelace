#import "setup.typ": *
#set document(title: [Algorithm as figure])
#show: toot-page

#title[Algorithm as `figure`]

To make algorithms referencable and being able to float in the document,
you can use Typst's `#figure` function with a custom `kind`.
#example(```typ
// SETUP
// START
#figure(
  kind: "algorithm",
  supplement: [Algorithm],
  caption: [My cool algorithm],

  pseudocode-list[
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
)
```)

= Numbered title <numbered-title>
#link(<numbered-title>, none)

If you want to have the algorithm counter inside the title instead (see previous
section), there is the option `numbered-title`:
#example(```typ
// SETUP
// START
#figure(
  kind: "algorithm",
  supplement: [Algorithm],

  pseudocode-list(booktabs: true, numbered-title: [My cool algorithm])[
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
) <cool>

See @cool for details on how to do something cool.
```)

Note that the `numbered-title` option only makes sense when nesting your
pseudocode inside a figure with `kind: "algorithm"`, otherwise it produces
undefined results.
