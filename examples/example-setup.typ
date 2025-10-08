#import "../lib.typ": *

#let example-setup(body) = {
  let theme = if "theme" in sys.inputs { sys.inputs.theme } else { "light" }
  let bgs = (light: white, dark: navy)
  let fgs = (light: black, dark: luma(200))
  set page(width: auto, height: auto, margin: 1em, fill: bgs.at(theme))
  set text(font: "TeX Gyre Pagella", fill: fgs.at(theme))
  show math.equation: set text(font: "TeX Gyre Pagella Math")

  body
}
