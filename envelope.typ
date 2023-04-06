#let addressheader(person) = [
  #person.address
]

#let envelope(sender: (:), recipient: (:), etype: "DL") = {
  set page(
    height: if etype == "DL" { 110mm } else { 114mm },
    width: if etype == "DL" { 220mm } else { 229mm }
  )
  addressheader(sender)
  //v(30%)
  //h(60%)
  place(top + left, dx: 45%, dy: 45%, addressheader(recipient))
  
}