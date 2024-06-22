#import "../lib.typ": *
// #set page(width: 30em, height: auto)
#set text(font: "Fira Sans", number-type: "old-style")
#show math.equation: set text(font: "Fira Math")

#show: setup-lovelace.with(
  line-number-supplement: "Zeile",
)

#pseudocode-new-grid(
  // line-number-transform: n => numbering("1", 10*n),
  indentation-guide-stroke: (thickness: 1pt, paint: gray, dash: "solid"),
  new-no-number[*input:* Graph $G = (V, E)$ with edge lengths $e$, source $w$],
  new-no-number[*output:* distances $"dist"$, predecessors $"prev"$],
  [$Q <- $ empty queue],
  [*for each* $v in V$ *do*],
  indent(
    [$"dist"[v] <- oo$],
    [$"prev"[v] <- perp$ #comment[$perp$ denotes undefined]],
    [add $v$ to $Q$],
  ),
  [*end*],
  [$"dist"[w] <- 0$ #comment[We start at $w$ so the distance must be zero]],
  new-no-number[],
  [*while* $Q$ is not empty *do*],
  indent(
    new-line-label(<line:argmin>)[$u <- op("argmin")_(u in Q) "dist"[u]$],
    [remove $u$ from $Q$],
    [*for each* neighbour $v$ of $u$ still in $Q$ *do*],
    indent(
      [$d' <- "dist"[u] + e(u, v)$],
      [*if* $d' < "dist"[v]$ *then*],
      indent(
        $"dist"[v] <- d'$,
        [for demo purposes, here comes a long line: #lorem(10)],
        $"prev"[v] <- u$,
      ),
      [*end*],
    ),
    [*end*],
  ),
  [*end*],
)

The crucial step happens in @line:argmin.
Here, we need $"dist"$ to be an instance of a data structure that allows us to
find the $op("argmin")$ efficiently.


#algorithm(
  caption: lorem(20),
  supplement: "Algorithmus",
  placement: none,
  pseudocode(
    indentation-guide-stroke: 1pt + gray,
    <line:test>,
    [this is a very short algorithm],
    ..range(10).map(i => ([or is it?], ind)).flatten()
  )
) <the-algo>

The line number starts counting from @line:test again in @the-algo.


// #pseudocode-new-grid(
//   [hallo], [welt]
// )

#pseudocode-new-grid(
  // line-numbering: false,
  indentation-guide-stroke: 1pt + teal,
  title: lorem(30),
  // booktabs-stroke: 2pt + black,
  [abc],
  [def],
  indent(
    [ghi],
    [jkl],
    new-line-label(<abc>)[jkl],
  ),
  [end],
  indent(
    [a],
    indent(
      [b],
      indent(
        [c],
        [d],
      ),
      [e],
    ),
    [#lorem(10)],
  ),
  [g],
  ..(([hallo], ) * 20)
)

// See @abc for details.


#figure(
  kind: "algorithm",
  supplement: [Algorithm],
  caption: [hallo],
  pseudocode-new-grid(
    title: [Local search],
    booktabs-stroke: 2pt + black,
    [abc], [def],
    [abc], [def],
    indent([abc], [def],),
    [abc], [#lorem(30)],
  )
)

#repr[
  - abc
  + def
    + hij
]

