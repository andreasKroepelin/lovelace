#import "example-setup.typ": *
#show: example-setup

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
    indent([go home]),
    [*end*],
  ),
  [*end*],
)
