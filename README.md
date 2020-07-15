
# ![GiantGames](/GiantGames/Resources/Assets.xcassets/AppIcon.appiconset/Icon-20x20@3x.png) GiantGames iOS

## Installation

To run the project, clone the repo and run `pod install` from the root directory first.

## Requirements

**Minimum iOS target:** iOS 13.0

**CocoaPods** 1.9.3

## About architecture

Modular app structured with VIPER architecture. All components of each module have their own responsibility trying to reduce the load and the dependency on controllers.

## About API

Based on [IGDB](https://api-docs.igdb.com) non-commercial free video games API.

## About frameworks

**SwiftLint** used to enforce Swift style and conventions.<br/>
**Swinject** used to define the app dependencies.<br/>
**Nuke** used to download and display images on the app.<br/>
**SwiftyMocky** used to build mocks in runtime. Depends on Sourcery, which scans the source code and generates mocks.

## Changes

See the [CHANGELOG](CHANGELOG.md) for more info.

## Author

Xavier Vicient Manteca

## License

Copyright © 2020 Xavier Vicient Manteca.
