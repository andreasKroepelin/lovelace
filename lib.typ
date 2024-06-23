#let line-label(it) = {
  if type(it) == str {
    it = label(it)
  } else if type(it) == label {
    // nothing
  } else {
    panic("line-label requires either a string or a label.")
  }

  metadata((
    identifier: "lovelace line label",
    label: it
  ))
}

#let normalize-line(line) = {
  if type(line) == content {
    (
      numbered: true,
      label: none,
      body: line,
    )
  } else if type(line) == dictionary {
    if ("numbered", "label", "body").all(key => key in line) {
      line
    } else {
      panic("Pseudocode line in form of dictionary has wrong keys.")
    }
  } else if type(line) == array {
    line
  } else {
    panic("Pseudocode line must be content or dictionary.")
  }
}

#let indent(..children) = children.pos().map(normalize-line)

#let no-number(body) = {
  if type(body) == content {
    (
      numbered: false,
      label: none,
      body: body,
    )
  } else if type(body) == dictionary {
    body.numbered = false
    body
  }
}

#let with-line-label(label, body) = {
  if type(body) == content {
    (
      numbered: true,
      label: label,
      body: body,
    )
  } else if type(body) == dictionary {
    body.label = label
    body
  }
}

#let line-number-figure(number, label, supplement, line-numbering) = {
  if line-numbering == none { return }
  counter(figure.where(kind: "lovelace-line-number")).update(number - 1)
  show: align.with(right + horizon)
  text(size: .8em, number-width: "tabular")[#numbering(line-numbering, number)]

  if label != none {
    box[
      #figure(
        kind: "lovelace-line-number",
        supplement: supplement,
        numbering: line-numbering,
        none,
      )
      #label
    ]
  }
}

#let half-stroke(s) = {
  if s == none {
    none
  } else if type(s) == stroke {
    (
      paint: s.paint,
      thickness: s.thickness / 2,
      cap: s.cap,
      join: s.join,
      dash: s.dash,
      miter-limit: s.miter-limit,
    )
  } else if type(s) == dictionary {
    half-stroke(stroke(s))
  }
}

#let identify-algorithm = context {
  let algos = query(figure.where(kind: "algorithm").before(here()))
  if algos.len() > 0 {
    let algo = algos.last()
    
    [#algo.supplement #algo.counter.display(algo.numbering)]
  }
}

