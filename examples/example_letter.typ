#import "../letter.typ" : letter, defaults

#let empfänger = (
  address: [Frau\ Klara Musterfrau\ Wunderstr. 12A\ 12321 Berlin],
  topextra: [Vertraulich\ Nur von der Person persönlich zu öffnen\ Warum auch nicht],
  return_information: [Max Mustermann, Feldweg 20, 32123 Einöde]
)

#let absender = (
  name: [Max Mustermann],
  address: [Max Mustermann\ Feldweg 20\ 32123 Einöde]
)

#{
  defaults.form = "A" // can also be form 'B'
  defaults.folding_mark = true
  defaults.hole_mark = true
  defaults.pagemarginright = 0.7cm
  //defaults.handsigned = true
}

#show: letter.with(
  sender: absender,
  recipient: empfänger,
  title: [Betreff dieses Briefes],
  date: [12.03.2418],
  options: defaults,
  reference_signs: (
    ([Briefnr.], [A2-335-F12]),
    ([Vertragsnr.], [137 288]),
    ([Datum], [12.03.2418])
  ),
  header: [Eine an DIN 5008 angelehnte Typst Briefvorlage zu finden auf #link("https://www.github.com")],
  footer: [Und noch weiterer Text\ der leider nicht weiter]
)

#for i in (3, 12, 3, 12, 15, 35, 1) {
  lorem(10*i)
  parbreak()
}
