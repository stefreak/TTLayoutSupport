# TTLayoutSupport

[![CI Status](http://img.shields.io/travis/stefreak/TTLayoutSupport.svg?style=flat)](https://travis-ci.org/stefreak/TTLayoutSupport)
[![Version](https://img.shields.io/cocoapods/v/TTLayoutSupport.svg?style=flat)](http://cocoadocs.org/docsets/TTLayoutSupport)
[![License](https://img.shields.io/cocoapods/l/TTLayoutSupport.svg?style=flat)](http://cocoadocs.org/docsets/TTLayoutSupport)
[![Platform](https://img.shields.io/cocoapods/p/TTLayoutSupport.svg?style=flat)](http://cocoadocs.org/docsets/TTLayoutSupport)

A Category for UIViewController to make it possible to change the length of topLayoutGuide and bottomLayoutGuide

Useful for creating child / parent viewController relationships with translucent navigation bars, for example a `UITabBarController`-like controller that features translucent bars; [Here is an example for that](https://github.com/stefreak/TTLayoutSupport/blob/master/Example/TTLayoutSupport/TTDemoParentViewController.m).

Even respects `automaticallyAdjustsScrollViewInsets` property, just like UINavigationController does.

![Screenshot of example](https://raw.githubusercontent.com/stefreak/TTLayoutSupport/master/example.png)

## Usage

Just import `UIViewController+TTLayoutSupport.h` and you can manipulate `topLayoutGuide` and `bottomLayoutGuide`
via the `tt_topLayoutGuideLength` and `tt_bottomLayoutGuideLength` properties.

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Supports iOS7 to iOS8. Requires ARC

## Installation

TTLayoutSupport is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "TTLayoutSupport"

## Author

Steffen Neubauer, stefreak@googlemail.com

## License

TTLayoutSupport is available under the MIT license. See the LICENSE file for more info.

