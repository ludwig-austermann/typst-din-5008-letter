#import "../envelope.typ": envelope

#let recipient = (
  address: [recipient name\ recipient address],
  topextra: [further information],
  return_information: [return information]
)

#let sender = (
  name: [sender name],
  address: [sender name\ sender address]
)

#envelope(sender: sender, recipient: recipient)