# Pentagram

[![Version](https://img.shields.io/cocoapods/v/Pentagram.svg?style=flat)](http://cocoapods.org/pods/Pentagram)
[![License](https://img.shields.io/cocoapods/l/Pentagram.svg?style=flat)](http://cocoapods.org/pods/Pentagram)
[![Platform](https://img.shields.io/cocoapods/p/Pentagram.svg?style=flat)](http://cocoapods.org/pods/Pentagram)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

Pentagram is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Pentagram'
```

## Usage
```swift
    override func viewDidLoad() {
        super.viewDidLoad()
        let pentagram = PentagramViewController.getPentagram(lineWidth: 5, spaceBetweenLines: 24, topPosition: 200)
        
        addChildViewController(pentagram)
        view.addSubview(pentagram.view)
        pentagram.didMove(toParentViewController: self)
        
        pentagram.key = .f
        
        let note = pentagram.drawNoteForName(.do3)
    }
```
## Author

Lucas Coelho, lucas@coelho.be

## License

Pentagram is available under the MIT license. See the LICENSE file for more info.
