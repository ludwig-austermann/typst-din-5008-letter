# Reference
## Letter options
| Option | Type | Deutsch | English |
|---|---|---|---|
| `title` | `content` | Betreff | Subject of letter |
| `address-zone` | `content` | Empfängeradresse /-zone | recipient address /-zone |
| `return-information` | `content` | Rücksendehinweis | return information |
| `information-field` | `content` | Informationsblock | information block |
| `reference-signs` | `array of content pairs` | Bezugszeichen | reference signs |
| `attachments` | `array of content` | Anhänge | attachments |
| `ps` | `content` | PS | PS |
| `signature` | `content` | Bild von Unterschrift | picture of signature |
| `name` | `str` | eigener Name | own name |
| `date` | `content` | Datum | Date |
| `wordings` | `dict` / `str` / `auto` | Phrasen, siehe unten | phrases, see below |
| `styling-options` | `dict` | Styling, siehe unten | Styling, see below |
| `debug-options` | `dict` | Debug Optionen, siehe unten | debug options, see below |
| `block-hooks` | `dict` | siehe unten | see below |
| `labels` | `dict` | siehe unten | see below |
| `extra-options` | `dict` | extra Argumente für eigene hooks | extra arguments for custom hooks |

## Labels
Labels can be defined with the `labels` args of the main `letter` function. Additionally, `name` and `date` are predefined. Hence, one can use `@name` in the text and _blocks_.

## Subsubjects
You can use subsubjects (Teilbetreff) and subsubsubjects and so on with the typst heading function `= subsubject`, `== subsubsubject`.

## Styling options
| Option | Type | Deutsch | English |
|---|---|---|---|
| `theme-color` | `color` | Themenfarbe | theme color |
| `text-params` | `dict` | Schriftartsoptionen | Font options |
| `page-margin-right` | dim | Rechter Rand | right margin |
| `folding-mark` | `bool` | Falzmarken? | folding marks? |
| `hole-mark` | `bool` | Lochmarke? | hole mark? |
| `form` | `str` | Typ A / B | type A / B |
| `handsigned` | `bool` | Unterschrift? | Signed? |
| `attachment-right` | `bool` | Anhang rechts? | attachment set right? |
| `background` | `content` | Hintergrundinhalt | background content |
| `foreground` | `content` | Vordergrundinhalt | foreground content |
| `head-par-leading` | `length` | Zeilenabstand Briefkopf | linespacing letter head |
| `address-field-seperator-spacing` | `length` | Abstand zwischen Rücksendezone und Adresszone | distance between return address and address zone |
| `pagenumber-content-spacing` | `length` | Abstand zwischen Seitenzahl und Briefinhalt | distance between pagenumber and letter content |
| `pagenumber-footer-spacing` | `length` | Abstand zwischen Seitenzahl und Fußblock | distance between pagenumber and footer |
| `pagenumber-footer-spacing` | `length` | Abstand vom Fußblock zum unterem Rand | distance of footer to bottom page border |

In examples directory is `template_letter.*` which maps all fields of this class to a pdf.

## Wording / Phrasing options
There are two possibilities to access wordings:
- using the `load-wordings(lang, wordings-file: "wordings.toml")` function, where you specify the wordings entry by `lang`, for instance `de-formal`, and the corresponding file
- giving the `wordings` argument in `letter` function with
  - `auto`, then `<lang>-formal` is taken with `load-wordings`
  - `x: str`, then `x` is taken with `load-wordings`
  - `x: dict`, then `x` is taken directly

In the `wordings.toml` file, the following fields are defined.

| Option | Type | Deutsch | English |
|---|---|---|---|
| `salutation` | `str` | Grußformel / Anrede | greeting |
| `closing` | `str` | Grußformel am Ende | closing |
| `attachments` | `str` | Anhang | attachment |

## Hooks
Hooks enable you to change the behaviour of various blocks in the letter. Such, many parts of this letter class can be modified to one likings. We denote with `Ö`, that the function has also the arguments `styling: (:), extras: (:)`, and by `Ä`, if we have additionally `wordings: (:)`.

| Option | Type | Deutsch | English |
|---|---|---|---|
| `subject` | `(content: content, Ö) -> content` | Betreff | Subject |
| `subsubject` | `(content: content, level: int, Ö) -> content` | Teilbetreff | Subsubject |
| `reference-sign` | `(heading: content, content: content, Ö) -> content` | Bezugszeichen | Reference signs |
| `salutation` | `(Ä) -> content` | Grußformel | Greeting |
| `closing` | `(signature: content / none, Ä) -> content` | Grußformel am Ende | Closing |
| `pagenumber` | `(Ä) -> content` | Seitenzahl | Pagenumber |
| `letter-head` | `content` | Kopfzeile des Briefkopfes | Header of letter head |
| `attachments` | `(items: array of content, Ä) -> content` | Anhänge | Attachments |
| `postscriptum` | `(content: content, Ä) -> content` | PS | PS |
| `header` | `(title: content, Ä) -> content` | Kopfzeile | Header |
| `footer` | `content` | Fußzeile | Footer |

## Debug options
| Option | Type | Deutsch | English |
|---|---|---|---|
| `show-block-frames` | `bool` | Makiert Blöcke | marks blocks |
| `show-address-field-calculation` | `bool` | Zeigt Adressfeldberechnungen | shows address field calculation |

# Envelope
There are various envelope formats: C6, DL, C6/C5, C5A, C5B, C4A, C4B.
The mechanism of the envelope class is similar to the letter one, but a lot simpler. The envelope function can be accessed in `lib/envelope` or in `letter` by the `envelope` variable. Take a look at the example.

## Envelope options
| Option | Type | Deutsch | English |
|---|---|---|---|
| `envelope-format` | `string` | Format des Briefumschlag | Format of the envelope |
| `sender-zone` | `content` | Absenderzone | sender zone |
| `frank-zone` | `content` | Frankierzone | frank zone |
| `read-zone` | `content` | Lesezone | read zone |
| `encoding-zone` | `content` | Codierzone | (en?)coding zone |
| `styling-options` | `dict` | Styling, siehe unten | Styling, see below |
| `debug` | `bool` | Debugmodus | debug mode |

## Styling options
| Option | Type | Deutsch | English |
|---|---|---|---|
| `theme-color` | `color` | Themenfarbe | theme color |
| `text-params` | `dict` | Schriftartsoptionen | Font options |
| `margin` | `length` | Randabstand | margin |
| `background` | `content` | Hintergrundinhalt | background content |
| `foreground` | `content` | Vordergrundinhalt | foreground content |