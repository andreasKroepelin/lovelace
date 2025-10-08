#import "example-setup.typ": *
#show: example-setup

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
  ],
) <cool>

See @cool for details on how to do something cool.
