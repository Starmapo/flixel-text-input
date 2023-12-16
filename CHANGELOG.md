<!-- markdownlint-configure-file {"MD024": {"siblings_only": true}} -->
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

### Added

- `pointerEnabled` variable to `FlxTextInput`

### Removed

- `flixel.addons.text.FlxUITextInput` (deprecated class)

### Fixed

- Fixed a bug in HaxeUI where the text input wouldn't gain focus if its background was pressed
- Fixed compatibility issues with flixel 4.11.0 and lime 7.9.0

## 1.1.0 - 2023-12-07

### Added

- `flixel.addons.text.ui.FlxUINumericStepper`: A recreation of the "flixel-ui" numeric stepper that uses this library's text input
- Added "basic" and "flixel-ui" sample projects

### Changed

- Moved `FlxUITextInput` to the `flixel.addons.text.ui` package

### Fixed

- Fixed a crash when text is `null` in the `FlxTextInput` constructor
- Fixed a bug with touch input

## 1.0.0 - 2023-12-04

### Added

- Everything (initial release)
