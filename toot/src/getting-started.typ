#import "setup.typ": *
#set document(title: [Getting started])
#show: toot-page

#title()

Import the package using
#example(
  hide-output: true,
  ```typ
  // START
  // LOVELACE IMPORT
  ```,
)

The simplest usage is via `#pseudocode-list` which transforms a nested list
into pseudocode:
#example(```typ
// SETUP
// START
#pseudocode-list[
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

As you can see, every list item becomes one line of code and nested lists become
indented blocks.
There are no special commands for common keywords and control structures, you
just use whatever you like.

Maybe in your domain very uncommon structures make more sense?
No problem!

#example(```typ
// SETUP
// START
#pseudocode-list[
  + *in parallel for each* $i = 1, ..., n$ *do*
    + fetch chunk of data $i$
    + *with probability* $exp(-epsilon_i slash k T)$ *do*
      + perform update
    + *end*
  + *end*
]
```)
