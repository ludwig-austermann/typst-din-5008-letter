#let default-font-handler(styling) = {
  let font-size = if styling.text-params.keys().contains("size") {
    if styling.text-params.size < 10pt {
      panic("The general font size should be at least 10pt!")
    }
    styling.text-params.size
  } else {
    styling.text-params.insert("size", 11pt)
    11pt
  }
  if not styling.text-params.keys().contains("font") {
    styling.text-params.insert("font", "Source Sans Pro")
  }
  let lang = if styling.text-params.keys().contains("lang") {
    styling.text-params.lang
  } else {
    styling.text-params.insert("lang", "de")
    "de"
  }
  (font-size: font-size, lang: lang, styling: styling)
}

#let address-field(address-zone, return-information: [], styling: (:), debug-options: (show-block-frames: false, show-address-field-calculation: false)) = style(sty => {
  let half-height-seperator  = styling.address-field-seperator-spacing / 2
  let rücksendeangabe        = text(styling.text-params.size - 2pt, return-information)
  let height-rücksendeangabe = measure(rücksendeangabe, sty).height + half-height-seperator
  let height-anschriftzone   = measure(address-zone, sty).height + half-height-seperator

  if height-anschriftzone + height-rücksendeangabe > 45mm {
    panic("Anschriftzone + Rücksendeangabe have height > 45mm, consider a smaller font with Anschriftzone font >= 8pt and Rücksendeangabe font >= 6pt.")
  }

  let anschriftfeld-seperator = if height-rücksendeangabe > 17.7mm {
    height-rücksendeangabe
  } else if height-anschriftzone > 27.3mm {
    45mm - height-anschriftzone
  } else { 17.7mm }

  block(
    width: 85mm, height: 45mm, clip: true, inset: (left: 5mm),
    stroke: if debug-options.show-block-frames { red } else { none },
    {
      place(dy: anschriftfeld-seperator - height-rücksendeangabe, rücksendeangabe)
      place(dy: anschriftfeld-seperator + half-height-seperator, address-zone)

      if debug-options.show-address-field-calculation {
        place(dx: -3mm, dy: anschriftfeld-seperator - height-rücksendeangabe, line(length: height-rücksendeangabe, angle: 90deg))
        place(dx: -4mm, dy: anschriftfeld-seperator - height-rücksendeangabe, line(length: 2mm))
        place(dx: -4mm, dy: anschriftfeld-seperator -  half-height-seperator, line(length: 2mm))

        place(dx: -5mm, dy: anschriftfeld-seperator, line(length: 5mm))

        place(dx: -2mm, dy: anschriftfeld-seperator, line(length: height-anschriftzone, angle: 90deg))
        place(dx: -3mm, dy: anschriftfeld-seperator + half-height-seperator, line(length: 2mm))
        place(dx: -3mm, dy: anschriftfeld-seperator + height-anschriftzone, line(length: 2mm))

        place(dx: -5mm, dy: 17.7mm, line(stroke: red + 0.2pt, length: 5mm))
      }
    }
  )
})