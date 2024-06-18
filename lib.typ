#let ind = metadata("lovelace indent")
#let ded = metadata("lovelace dedent")
#let no-number = metadata("lovelace no number")
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

#let line-number-supplement = state("lovelace-line-number-supplement", "Line")

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

#let new-no-number(body) = {
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

#let new-line-label(label, body) = {
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

#let line-number-figure(number, label) = {
  counter(figure.where(kind: "lovelace-line-number")).update(number - 1)
  show: align.with(right + horizon)
  text(size: .9em, number-width: "tabular")[#number]

  if label != none {
    box(context[
      #figure(
        kind: "lovelace-line-number",
        supplement: line-number-supplement.get(),
        [],
      )
      #label
    ])
  }
}

#let pseudocode-new-grid(
  line-numbering: true,
  indentation-guide-stroke: none,
  indentation-size: 1em,
  indentation-guide-inset: .3em,
  booktabs-stroke: none,
  title: none,
  ..children,
) = {
  children = children.pos().map(normalize-line)

  let collect-precursors(level, line-number, y, children) = {
    let precursors = ()
    for child in children {
      if type(child) == dictionary {
        let content-precursor = (
          level: level,
          y: y,
          body: par(
            hanging-indent: .5em,
            child.body
          ),
          numbered: child.numbered,
          kind: "content",
        )
        precursors.push(content-precursor)
        if child.numbered {
          let number-precursor = (
            y: y,
            body: line-number-figure(line-number, child.label),
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
          level: level,
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
  let max-level = precursors.fold(0, (curr-max, prec) => {
    if "level" in prec {
      calc.max(curr-max, prec.level)
    } else {
      curr-max
    }
  })
  let line-number-correction = if line-numbering { 1 } else { 0 }
  let title-correction = if title != none { 1 } else { 0 }

  let cells = precursors.map(prec => {
    if prec.kind == "content" {
      grid.cell(
        x: prec.level + line-number-correction,
        y: prec.y + title-correction,
        colspan: max-level + 1 - prec.level,
        rowspan: 1,
        stroke: none,
        prec.body,
      )
    } else if prec.kind == "number" and line-numbering {
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
        x: prec.level + line-number-correction,
        y: prec.y + title-correction,
        colspan: 1,
        rowspan: prec.rowspan,
        stroke: (right: indentation-guide-stroke, rest: none),
        h(indentation-guide-inset),
      )
    } else { () }
  }).flatten()

  let max-y = calc.max(..cells.map(cell => cell.y))

  // precursors
  // cells

  let title-cells = if title == none {
    ()
  } else {
    (
      grid.header(
        grid.cell(
          x: 0, y: 0,
          colspan: max-level + 1 + line-number-correction,
          rowspan: 1,
          inset: (y: .8em),
          stroke: (bottom: booktabs-stroke),
          title
        ),
      ),
    )
  }

  let booktab-hlines =  (
    grid.hline(y: 0, stroke: booktabs-stroke),
    grid.footer(
      grid.cell(
        y: max-y + 1,
        colspan: max-level + 1 + line-number-correction,
        rowspan: 1,
        stroke: (top: booktabs-stroke),
        none
      ),
    ),
  )

  grid(
    columns: max-level + 1 + line-number-correction,
    column-gutter: indentation-size - indentation-guide-inset,
    row-gutter: .8em,
    ..title-cells,
    ..cells,
    ..booktab-hlines,
  )
}

#let comment(body) = {
  h(1fr)
  text(size: .7em, fill: gray, sym.triangle.stroked.r + sym.space + body)
}

#let pseudocode(
  line-numbering: true,
  line-number-transform: it => it,
  indentation-guide-stroke: none,
  indentation-size: 1em,
  ..children
) = {
  let lines = ()
  let indentation = 0
  let max-indentation = 0
  let line-no = 1
  let curr-label = none
  let numbered-line = true
  let indentation-box = box.with(
    inset: (left: indentation-size, rest: 0pt),
    stroke: (left: indentation-guide-stroke, rest: none)
  )
  let rep-app(fn, init, num) = {
    let x = init
    for i in range(num) {
      x = fn(x)
    }
    x
  }

  for child in children.pos() {
    if child == ind {
      indentation += 1
    } else if child == ded {
      indentation -= 1
    } else if child == no-number {
      numbered-line = false
    } else if type(child) == label {
      curr-label = child
    } else {
      lines.push((
        no: if numbered-line and line-numbering {
          align(right + horizon)[
            #figure(
              kind: "lovelace-line-no",
              supplement: "Line",
              [#line-number-transform(line-no)]
            )
            #curr-label
          ]
        },
        line: rep-app(
          indentation-box,
          pad(left: -2pt, rest: 4pt, child),
          indentation
        )
      ))
      if numbered-line {
        line-no += 1
      }
      curr-label = none
      numbered-line = true
    }
  }

  set par(hanging-indent: .5em)
  let columns = if line-numbering { 2 } else { 1 }
  let cells = if line-numbering {
    lines.map(line => ( line.no, line.line ) ).flatten()
  } else {
    lines.map(line => line.line)
  }
  
  grid(
    columns: columns,
    column-gutter: 1em,
    row-gutter: .3em,
    ..cells
  )
}

#let pseudocode-list(..config, body) = {
  let is-not-empty(it) = {
    return type(it) != content or not (
      it.fields() == (:) or
      (it.has("children") and it.children == ()) or
      (it.has("children") and it.children.all(c => not is-not-empty(c))) or
      (it.has("text") and it.text.match(regex("^\\s*$")) != none)
    )
  }

  let transform-list(it) = {
    if not it.has("children") {
      return it
    }

    let transformed = ()
    let current-normal-child = []
    for child in it.children {
      if child.func() in (enum.item, list.item) {
        if is-not-empty(current-normal-child) {
          transformed.push(current-normal-child)
          current-normal-child = []
        }
        transformed.push(ind)
        if child.func() == list.item {
          transformed.push(no-number)
        }
        transformed.push(transform-list(child.body))
        transformed.push(ded)
      } else if (
        child.func() == metadata and
        child.value.at("identifier", default: "") == "lovelace line label" and
        "label" in child.value
      ) {
        transformed.push(child.value.label)
      } else {
        current-normal-child += child
      }
    }
    if is-not-empty(current-normal-child) {
      transformed.push(current-normal-child)
    }

    transformed
  }

  let transformed = transform-list(body)
  let cleaned = transformed.flatten().filter(is-not-empty)
  let dedented = cleaned
  while dedented.first() == ind and dedented.last() == ded {
    dedented = dedented.slice(1, -1)
  }

  pseudocode(..config.named(), ..dedented)
}

#let pseudocode-raw(typst-code, ..config, scope: (:)) = {
  assert.eq(type(typst-code), content)
  assert.eq(typst-code.func(), raw)

  let indent = 0
  let last-indent = 0
  let res = ()
  for line in typst-code.text.split("\n") {
    let whitespaces = line.find(regex("^\\s+"))
    let current-indent = if whitespaces != none { whitespaces.len() } else { 0 }
    if indent == 0 and current-indent != 0 {
      indent = current-indent
    }
    if current-indent > last-indent {
      res += (ind,) * int((current-indent - last-indent) / indent)
    } else if current-indent < last-indent {
      res += (ded,) * int((last-indent - current-indent) / indent)
    }
    last-indent = current-indent
    let line-code = line.slice(current-indent)
    let match = line-code.match(regex("^<(.*)>\\s*$"))
    if (match != none) {
      res.push(label(match.captures.at(0)))
    } else {
      res.push(eval(line-code, mode: "markup", scope: (no-number: no-number, comment: comment) + scope))
    }
  }
  pseudocode(..config.named(), ..res)
}


