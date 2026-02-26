#import "../setup.typ": *
#set document(title: [Referencing lines])
#show: toot-page

#title()

You can reference an inividual line of a pseudocode by giving it a label.
Inside `#pseudocode-list`, you can use `line-label`:

#example(```typ
// SETUP
// START
#pseudocode-list[
  + #line-label(<start>) do something
  + #line-label(<important>) do something important
  + go back to @start
]

The relevance of the step in @important cannot be overstated.
```)

When using `#pseudocode`, you can use `with-line-label`:
```typ
#pseudocode(
  with-line-label(<start>)[do something],
  with-line-label(<important>)[do something important],
  [go back to @start],
)

The relevance of the step in @important cannot be overstated.
```
This has the same effect as the previous example.

The number shown in the reference uses the numbering scheme defined in the
`line-numbering` option (see previous section).

= Supplement <supplement>
#link(<supplement>)[]

By default, `"Line"` is used as the supplement for referencing lines.
You can change that using the `line-number-supplement` option to `pseudocode`
or `pseudocode-list`.

#example(```typ
// SETUP
// START
#pseudocode-list(line-number-supplement: "Step")[
  + Stir vegetables on low heat.
  + *while* not tasty enough
    + #line-label(<soy-sauce>) Add soy sauce.
    + Taste again.
  + *end*
  + Serve hot.
]

@soy-sauce is the secret to a great meal.
```)
