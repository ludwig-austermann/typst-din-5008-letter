#import "lib/default-blocks.typ"
#import "lib/helpers.typ"
#import "lib/envelope.typ"

/// A convinience function to provide styling options with defaults.
#let letter-styling(
    theme-color:                     navy,
    text-params:                     (size: 12pt, font: "Source Sans Pro"),
    page-margin-right:               2cm,
    folding-mark:                    true,
    hole-mark:                       true,
    form:                            "A",
    handsigned:                      false,
    attachment-right:                true,
    background:                      none,
    foreground:                      none,
    head-par-leading:                0.5em, // 0.58 -> tight, 0.65 -> typst standard
    address-field-seperator-spacing: 6pt,
    pagenumber-content-spacing:      6pt,
    pagenumber-footer-spacing:       6pt,
    footer-bottom-margin:            12pt,
  date-block-style: "sender") = (
    theme-color:                     theme-color,
    text-params:                     text-params,
    page-margin-right:               page-margin-right,
    folding-mark:                    folding-mark,
    hole-mark:                       hole-mark,
    form:                            form,
    handsigned:                      handsigned,
    attachment-right:                attachment-right,
    background:                      background,
    foreground:                      foreground,
    date-block-style:                date-block-style,
    head-par-leading:                head-par-leading,
    address-field-seperator-spacing: address-field-seperator-spacing,
    pagenumber-content-spacing:      pagenumber-content-spacing,
    pagenumber-footer-spacing:       pagenumber-footer-spacing,
    footer-bottom-margin:            footer-bottom-margin,
  )

#let load-wordings(lang, wordings-file: "lib/wordings.toml") = {
  let wordings-dict = toml(wordings-file)
  if wordings-dict.keys().contains(lang) {
    wordings-dict.at(lang)
  } else {
    panic("Unfortunately, `" + lang + "` does not exist in `" + wordings-file + "`.")
  }
}

#let debug-options(
  show-block-frames:              false,
  show-address-field-calculation: false
) = (
  show-block-frames:              show-block-frames,
  show-address-field-calculation: show-address-field-calculation
)

#let block-hooks(
  subject:         default-blocks.betreff,
  subsubject:      default-blocks.teilbetreff,
  reference-signs: default-blocks.bezugszeichen,
  salutation:      default-blocks.salutation,
  closing:         default-blocks.closing,
  pagenumber:      default-blocks.pagenumber,
  letter-head:     [],
  attachments:     default-blocks.attachments,
  postscriptum:    default-blocks.postscriptum,
  header:          default-blocks.header,
  footer:          [],
) = (
  subject:         subject,
  subsubject:      subsubject,
  reference-signs: reference-signs,
  salutation:      salutation,
  closing:         closing,
  pagenumber:      pagenumber,
  letter-head:     letter-head,
  attachments:     attachments,
  postscriptum:    postscriptum,
  header:          header,
  footer:          footer,
)

// see https://ftp.rrze.uni-erlangen.de/ctan/macros/latex/contrib/koma-script/doc/scrguide-de.pdf
// look at: https://www.deutschepost.de/de/b/briefvorlagen/normbrief-din-5008-vorlage.html
// look at: https://de.wikipedia.org/wiki/DIN_5008

