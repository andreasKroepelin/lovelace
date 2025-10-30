#import "@preview/toot:0.1.0": setup-toot

#let (toot-page, example, i-link) = setup-toot(
  name: [Lovelace],
  universe-url: "https://typst.app/universe/package/lovelace",
  root: "toot-lovelace",
  styling: (accent-color: maroon),
  outline: include "OUTLINE.typ",
  snippets: (
    (
      trigger: "// SETUP",
      expansion: ```typ
      // LOVELACE IMPORT
      // LIGHT DARK
      #set text(font: "Alegreya Sans", size: 15pt)
      #set page(width: 45em, height: auto, margin: 1em)
      #show math.equation: set text(font: "Lete Sans Math")
      ```.text,
    ),
    (
      trigger: "// LOVELACE IMPORT",
      expansion: ```typ
      #import "@preview/lovelace:0.3.1": *
      ```.text,
    ),
    (
      trigger: "// LIGHT DARK",
      expansion: ```typ
      #show: body => {
        let theme = if sys.inputs.at("theme", default: "light") == "light" {
          (bg: white, fg: black)
        } else {
          (bg: luma(50), fg: luma(210))
        }
        set page(fill: theme.bg)
        set text(fill: theme.fg)

        body
      }
      ```.text,
    ),
  ),
)
