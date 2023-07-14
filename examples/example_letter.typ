#import "../letter.typ" : letter, letter-styling, debug-options, block-hooks

#let styling-options = letter-styling(
  form: "A", // can also be form 'B'
  folding-mark: true,
  hole-mark: true,
  page-margin-right: 2cm,
  background: rotate(60deg, text(60pt, red.lighten(70%), font: "Fira Code")[EXAMPLE LETTER]),
  text-params: (size: 11pt, font: "linux libertine")
)

#let debug-options = debug-options(
  show-block-frames: true,
  show-address-field-calculation: true,
)

#let hooks = block-hooks(
  letter-head: pad(10mm)[A to DIN 5008 kinda conforming #link("https://typst.app")[Typst] extensable letter template to find at
  
  #align(center, link("https://github.com/ludwig-austermann/typst-din-5008-letter")[GitHub -- ludwig-austermann -- typst-din-5008-letter])],
  footer: [And more text in the footer\ and again more],
)

#show: letter.with(
  title: [Subject of letter],
  return-information: [@name, Feldweg 20, 32123 Einöde],
  address-zone: [Frau\ Klara Musterfrau\ Wunderstr. 12A\ 12321 Berlin],
  information-field: grid(columns: 2, column-gutter: 5mm, row-gutter: 6pt)[Sender:][@name][Telefon no.:][@telnr][][][Letter no.:][A2-335-F12][Contract no.:][137 288][][][Date:][@date],
  reference-signs: (
    ([Letter no.], [A2-335-F12]),
    ([Contract no.], [137 288]),
    ([Date], [@date])
  ),
  attachments: ([Something], [Another Thing]),
  ps: [Try it out...],
  signature: pad(rotate(image("Farah_Pahlavi_signature.svg", width: 2cm), -5deg), x: 5pt, bottom: -12pt, top: -4pt),
  name: "Max Mustermann",
  styling-options: styling-options,
  debug-options: debug-options,
  block-hooks: hooks,
  labels: (telnr: [+49 123 4567 89])
)

#set par(justify: true)

#let headlorem(i) = {
  let l = lorem(i)
  l.slice(0, l.len() - 1)
}

#for i in (3, 12, 3, 12, 15, 35, 1) {
  if calc.even(i) { heading(headlorem(calc.quo(i, 2))) }
  else if calc.rem(i, 5) == 0 { heading(headlorem(calc.quo(i, 5)), level: 2) }
  lorem(10 * i)
  footnote(lorem(i))
  parbreak()
}
