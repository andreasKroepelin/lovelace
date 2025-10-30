#import "setup.typ": *
#set document(title: [Spacing])
#show: toot-page

#title()

You can control how far indented lines are shifted right by the `indentation`
option.
To change the space between lines, use the `line-gap` option.
#example(```typ
// SETUP
// START
#pseudocode-list(indentation: 3em, line-gap: 1.5em)[
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