#let algorithm = figure.with(kind: "lovelace", supplement: "Algorithm")

#let setup-lovelace(
  line-number-style: text.with(size: .7em),
  line-number-supplement: "Line",
  body-inset: (bottom: 5pt),
  body
) = {
  show ref: it => if (
    it.element != none and
    it.element.func() == figure and
    it.element.kind == "lovelace-line-no"
  ) {
    link(
      it.element.location(),
      { line-number-supplement; sym.space; it.element.body }
    )
  } else {
    it
  }
  show figure.where(kind: "lovelace-line-no"): it => line-number-style(it.body)
  show figure.where(kind: "lovelace"): it => {
    let booktabbed = block(
      stroke: (y: 1.3pt),
      inset: 0pt,
      breakable: true,
      width: 100%,
      {
        set align(left)
        block(
          inset: (y: 5pt),
          width: 100%,
          stroke: (bottom: .8pt),
          {
            strong({
              it.supplement
              sym.space.nobreak
              counter(figure.where(kind: "lovelace")).display(it.numbering)
              if it.caption != none {
                [: ]
              } else {
                [.]
              }
            })
            if it.caption != none {it.caption.body}
          }

        )
        block(
          inset: body-inset,
          breakable: true,
          it.body
        )
      }
    )
    let centered = pad(x: 5%, booktabbed)
    if it.placement in (auto, top, bottom) {
      place(it.placement, float: true, centered)
    } else {
      centered
    }
  }

  body
}
