# Lovelace
This is a package for writing pseudocode in [Typst](https://typst.app/).
It is named after the computer science pioneer
[Ada Lovelace](https://en.wikipedia.org/wiki/Ada_Lovelace) and inspired by the
[pseudo package](https://ctan.org/pkg/pseudo) for LaTeX.

![GitHub license](https://img.shields.io/github/license/andreasKroepelin/lovelace)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/andreasKroepelin/lovelace)
![GitHub Repo stars](https://img.shields.io/github/stars/andreasKroepelin/lovelace)

Pseudocode is not a programming language, it doesn't have strict syntax, so
you should be able to write it however you need to in your specific situation.
Lovelace lets you do exactly that.

Main features include:
- arbitrary keywords and syntax structures
- optional line numbering
- line labels
- lots of customisation with sensible defaults


## Usage

- [Getting started](#getting-started)
- [Lower level interface](#lower-level-interface)
- [Line numbers](#line-numbers)
- [Referencing lines](#referencing-lines)
- [Indentation guides](#indentation-guides)
- [Spacing](#spacing)
- [Decorations](#decorations)
- [Algorithm as figure](#algorithm-as-figure)
- [Customisation overview](#customisation-overview)
- [Exported functions](#exported-functions)

### Getting started

Import the package using
```typ
#import "@preview/lovelace:0.3.0": *
```

The simplest usage is via `pseudocode-list` which transforms a nested list
into pseudocode:
```typ
#pseudocode-list[
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
]
```
resulting in:

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="examples/simple-dark.svg">
  <source media="(prefers-color-scheme: light)" srcset="examples/simple-light.svg">
  <img alt="simple" src="examples/simple-light.svg">
</picture>

As you can see, every list item becomes one line of code and nested lists become
indented blocks.
There are no special commands for common keywords and control structures, you
just use whatever you like.



### Exported functions

Lovelace exports the following functions:

* `pseudocode`: Typeset pseudocode with each line as an individual content
  argument, see [here](#lower-level-interface) for details.
  Has [these](#customisation-overview) optional arguments.
* `pseudocode-list`: Takes a standard Typst list and transforms it into a
  pseudocode.
  Has [these](#customisation-overview) optional arguments.
* `indent`: Inside the argument list of `pseudocode`, use `indent` to specify
  an indented block, see [here](#lower-level-interface) for details.
* `no-number`: Wrap an argument to `pseudocode` in this function to have the
  corresponding line be unnumbered, see [here](#line-numbers) for details.
* `with-line-label`: Use this function in the `pseudocode` arguments to add
  a label to a specific line, see [here](#referencing-lines) for details.
* `line-label`: When using `pseudocode-list`, you do *not* use `with-line-label`
  but insert a call to `line-label` somewhere in a line to add a label, see
  [here](#referencing-lines) for details.


