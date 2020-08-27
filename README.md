# MVVM_Sample

Sample for MVVM architecture

Using [The Cocktail DB](https://www.thecocktaildb.com) API

## Technologies

- [x] Clean architecture ([RxSwift](https://github.com/ReactiveX/RxSwift) and MVVM)
- [x] Flow coordinators ([Realm demo](https://github.com/realm/EventKit/blob/master/iOS/EventBlank2-iOS/Services/Navigator.swift))
- [x] REST API v3 (for unauthenticated or basic authentication) ([Moya](https://github.com/Moya/Moya), and Codable)

## Tools

- [x] [Brew](https://github.com/Homebrew/brew) - The missing package manager for macOS
- [x] [Sourcetree](https://www.sourcetreeapp.com) - A free Git client for Windows and Mac
- [x] [Postman](https://www.getpostman.com) - A powerful HTTP client for testing web services ([view](https://github.com/khoren93/SwiftHub/tree/master/Postman))

## Building and Running

1. install carthage package manager. you can found binary [here](https://github.com/Carthage/Carthage).

2. run command `carthage bootstrap --platform iOS` at `$(SRCROOT)` directory.

3. open `Cocktail.xcodeproj`

4. build and run.

## Future work

- [ ] List all ingredients with cocktail.

- [ ] Search by categories, glasses, ingredients or alcoholic filters.

- [ ] Save favorite cocktails to local DB.
