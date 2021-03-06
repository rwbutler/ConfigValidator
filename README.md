
![Config Validator](https://raw.githubusercontent.com/rwbutler/ConfigValidator/master/docs/images/config-validator-banner.png)

[![CI Status](http://img.shields.io/travis/rwbutler/ConfigValidator.svg?style=flat)](https://travis-ci.org/rwbutler/ConfigValidator)
[![License](https://img.shields.io/cocoapods/l/TypographyKit.svg?style=flat)](http://cocoapods.org/pods/)
![Platform](https://img.shields.io/badge/platform-macOS-lightgrey.svg)
[![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat)](https://swift.org/)
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)

Config Validator validates & uploads your configuration files and clears CDN cache as part of your CI process.

For more information on Config Validator, take a look at the [keynote presentation](https://github.com/rwbutler/ConfigValidator/blob/master/docs/presentations/config-validator.pdf).

## Features

- [x] Validates JSON or Property List (.plist) files.
- [x] Uploads only valid files modified in latest Git commit to Amazon S3 (AWS).
- [x] Sets uploaded files public readable.
- [x] Invalidates CloudFront cache for uploaded files.
- [x] Supports integration with Slack.
- [x] Written in Swift.

## Installation

### Homebrew

To install using [Homebrew](https://brew.sh), run the following command:

```
brew install rwbutler/tools/config-validator
```

### Mint

To install using [Mint](https://github.com/yonaskolb/Mint) run the following command:

```bash
mint install rwbutler/configvalidator 
```

### Swift Package Manager

To build using Swift Package Manager, run the following command:

```
swift build -c release --disable-sandbox
```

## Usage

In order to view options, execute `config-validator` with no arguments:

```
--cloudfront-distribution-id: Set to invalidate CloudFront distribution with the specified identifier.

--force-upload: Uploads all validated files even where not modified in the latest commit.

--files: Specifies files to be validated.

--plist-validator: (-p) Specifies the Property List validator to use.

--silent: (-s) Prevents output being emitted.

--slack-url: Set to output to a Slack hook URL.

--upload-method: Specifies the method of upload.

--upload-urls: Specifies URLs to upload validated files to. Must contain same number of URLs as number of files to validate.

--verbose: (-v) Emits verbose output.
```

## Author

[Ross Butler](https://github.com/rwbutler)

## License

Config Validator is available under the MIT license. See the [LICENSE file](./LICENSE) for more info.

## Additional Software

### Controls

* [AnimatedGradientView](https://github.com/rwbutler/AnimatedGradientView) - Powerful gradient animations made simple for iOS.

|[AnimatedGradientView](https://github.com/rwbutler/AnimatedGradientView) |
|:-------------------------:|
|[![AnimatedGradientView](https://raw.githubusercontent.com/rwbutler/AnimatedGradientView/master/docs/images/animated-gradient-view-logo.png)](https://github.com/rwbutler/AnimatedGradientView) 

### Frameworks

* [Cheats](https://github.com/rwbutler/Cheats) - Retro cheat codes for modern iOS apps.
* [Connectivity](https://github.com/rwbutler/Connectivity) - Improves on Reachability for determining Internet connectivity in your iOS application.
* [FeatureFlags](https://github.com/rwbutler/FeatureFlags) - Allows developers to configure feature flags, run multiple A/B or MVT tests using a bundled / remotely-hosted JSON configuration file.
* [Hash](https://github.com/rwbutler/Hash) - Lightweight means of generating message digests and HMACs using popular hash functions including MD5, SHA-1, SHA-256.
* [Skylark](https://github.com/rwbutler/Skylark) - Fully Swift BDD testing framework for writing Cucumber scenarios using Gherkin syntax.
* [TailorSwift](https://github.com/rwbutler/TailorSwift) - A collection of useful Swift Core Library / Foundation framework extensions.
* [TypographyKit](https://github.com/rwbutler/TypographyKit) - Consistent & accessible visual styling on iOS with Dynamic Type support.
* [Updates](https://github.com/rwbutler/Updates) - Automatically detects app updates and gently prompts users to update.

|[Cheats](https://github.com/rwbutler/Cheats) |[Connectivity](https://github.com/rwbutler/Connectivity) | [FeatureFlags](https://github.com/rwbutler/FeatureFlags) | [Skylark](https://github.com/rwbutler/Skylark) | [TypographyKit](https://github.com/rwbutler/TypographyKit) | [Updates](https://github.com/rwbutler/Updates) |
|:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:|
|[![Cheats](https://raw.githubusercontent.com/rwbutler/Cheats/master/docs/images/cheats-logo.png)](https://github.com/rwbutler/Cheats) |[![Connectivity](https://github.com/rwbutler/Connectivity/raw/master/ConnectivityLogo.png)](https://github.com/rwbutler/Connectivity) | [![FeatureFlags](https://raw.githubusercontent.com/rwbutler/FeatureFlags/master/docs/images/feature-flags-logo.png)](https://github.com/rwbutler/FeatureFlags) | [![Skylark](https://github.com/rwbutler/Skylark/raw/master/SkylarkLogo.png)](https://github.com/rwbutler/Skylark) | [![TypographyKit](https://raw.githubusercontent.com/rwbutler/TypographyKit/master/docs/images/typography-kit-logo.png)](https://github.com/rwbutler/TypographyKit) | [![Updates](https://raw.githubusercontent.com/rwbutler/Updates/master/docs/images/updates-logo.png)](https://github.com/rwbutler/Updates)

### Tools

* [Clear DerivedData](https://github.com/rwbutler/ClearDerivedData) - Utility to quickly clear your DerivedData directory simply by typing `cdd` from the Terminal.
* [Config Validator](https://github.com/rwbutler/ConfigValidator) - Config Validator validates & uploads your configuration files and cache clears your CDN as part of your CI process.
* [IPA Uploader](https://github.com/rwbutler/IPAUploader) - Uploads your apps to TestFlight & App Store.
* [Palette](https://github.com/rwbutler/TypographyKitPalette) - Makes your [TypographyKit](https://github.com/rwbutler/TypographyKit) color palette available in Xcode Interface Builder.

|[Config Validator](https://github.com/rwbutler/ConfigValidator) | [IPA Uploader](https://github.com/rwbutler/IPAUploader) | [Palette](https://github.com/rwbutler/TypographyKitPalette)|
|:-------------------------:|:-------------------------:|:-------------------------:|
|[![Config Validator](https://raw.githubusercontent.com/rwbutler/ConfigValidator/master/docs/images/config-validator-logo.png)](https://github.com/rwbutler/ConfigValidator) | [![IPA Uploader](https://raw.githubusercontent.com/rwbutler/IPAUploader/master/docs/images/ipa-uploader-logo.png)](https://github.com/rwbutler/IPAUploader) | [![Palette](https://raw.githubusercontent.com/rwbutler/TypographyKitPalette/master/docs/images/typography-kit-palette-logo.png)](https://github.com/rwbutler/TypographyKitPalette)