#let pseudocode(
  line-numbering: "1",
  line-number-supplement: "Line",
  stroke: 1pt + gray,
  indentation: 1em,
  hooks: 0pt,
  booktabs-stroke: black + 2pt,
  booktabs: false,
  title: none,
  numbered-title: none,
  ..children,
) = {
  children = children.pos().map(normalize-line)

  let collect-precursors(level, line-number, y, children) = {
    let precursors = ()
    for child in children {
      if type(child) == dictionary {
        let content-precursor = (
          x: 2 * level,
          y: y,
          body: {
            set par(hanging-indent: .5em)
            set align(left)
            child.body
          },
          numbered: child.numbered,
          kind: "content",
        )
        precursors.push(content-precursor)
        if child.numbered {
          let number-precursor = (
            y: y,
            body: line-number-figure(
              line-number,
              child.label,
              line-number-supplement,
              line-numbering
            ),
            kind: "number",
          )
          precursors.push(number-precursor)

          line-number += 1
        }

        y += 1
      } else if type(child) == array {
        let nested-precursors = collect-precursors(
          level + 1,
          line-number,
          y,
          child
        )
        let nested-lines = nested-precursors.filter(p => p.kind == "content")
        let indent-precursor = (
          x: 2 * level + 1,
          y: y,
          rowspan: nested-lines.len(),
          kind: "indent",
        )
        precursors.push(indent-precursor)
        precursors += nested-precursors
        line-number += nested-lines.filter(p => p.numbered).len()
        y += nested-lines.len()
      }
    }

    precursors
  }

  let precursors = collect-precursors(0, 1, 0, children)
  let max-x = precursors.fold(0, (curr-max, prec) => {
    if "x" in prec {
      calc.max(curr-max, prec.x)
    } else {
      curr-max
    }
  })

  if numbered-title != none {
    if numbered-title == [] {
      title = [*#identify-algorithm.*]
    } else {
      title = [*#identify-algorithm:* #numbered-title]
    }
  }

  if not booktabs {
    booktabs-stroke = none
  }

  let line-number-correction = if line-numbering != none { 1 } else { 0 }
  let title-correction = if title != none { 1 } else { 1 }

  let cells = precursors.map(prec => {
    if prec.kind == "content" {
      grid.cell(
        x: prec.x + line-number-correction,
        y: prec.y + title-correction,
        colspan: max-x + 1 - prec.x,
        rowspan: 1,
        stroke: none,
        prec.body,
      )
    } else if prec.kind == "number" and line-numbering != none {
      grid.cell(
        x: 0,
        y: prec.y + title-correction,
        colspan: 1,
        rowspan: 1,
        stroke: none,
        prec.body,
      )
    } else if prec.kind == "indent" {
      grid.cell(
        x: prec.x + line-number-correction,
        y: prec.y + title-correction,
        colspan: 1,
        rowspan: prec.rowspan,
        stroke: (left: stroke, bottom: stroke, rest: none),
        h(hooks),
      )
    } else { () }
  }).flatten()

  let max-y = calc.max(..cells.map(cell => cell.y))

  let title-cell = grid.header(grid.cell(
    x: 0, y: 0,
    colspan: max-x + 1 + line-number-correction,
    rowspan: 1,
    inset: if title != none { (y: .8em) } else { 0pt },
    stroke: if title != none {
      (bottom: half-stroke(booktabs-stroke))
    },
    {
      set align(left)
      title
    }
  ))

  let booktab-hlines =  (
    grid.hline(y: 0, stroke: booktabs-stroke),
    grid.footer(
      grid.cell(
        y: max-y + 1,
        colspan: max-x + 1 + line-number-correction,
        rowspan: 1,
        stroke: (top: booktabs-stroke),
        none
      ),
    ),
  )

  grid(
    columns: max-x + 1 + line-number-correction,
    column-gutter: indentation / 2,
    row-gutter: .8em,
    title-cell,
    ..cells,
    ..booktab-hlines,
  )
}



#let comment(body) = {
  h(1fr)
  text(size: .7em, fill: gray, sym.triangle.stroked.r + sym.space + body)
}

#let is-not-empty(it) = {
  return type(it) != content or not (
    it.fields() == (:) or
    (it.has("children") and it.children == ()) or
    (it.has("children") and it.children.all(c => not is-not-empty(c))) or
    (it.has("text") and it.text.match(regex("^\\s*$")) != none)
  )
}

#let unwrap-singleton(a) = {
  while type(a) == array and a.len() == 1 {
    a = a.first()
  }
  a
}

#let pseudocode-list(..config, body) = {
  let transform-list(it, numbered) = {
    if not it.has("children") {
      if numbered {
        return (it, )
      } else {
        return (new-no-number(it), )
      }
    }
    let transformed = ()
    let non-item-child = []
    let non-item-label = none
    let items = ()
    for child in it.children {
      let f = child.func()
      if f in (enum.item, list.item) {
        items += transform-list(child.body, f == enum.item)
      } else if (
        child.func() == metadata and
        child.value.at("identifier", default: "") == "lovelace line label" and
        "label" in child.value
      ) {
        non-item-label = child.value.label
      } else {
        non-item-child += child
      }
    }

    if is-not-empty(non-item-child) {
      if numbered {
        transformed.push(new-line-label(non-item-label, non-item-child))
      } else {
        transformed.push(new-no-number(non-item-child))
      }
    }
    if items.len() > 0 {
      transformed.push(indent(..items))
    }
    transformed
  }

  let transformed = unwrap-singleton(transform-list(body, false))
  pseudocode-new-grid(..config.named(), ..transformed)
}

