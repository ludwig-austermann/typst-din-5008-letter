# Changelog
## Version 0.1.0
- Added local package presets
- Changed date to automatically take todays date conform to the DIN (`YYYY-MM-DD`)
- Changed variable names / options from `....` and `.._..` to `..-..`
- Changed styling initialization via a function with default arguments
- Added debugging posibilities
- Added background, foreground styling options
- Changed blocks to hooks
- Changed Faltmarke to Falzmarke according to DIN
- Changed Briefkopf to full width according to DIN
- Changed Anschriftzone to full width according to DIN
- Added a reference / label system
  - includes default `@date` and `@name` labels
  - others can be defined in the labels argument of letter function
- Added `wordings.toml`, where formal / informal variations of various languages are added, which can then be loaded via `wordings` argument and special `load-wordings` function
- Some phrases were moved from `options` to 
- Added `block-hooks` to change the behavious of various parts
- Removed `page-number-on-first-page` field, as this should now be done with the `pagenumber` hook
- Added text-params to specify font options

Everything should be cleaner, more flexible and configurable and there are many more changes. Take a look at the new readme file!