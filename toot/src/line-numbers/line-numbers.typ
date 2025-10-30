#import "../setup.typ": *
#set document(title: [Line numbers])
#show: toot-page

#title()

Lovelace puts a number in front of each line by default.
If you want no numbers at all, you can set the `line-numbering` option to
`none`.
The initial example then looks like this:
#example(```typ
// SETUP
// START
#pseudocode-list(line-numbering: none)[
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

(You can also pass this keyword argument to `#pseudocode`.)

If you do want line numbers in general but need to turn them off for specific
lines, you can use `-` items instead of `+` items in `#pseudocode-list`:
#example(```typ
// SETUP
// START
#pseudocode-list[
  + normal line with a number
  - this line has no number
  + this one has a number again
]
```)

It's easy to remember:
`-` items usually produce unnumbered lists and `+` items produce numbered lists!

When using the `#pseudocode` function, you can achieve the same using
`no-number`:
```typ
#pseudocode(
  [normal line with a number],
  no-number[this line has no number],
  [this one has a number again],
)
```
