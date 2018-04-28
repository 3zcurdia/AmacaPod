# Amaca

[![CI Status](http://img.shields.io/travis/3zcurdia/Amaca.svg?style=flat)](https://travis-ci.org/3zcurdia/Amaca)
[![Version](https://img.shields.io/cocoapods/v/Amaca.svg?style=flat)](http://cocoapods.org/pods/Amaca)
[![License](https://img.shields.io/cocoapods/l/Amaca.svg?style=flat)](http://cocoapods.org/pods/Amaca)
[![Platform](https://img.shields.io/cocoapods/p/Amaca.svg?style=flat)](http://cocoapods.org/pods/Amaca)
[![Maintainability](https://api.codeclimate.com/v1/badges/0a0c7da98ac2f5fc09b0/maintainability)](https://codeclimate.com/github/3zcurdia/Amaca/maintainability)

## Installation

Amaca is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Amaca'
```

## Setup

Even when Amaca is based in convention over configuration principle, there are few things to setup.

### AmacaConfigurable Protocol

You must implement a structure or a class conforming the `AmacaConfigurable`  protocol where
it will be defined the base url and the session for your connections, among with the authentication structure
if needed.

```swift
public protocol ServicesConfig {
  var session: URLSession { get }
  var baseURL: URL { get }
}
```

#### Example

```swift
struct ServicesConfig: AmacaConfigurable {
    let session: URLSession = URLSession.shared
    let baseUrl: URL = URL(string: "https://example.com/api")!
}
```

## Usage

To initialize a service you must create an instance with the Codable you desire
to parse a config and the path where all the RESTFUL routes reside.


|   Method   |   URI Pattern   |   Action   |
|:-----------|:--------------- |:-----------|
| GET        |    /users       |  index     |
| POST       |    /users       |  create    |
| GET        |    /users/:id   |  show      |
| PUT        |    /users/:id   |  update    |
| DELETE     |    /users/:id   |  destroy   |

Then for each method you can call the correspondent action

### Example Unauthenticated

```swift
  let config = ServicesConfig()
  let service = CodableService<User>(config: config, path: "/users", auth: nil)

  service.index { response in
    // your code goes here
    switch response.status {
    case .success:
      print(response.data!.count)
    default:
      print(response.status)
      print(response)
    }
  }
```

### Authentication

Amaca provides authentication structs for query and header:

- QueryAuthentication
- HeaderAuthentication

### Example Authenticated


```swift
  let config = ServicesConfig()
  let auth = QueryAuthentication(method: .basicHeader, token: "secret-token-1234")
  let service = CodableService<User>(config: config, path: "users", auth: auth)

  service.index { response in
    // your code goes here
    switch response.status {
    case .success:
      print(response.data!.count)
    default:
      print(response.status)
      print(response)
    }
  }
```

**Note**: CodableService internally implements `dataTask` other methods from `URLSession`  could be supported in the future.

## Contribute to the project

To contribute, just follow the next steps:

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* It is desired to add some tests for it.
* Make a Pull Request

## License

Amaca is available under the MIT license. See the LICENSE file for more info.
