# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.1] - 2020-04-20
### Changed
- Return a non-zero return code on validation failure.

## [1.1.0] - 2020-04-18
### Added
- Added Property List validation using `PropertyListSerialization`. Validator used to validate plist files may be toggled using the `-p` or `--plist-validator` switches. Valid values are `plutil` and `propertylistserialization` (default).
### Changed
- Updated Swift package to use latest tools.

## [1.0.0] - 2019-07-25
### Changed
- Updated to Swift 5.0

## [0.0.1] - 2018-11-12
### Added
- Initial release
