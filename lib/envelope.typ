#import "helpers.typ"

#let envelope-styling(
  theme-color: navy,
  text-params: (size: 12pt, font: "Source Sans Pro"),
  margin:      15mm,
  background:  none,
  foreground:  none,

) = {(
  theme-color: theme-color,
  text-params: text-params,
  margin:      margin,
  background:  background,
  foreground:  foreground,
)}

#let envelope-sizes = (
  "C6":    (height: 114mm, width: 162mm, window-margin-bottom: 15mm),
  "DL":    (height: 110mm, width: 220mm, window-margin-bottom: 15mm),
  "C6/C5": (height: 114mm, width: 229mm, window-margin-bottom: 15mm),
  "C5A":   (height: 162mm, width: 229mm, window-margin-bottom: 77mm),
  "C5B":   (height: 162mm, width: 229mm, window-margin-bottom: 60mm),
  "C4A":   (height: 324mm, width: 229mm, window-margin-bottom: 229mm),
  "C4B":   (height: 324mm, width: 229mm, window-margin-bottom: 212mm),
)

#let envelope(
  envelope-format:    "DL",
  sender-zone:        [],
  frank-zone:         [],
  read-zone:          [],
  encoding-zone:      [],
  styling-options:    envelope-styling(),
  debug:              false,
) = {
  if styling-options.margin < 15mm {
    panic("The margin shouldn't be smaller than 15mm.")
  }
  if not envelope-sizes.keys().contains(envelope-format) {
    panic("Only the sizes: `" + envelope-sizes.keys().join("`, `") + "` are supported.")
  }

  let sizes = envelope-sizes.at(envelope-format)

  set page(
    height:     sizes.height,
    width:      sizes.width,
    margin:     0pt,
    background: styling-options.background,
    foreground: styling-options.foreground,
  )

  let (font-size: font-size, lang: lang, styling: styling-options) = helpers.default-font-handler(styling-options)
  set text(..styling-options.text-params)

  place(top + left, block(
    stroke: if debug { red } else { none }, width: 100% - 74mm, height: 40mm, clip: true,
    sender-zone
  ))
  place(top + right, block(
    stroke: if debug { red } else { none }, width: 74mm, height: 40mm, clip: true,
    frank-zone
  ))
  place(top + left, dx: styling-options.margin, dy: 40mm, block(
    stroke: if debug { red } else { none }, width: 100% - 2 * styling-options.margin, height: 100% - 55mm, clip: true,
    read-zone
  ))
  place(bottom + right, block(
    stroke: if debug { red } else { none }, width: 150mm, height: 15mm, clip: true,
    encoding-zone
  ))
  if debug {
    place(bottom + left, dx: 20mm, dy: -sizes.window-margin-bottom, rect(
      stroke: (paint: red, dash: "dashed"), width: 90mm, height: 45mm
    ))
  }
}