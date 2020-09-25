# MVVM Sample

Sample for MVVM architecture

Using [The Cocktail DB](https://www.thecocktaildb.com) API

## Technologies

- [x] Clean architecture ([RxSwift](https://github.com/ReactiveX/RxSwift) and MVVM)
- [x] Flow coordinators ([Realm demo](https://github.com/realm/EventKit/blob/master/iOS/EventBlank2-iOS/Services/Navigator.swift))
- [x] REST API v3 (for unauthenticated or basic authentication) ([Moya](https://github.com/Moya/Moya) and Codable)
- [x] Git Flow
- [x] Unit Test for viewModel

## Frameworks

* [Moya](https://github.com/Moya/Moya)
* [RxSwift](https://github.com/ReactiveX/RxSwift) - Included some relate frameworks, like [RxDataSources](https://github.com/RxSwiftCommunity/RxDataSources), [RxOptional](https://github.com/RxSwiftCommunity/RxOptional), [RxViewController](https://github.com/devxoul/RxViewController), etc...
* [Kingfisher](https://github.com/onevcat/Kingfisher)
* [MBProgressHUD](https://github.com/jdg/MBProgressHUD)
* [Quick](https://github.com/Quick/Quick)
* [Nimble](https://github.com/Quick/Nimble)

## Tools

- [x] [Carthage](https://github.com/Carthage/Carthage) - The simplest way to add frameworks to your Cocoa application
- [x] [Brew](https://github.com/Homebrew/brew) - The missing package manager for macOS
- [x] [Sourcetree](https://www.sourcetreeapp.com) - A free Git client for Windows and Mac
- [x] [Postman](https://www.getpostman.com) - A powerful HTTP client for testing web services ([view](https://github.com/khoren93/SwiftHub/tree/master/Postman))

## Building and Running

1. Install carthage package manager. you can found binary [here](https://github.com/Carthage/Carthage).

2. Run command `carthage bootstrap --platform iOS` at `$(SRCROOT)` directory.

3. Open `Cocktail.xcodeproj`

4. Build and run.

## Future Works

- [ ] List all ingredients with cocktail.

- [ ] Search by categories, glasses, ingredients or alcoholic filters.

- [ ] Save favorite cocktails to local DB.

## References

* [CleanArchitectureRxSwift](https://github.com/sergdort/CleanArchitectureRxSwift) - Clean architecture with RxSwift
* [View Model in RxSwift](https://medium.com/@SergDort/viewmodel-in-rxswift-world-13d39faa2cf5) - useful article
