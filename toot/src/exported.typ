#import "setup.typ": *
#set document(title: [Exported functions])
#show: toot-page

#title()

Lovelace exports the following functions:

- `pseudocode`: Typeset pseudocode with each line as an individual content
  argument, see #i-link("lower-level.typ")[here] for details.
  Has #i-link("overview.typ")[these] optional arguments.
- `pseudocode-list`: Takes a standard Typst list and transforms it into a
  pseudocode.
  Has #i-link("overview.typ")[these] optional arguments.
- `indent`: Inside the argument list of `pseudocode`, use `indent` to specify
  an indented block, see #i-link("lower-level.typ")[here] for details.
- `no-number`: Wrap an argument to `pseudocode` in this function to have the
  corresponding line be unnumbered, see
  #i-link("line-numbers/line-numbers.typ")[here] for details.
- `with-line-label`: Use this function in the `pseudocode` arguments to add
  a label to a specific line, see #i-link("line-numbers/referencing.typ")[here]
  for details.
- `line-label`: When using `pseudocode-list`, you do *not* use `with-line-label`
  but insert a call to `line-label` somewhere in a line to add a label, see
  #i-link("line-numbers/referencing.typ")[here] for details.

