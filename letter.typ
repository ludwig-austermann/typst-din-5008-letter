#let defaults = (
  themecolor: navy,
  greeting: "Sehr geehrte Damen und Herren",
  goodbye: "Mit freundlichen Grüßen",
  pagemarginright: 1.69cm,
  falzmarke: true,
  lochmarke: true,
  form: "A",
  handsigned: false
)

// see https://ftp.rrze.uni-erlangen.de/ctan/macros/latex/contrib/koma-script/doc/scrguide-de.pdf

#let dateheader(date) = align(right, text(date, size: 9pt))

#let addressheader(person) = [_#{person.name}_\
  #{person.address}\
  #if person.keys().contains("extra") {
    person.extra
  }
]

#let empfheader(person) = block(width: 85mm, height: 27.3mm, {
  if person.keys().contains("ruecksendeangabe") {
    place(dy: -17.7mm, text(8pt, underline(person.ruecksendeangabe, offset: 1.5pt)))
  }
  pad(x: 5mm, {// toaddrindent
  if person.keys().contains("topextra") {
    let topextra = text(8pt, person.topextra)
    style(styles => {
      let h = measure(topextra, styles).height
      place(dy: -calc.min(9.7mm, h) - 3mm, topextra)
    })
  }
  text(person.address)
  })
})

#let infoheader(person) = block(width: 75mm, {
  text(person.address)
})

#let betreffheader(content) = {
  //set align(center)
  set text(navy)
  strong(content)
  linebreak()
  linebreak()
}

#let bezugszeichenblock(heading, content) = {
  text(size: 8pt, heading)
  linebreak()
  text(size: 10pt, content)
}

#let greetingblock(content: defaults.greeting) = {
  text(content + ",")
  linebreak()
}

#let goodbyeblock(name, content: defaults.goodbye, handsigned: false) = {
  linebreak()
  text(content)
  linebreak()
  if handsigned { linebreak(); linebreak() }
  [#name]
}

// look at: https://www.deutschepost.de/de/b/briefvorlagen/normbrief-din-5008-vorlage.html
// look at: https://de.wikipedia.org/wiki/DIN_5008

#let letter(
  content, abs: (:), empf: (:), date: "", title: none,
  options: defaults,
  bezugszeichen: (),
  header: [], footer: []
) = {
  let topmargin = if options.form == "A" { 27mm } else { 45mm }
  let infotopmargin = topmargin + 5mm
  let empftopmargin = infotopmargin + 12.7mm
  let faltmarke1 = topmargin + 60mm
  let faltmarke2 = faltmarke1 + 105mm
  let lochmarke = 148.5mm
  let footercontent = locate(loc => {
    set align(horizon + right)
    set text(8pt)
    text(options.themecolor)[#loc.page()]
    text(gray.darken(50%), " / " + str(counter(page).final(loc).at(0)))
    if loc.page() == 1 {
      v(4.23mm, weak: true)
      set align(left)
      style(styles => {
        let footerheight = measure(footer, styles).height
        footer
        v(footerheight)
      })
    }
  })
  set page(
    margin: (
      left: 25mm,
      top: topmargin,
      right: options.pagemarginright,
      bottom: 20mm,
    ),
    header: locate(loc => if loc.page() > 1 {
      set text(8pt, options.themecolor)
      set align(horizon)
      title
      h(1fr)
      date
    }),
    footer: footercontent,
    background: locate(loc => {
      if options.falzmarke {
        place(left + top, dy: faltmarke1, line(stroke: gray, length: 5mm))
        place(left + top, dy: faltmarke2, line(stroke: gray, length: 5mm))
      }
      if options.lochmarke { place(left + top, dy: lochmarke, line(stroke: gray, length: 7mm)) }
    })
  )
  style(styles => move(dy: -topmargin, { // reverse margin
    place(dy: 8mm, block(width: 100mm, header))
    let _emph = empfheader(empf);
    let _info = infoheader(abs);
    place(top + left, dx: -5mm, dy: empftopmargin, _emph)
    place(dx: 100mm, dy: infotopmargin, _info)

    let infoheight = calc.max(40mm, measure(_info, styles).height)
    v(infoheight + 8.46mm)
    if bezugszeichen.len() > 0 {
      move(dy: infotopmargin,
        grid(
          columns: (50mm, 50mm, 50mm, auto),
          row-gutter: 8.46mm / 2,
          ..bezugszeichen.map(k => bezugszeichenblock(k.at(0), k.at(1)))
        )
      )
      v(8.46mm)
    }
  }))
  
  betreffheader(title)
  greetingblock(content: options.greeting)
  set par(justify: true)
  content
  goodbyeblock(abs.name, content: options.goodbye, handsigned: options.handsigned)
}
