# typst-din-5008-letter
A template for DIN 5008 inspired [typst](https://typst.app/home) letter

## Usage
To use the template, create a file next to `letter.typ` and use the important parts of this:

```typst
#import "letter.typ" : letter, defaults
#import emoji

#let empfänger = (
  address: [Frau\ Klara Musterfrau\ Wunderstr. 12A\ 12321 Berlin],
  topextra: [Vertraulich\ Nur von der Person persönlich zu öffnen\ Warum auch nicht],
  ruecksendeangabe: [Max Mustermann, Feldweg 20, 32123 Einöde]
)

#let absender = (
  name: [Max Mustermann],
  address: [Max Mustermann\ Feldweg 20\ 32123 Einöde]
)

#{
  defaults.form = "A" // kann auch 'B' sein
  defaults.falzmarke = true
  defaults.lochmarke = true
  defaults.pagemarginright = 0.7cm
  //defaults.handsigned = true
}

#show: letter.with(
  abs: absender,
  empf: empfänger,
  title: [Betreff dieses Briefes],
  date: [12.03.2418],
  options: defaults,
  //greet: "Liebe Frau Klara Musterfrau",
  //bye: "Viele Grüße",
  bezugszeichen: (
    ([Briefnr.], [A2-335-F12]),
    ([Vertragsnr.], [137 288]),
    ([Datum], [12.03.2418])
  ),
  header: [Eine an DIN 5008 angelehnte Typst Briefvorlage zu finden auf #link("https://www.github.com")],
  footer: [Und noch weiterer Text\ der leider nicht weiter]
)

#for i in (3, 12, 1, 4, 10, 5, 22, 7, 3, 12, 15, 35, 1) {
  lorem(10*i)
  parbreak()
}
```

The resulting pdf looks like shown in the `example` directory.

## TODOS
Because certain functionality is not possible in typst right now, here are some things I want to add later on.
[ ] Footer depending on page number with correct sizing
[ ] Even and odd pages distinction, so that margin fits
