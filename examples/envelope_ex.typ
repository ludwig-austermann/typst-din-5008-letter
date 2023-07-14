#import "../letter.typ": envelope, helpers, letter-styling
#import envelope: envelope, envelope-styling

#let address-field = helpers.address-field([recipient name\ recipient address], return-information: [return information\ further information], styling: letter-styling())

#envelope(
  envelope-format: "DL",
  sender-zone: pad(1cm)[sender name\ sender address],
  frank-zone: pad(1cm)[frank zone],
  read-zone: pad(y: 1cm, address-field),
  encoding-zone: pad(5mm)[encoding zone],
  debug: true
)