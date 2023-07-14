#let betreff(content, styling: (:), extras: (:)) = {
  //set align(center)
  set text(styling.theme-color)
  strong(content)
}

#let teilbetreff(content, level: 1, styling: (:), extras: (:)) = {
  set text(styling.theme-color, styling.text-params.size)
  if level == 1 {
    strong(content + ". ")
  } else { text(weight: "regular", style: "italic", content + ". ") }
}

#let bezugszeichen(heading, content, styling: (:), extras: (:)) = {
  text(size: styling.text-params.size - 2pt, heading)
  linebreak()
  text(size: styling.text-params.size, content)
}

#let salutation(wordings: (:), styling: (:), extras: (:)) = {
  wordings.salutation + ","
}

#let closing(wordings: (:), styling: (:), extras: (:), signature: none) = {
  wordings.closing
  linebreak()
  if signature == none and styling.handsigned { linebreak(); linebreak() }
  if signature != none { signature }
  [@name]
}

#let pagenumber(wordings: (:), styling: (:), extras: (:)) = {
  set align(right)
  locate(loc => {
    text(styling.theme-color)[#loc.page()]
    text(gray.darken(50%), " / " + str(counter(page).final(loc).at(0)))
  })
}

#let header(title, wordings: (:), styling: (:), extras: (:)) = locate(loc => if loc.page() > 1 {
  set text(styling.text-params.size - 2pt, styling.theme-color)
  set align(horizon)
  title
  h(1fr)
  [@date]
})

#let attachments(items, wordings: (:), styling: (:), extras: (:)) = if items != () {
  set align(left)
  text(styling.theme-color, strong(wordings.attachments))
  linebreak()
  list(..items)
}

#let postscriptum(content, wordings: (:), styling: (:), extras: (:)) = {
  grid(columns: 2, column-gutter: 0.5em, [PS:], content)
}