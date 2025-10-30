#import "../setup.typ": *
#set document(title: [Ending blocks with hooks])
#show: toot-page

#title()

Some people prefer using the indentation guide to signal the end of a block
instead of writing something like "*end*" by having a small "hook" at the end.
To achieve that in Lovelace, you can make use of the `hooks` option and specify
how far a line should extend to the right from the indentation guide:
#example(```typ
// SETUP
// START
#pseudocode-list(hooks: .5em)[
  + do something
  + do something else
  + *while* still something to do
    + do even more
    + *if* not done yet *then*
      + wait a bit
      + resume working
    + *else*
      + go home
]
```)

