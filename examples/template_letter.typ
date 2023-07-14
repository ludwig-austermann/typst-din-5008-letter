#import "../letter.typ" : letter, letter-styling, block-hooks, debug-options

#let block-hooks = block-hooks(
  letter-head: pad(10mm)[*header.* A DIN 5008 based Typst letter template, to be found at:\
  #link("https://github.com/ludwig-austermann/typst-din-5008-letter")],
  footer: [some footer]
)

#show: letter.with(
  name: text(green)[sender name],
  return-information: [@name, somewhere\ further information],
  address-zone: [recipient name\ recipient address],
  information-field: grid(columns: 2, column-gutter: 5mm, row-gutter: 6pt)[Sender:][@name][Address:][sender address],
  title: [subject of letter],
  reference-signs: (
    ([Reference 1], [A2-335-F12]),
    ([Reference 2], [137 288]),
    ([Date], [@date])
  ),
  block-hooks: block-hooks,
  wordings: "debug"
)

#for i in (3, 12, 3, 12, 15, 35, 1) {
  lorem(10*i)
  parbreak()
}
