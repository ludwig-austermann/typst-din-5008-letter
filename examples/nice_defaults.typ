#import "../letter.typ" : letter, defaults
#import emoji

#let recipient = (
  address: [recipient name\ recipient address]
)

#let sender = (
  name: [my friendly name],
  address: [sender name\ sender address
  #v(6mm)
  Date: #h(1cm) some date]
)

#{
  defaults.form = "A" // can also be form 'B'
  defaults.folding_mark = true
  defaults.hole_mark = false
  defaults.salutation = [Hello my friend]
  defaults.closing = [Best Regards]
  defaults.themecolor = green.darken(40%)
  //defaults.pagemarginright = 0.7cm
  //defaults.handsigned = true
}

#show: letter.with(
  sender: sender,
  recipient: recipient,
  title: align(center)[subject of letter],
  date: [some date],
  options: defaults,
  header: [To be found at #link("https://github.com/ludwig-austermann/typst-din-5008-letter")],
  footer: [footer]
)

#for i in (3, 12, 1) {
  lorem(10*i)
  parbreak()
}
