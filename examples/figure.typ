#import "example-setup.typ": *
#show: example-setup

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
  ],
)