#let letter(
  content,
  title:              none,
  address-zone:       [],
  return-information: [],
  information-field:  [],
  reference-signs:    (),
  attachments:        (),
  ps:                 none,
  signature:          none,
  name:               [You should change the `name` argument :/],
  date:               datetime.today().display("[year]-[month]-[day]"),
  wordings:           auto,
  styling-options:    letter-styling(),
  debug-options:      debug-options(),
  block-hooks:        block-hooks(),
  labels:             (:),
  extra-options:      (:),
) = {
  /*let font-size = if styling-options.text-params.keys().contains("size") {
    if styling-options.text-params.size < 10pt {
      panic("The general font size should be at least 10pt!")
    }
    styling-options.text-params.size
  } else {
    styling-options.text-params.insert("size", 11pt)
    11pt
  }
  if not styling-options.text-params.keys().contains("font") {
    styling-options.text-params.insert("font", "Source Sans Pro")
  }
  let lang = if styling-options.text-params.keys().contains("lang") {
    styling-options.text-params.lang
  } else {
    styling-options.text-params.insert("lang", "de")
    "de"
  }*/
  let (font-size: font-size, lang: lang, styling: styling-options) = helpers.default-font-handler(styling-options)
  set text(..styling-options.text-params)

  let top-margin      = if styling-options.form == "A" { 27mm } else { 45mm }
  let paper-width     = 595.28pt // according to din a4 paper
  let info-top-margin = top-margin + 5mm

  let falzmarke1      = top-margin + 60mm
  let falzmarke2      = falzmarke1 + 105mm
  let hole-mark       = 148.5mm

  // labeling system, defines variables with @date, @name
  labels.insert("date", date)
  labels.insert("name", name)
  show ref: x => {
    let lbl = str(x.target)
    if labels.keys().contains(lbl) {
      labels.at(lbl)
    } else { x }
  }

  if wordings == auto {
    wordings = load-wordings(lang + "-formal")
  } else if type(wordings) == str {
    wordings = load-wordings(wordings)
  }

  let footer-content = {
    set text(font-size - 2pt)
    set align(bottom)

    let pagenumber-content = (block-hooks.pagenumber)(styling: styling-options, extras: extra-options)

    if pagenumber-content != none {
      pagenumber-content
      v(styling-options.pagenumber-footer-spacing, weak: true)
    }

    block-hooks.footer
    v(styling-options.footer-bottom-margin)
  }

  style(sty => {
    let bottom-margin = measure(footer-content, sty).height + styling-options.pagenumber-content-spacing

    set page(
      margin: (
        left: 25mm,
        top: top-margin,
        right: styling-options.page-margin-right,
        bottom: bottom-margin,
      ),
      header: (block-hooks.header)(title, wordings: wordings, styling: styling-options, extras: extra-options),
      footer: footer-content,
      background: locate(loc => {
        if styling-options.folding-mark {
          place(left + top, dy: falzmarke1, line(stroke: gray, length: 5mm))
          place(left + top, dy: falzmarke2, line(stroke: gray, length: 5mm))
        }

        if styling-options.hole-mark { place(left + top, dy: hole-mark, line(stroke: gray, length: 7mm)) }

        if debug-options.show-block-frames { place(left + top, dx: 25mm, dy: top-margin, rect(width: 100% - 25mm - styling-options.page-margin-right, height: 100% - top-margin - bottom-margin, stroke: red )) }
      }) + styling-options.background,
      foreground: styling-options.foreground
    )

    // Letter Head
    {
      set par(leading: styling-options.head-par-leading)
      style(sty => move(dy: -top-margin, { // reverse margin
        // Briefkopf
        place(dx: -25mm, block(
          width: paper-width, height: top-margin, clip: true,
          stroke: if debug-options.show-block-frames { red } else { none },
          block-hooks.letter-head
        ))

        // Anschriftfeld
        let anschriftfeld = helpers.address-field(address-zone, return-information: return-information, styling: styling-options, debug-options: debug-options)

        place(top + left, dx: -5mm, dy: top-margin, anschriftfeld)
        
        // Informationsblock
        let informationsblock = block(
          width: 75mm, clip: true,
          stroke: if debug-options.show-block-frames { red } else { none },
          information-field
        )
        place(dx: 100mm, dy: info-top-margin, informationsblock)

        let infoheight = calc.max(40mm, measure(informationsblock, sty).height)

        v(infoheight + 24pt)

        // Bezugszeichen
        if reference-signs.len() > 0 {
          move(dy: info-top-margin,
            grid(
              columns: (50mm, 50mm, 50mm, auto),
              row-gutter: 8.46mm / 2,
              ..reference-signs.map(k => (block-hooks.reference-signs)(k.at(0), k.at(1), styling: styling-options, extras: extra-options))
            )
          )
          v(24pt) // 24pt ~ 8.46mm ~ one line in 10pt font size with 0.65em leading
        }
      }))
    }
    
    (block-hooks.subject)(title, styling: styling-options, extras: extra-options)
    
    parbreak()
    linebreak()
    
    (block-hooks.salutation)(wordings: wordings, styling: styling-options, extras: extra-options)
    
    parbreak()

    show heading: it => (block-hooks.subsubject)(it.body, level: it.level, styling: styling-options, extras: extra-options)
    
    content

    // closing & attachments
    //linebreak()
    block({
      let closing-content = (block-hooks.closing)(wordings: wordings, styling: styling-options, extras: extra-options, signature: signature)
      let attachment-content = (block-hooks.attachments)(attachments, wordings: wordings, styling: styling-options, extras: extra-options)

      if styling-options.attachment-right {
        let remaining-space = calc.max(measure(attachment-content, sty).height - measure(closing-content, sty).height, 0pt)
        closing-content
        place(dx: 100mm, top, attachment-content)
        v(remaining-space, weak: true)
      } else {
        closing-content
        v(24pt, weak: true)
        attachment-content
      }
    })

    // ps
    if ps != none {
      //linebreak()
      (block-hooks.postscriptum)(ps, wordings: wordings, styling: styling-options, extras: extra-options)
    }
  })
}
