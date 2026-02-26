#import "setup.typ": *
#set document(title: [Customization overview])
#show: toot-page

#title()

Both `#pseudocode` and `#pseudocode-list` accept the following configuration
arguments:

#table(
  columns: 3,
  table.header[option][type][default],
  i-link("line-numbers/line-numbers.typ")[`line-numbering`],
  [`none` or a #link("https://typst.app/docs/reference/model/numbering/#parameters-numbering")[numbering]],
  `"1"`,

  i-link("line-numbers/referencing.typ#supplement")[`line-number-supplement`],
  [content or string],
  `"Line"`,

  i-link("line-numbers/customization.typ#alignment")[`line-number-alignment`],
  [alignment],
  `horizon + right`,

  i-link("guides/guides.typ")[`stroke`], [stroke], `1pt + gray`,
  i-link("guides/hooks.typ")[`hooks`], [length], `0pt`,
  i-link("spacing.typ")[`indentation`], [length], `1em`,
  i-link("spacing.typ")[`line-gap`], [length], `.8em`,
  i-link("decoration/booktabs.typ")[`booktabs`], [bool], `false`,
  i-link("decoration/booktabs.typ#stroke")[`booktabs-stroke`],
  [stroke],
  `2pt + text.fill`,

  i-link("decoration/title.typ")[`title`], [content or `none`], `none`,
  i-link("decoration/booktabs.typ#inset")[`title-inset`], [length], `0.8em`,
  i-link("algorithm.typ#numbered-title")[`numbered-title`],
  [content or `none`],
  `none`,
)

Until Typst supports user defined types, we can use the following trick when
wanting to set own default values for these options.
Say, you always want your algorithms to have colons after the line numbers,
no indentation guides and, if present, blue booktabs.
In this case, you would put the following at the top of your document:
```typ
#let my-lovelace-defaults = (
  line-numbering: "1:",
  stroke: none,
  booktabs-stroke: 2pt + blue,
)

#let pseudocode = pseudocode.with(..my-lovelace-defaults)
#let pseudocode-list = pseudocode-list.with(..my-lovelace-defaults)
```

