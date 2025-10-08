#import "example-setup.typ": *
#show: example-setup

#pseudocode-list[
  + *in parallel for each* $i = 1, ..., n$ *do*
    + fetch chunk of data $i$
    + *with probability* $exp(-epsilon_i slash k T)$ *do*
      + perform update
    + *end*
  + *end*
]
