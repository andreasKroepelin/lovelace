#import "../setup.typ": *
#set document(title: [Title])
#show: toot-page

#title()

Using the `title` option, you can give your pseudocode a title (surprise!).
For example, to achieve
#link("https://en.wikipedia.org/wiki/Introduction_to_Algorithms")[CLRS style],
you can do something like
#example(```typ
// SETUP
// START
#pseudocode-list(stroke: none, title: smallcaps[Fancy-Algorithm])[
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

