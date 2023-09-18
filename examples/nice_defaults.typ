#import "../letter.typ" : letter, letter-styling, block-hooks, debug-options

#let styling-options = letter-styling(
  text-params: (lang: "en"),
  hole-mark: false,
  theme-color: green.darken(40%),
)

#let block-hooks = block-hooks(
  letter-head: pad(10mm)[To be found at #link("https://github.com/ludwig-austermann/typst-din-5008-letter")],
  footer: [some random footer],
  subject: (content, styling: (:), extras: (:)) => {
    set align(center)
    set text(styling.theme-color)
    strong(content)
  }
)

#show: letter.with(
  title: "subject of this letter",
  return-information: [@name, somewhere],
  address-zone: [recipient name\ recipient address],
  information-field: grid(columns: 2, column-gutter: 5mm, row-gutter: 6pt)[Sender:][@name][Address:][sender address][][][][][][][][][][][Date:][@date],
  name: "Your Friendly Friend",
  styling-options: styling-options,
  block-hooks: block-hooks,
  wordings: "en-formal",
)

#for i in (3, 12, 1) {
  lorem(10*i)
  parbreak()
}
