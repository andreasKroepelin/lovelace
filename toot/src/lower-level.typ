#import "setup.typ": *
#set document(title: [Lower level interface])
#show: toot-page

#title()

If you feel uncomfortable with abusing Typst's lists like we did on the previous
page, you can
also use the `#pseudocode` function directly:

```typ
#pseudocode(
  [do something],
  [do something else],
  [*while* still something to do],
  indent(
    [do even more],
    [*if* not done yet *then*],
    indent(
      [wait a bit],
      [resume working],
    ),
    [*else*],
    indent(
      [go home],
    ),
    [*end*],
  ),
  [*end*],
)
```
This is equivalent to the first example.
Note that each line is given as one content argument and you indent a block by
using the `indent` function.

This approach has the advantage that you do not rely on significant whitespace
and code formatters can automatically correctly indent your Typst code.
