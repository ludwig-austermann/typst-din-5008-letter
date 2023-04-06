#import "../letter.typ" : letter, defaults
#import emoji

#let recipient = (
  address: [recipient name\ recipient address],
  topextra: [further information],
  return_information: [return information]
)

#let sender = (
  name: [sender name],
  address: [sender name\ sender address]
)

#{
  defaults.form = "A" // can also be form 'B'
  defaults.folding_mark = true
  defaults.hole_mark = true
  defaults.salutation = [Some Salutation]
  defaults.closing = [Some Closing]
  //defaults.pagemarginright = 0.7cm
  //defaults.handsigned = true
}

#show: letter.with(
  sender: sender,
  recipient: recipient,
  title: [subject of letter],
  date: [some date],
  options: defaults,
  reference_signs: (
    ([Reference 1], [A2-335-F12]),
    ([Reference 2], [137 288]),
    ([Date], [some date])
  ),
  header: [header. A DIN 5008 based Typst letter template, to be found at #link("https://github.com/ludwig-austermann/typst-din-5008-letter")],
  footer: [footer]
)

#for i in (3, 12, 3, 12, 15, 35, 1) {
  lorem(10*i)
  parbreak()
}
