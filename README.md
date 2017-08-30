# Codelikeagirl iOS workshop
## Introduction

In this workshop you will learn many things that are key to iOS Development and
by the end of today, you will know about:

- [Swift](https://developer.apple.com/swift/)  
- [UIViews](https://developer.apple.com/documentation/uikit/uiview) and [UIViewControllers](https://developer.apple.com/documentation/uikit/uiviewcontroller)
- [Core Data](https://developer.apple.com/documentation/coredata)
- Network calls to a third-party API

## Setup

In terminal, navigate to a folder where you want to save your project. Then
`git clone https://github.com/lgrimes/CLG-iosIntro`

### Cocoapods

Today we will be installing Cocoapods, which is a dependency management system for iOS.
Cocoapods allows for very fast development because you wont have to re-invent the wheel.
Need an imageView that is round instead of square? There is probably a library for that.

If you would like to see what libraries are available, you can check the [Cocoapods Spec Repo](https://github.com/CocoaPods/Specs).

[Getting Started with Cocoapods](https://guides.cocoapods.org/using/getting-started.html)

1. Open up terminal and install cocoapods: `sudo gem install cocoapods --verbose`. You can omit the `--verbose`
flag if you don't care about seeing any output.
2. Navigate the root of the cloned repository and run `pod repo update` then `pod install`.
3. Open the file ending in `.xcworkspace`, you may be prompted to install additional
components for Xcode and this may take a few minutes

## The Basics

### UICollectionViewController

The first and main screen we will be creating in the app will use a [UICollectionViewController](https://developer.apple.com/documentation/uikit/uicollectionviewcontroller).
The main difference between a [UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview)
and a UITableView is the [layout](https://developer.apple.com/documentation/uikit/uicollectionview/1618047-collectionviewlayout). Collections are displayed in a 'flow' layout, meaning
they will be populated from left to right, and then flow onto the next row and so
on. This makes them perfect for showing images in a grid-like display. TableViews
are only for vertical display. Each controller will automatically have a child of
the specified class. These controller classes are mainly there for convenience
and will already conform to the necessary protocols.

A UICollectionView will be responsible for the display of all of its cells
which will be of the type [UICollectionViewCell](https://developer.apple.com/documentation/uikit/uicollectionviewcell).
Most likely, you will need to create a custom class that inherits from UICollectionViewCell
if you can't display what you need to with the default layout.

There are a few methods you need to implement in order to get the collection view
working as expected. You will need to specify what data you want to load into the
collectionView that will then get loaded in the cells, this is done by conforming
to the [UICollectionViewDataSource](https://developer.apple.com/documentation/uikit/uicollectionviewdatasource)
protocol.

`collectionView(_:numberOfItemsInSection:)` will specify how many cells you will
be displaying in that section. Usually this will either be the total count of
some data collection (Array, List etc) or a sub-set of that.

`collectionView(_:cellForItemAt:)` is where you can start populating your custom/
default cell with all the data and customizing it as needed. Usually you will go
and fetch the object in the data source that corresponds to the index passed in
by the parameters.

### Storyboards & .xib (Nib)

The easiest and most precise way to create a view in iOS is using storyboard or .xib,
 storyboards are preferred. You will be editing the storyboard and xib files using
 [Interface Builder](https://developer.apple.com/xcode/interface-builder/). It
 is fairly complex and can take quite some time to figure out what is where and how
  everything fits together. We will discuss this in more detail together.

### Network calls

Most developers will use a third-party library to do their network calls, the most
popular one is [Alamofire](https://github.com/Alamofire/Alamofire).For this workshop, we will be using [NSURLSession](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/URLLoadingSystem/Articles/UsingNSURLSession.html) as its good to start with the basics.
 [Ray Wenderlichs Tutorial](https://www.raywenderlich.com/158106/urlsession-tutorial-getting-started)
 describes this in a lot more detail but will also give you the basics needed.
 NSURLSession is a very powerful API where you can also create a downloader, not
 just calls to REST apis.

## Todays Objective

 Today we will be using the [Zomato API](https://developers.zomato.com/api) we will
 be populating our collection view with one of their curated lists of restaurants
 in melbourne. These restaurants will be displayed on the main page with a small image, the
 restaurant name and its rating.

 When the user taps this image, they will be taken to a more detailed page with
 all the other information they may need such as address. This is the page you will
 be making.

 It should include:

 - The featured image of the restaurant
 - The address of the restaurant
 - The rating of the restaurant
 - A button that when tapped, takes the user to the menu at the specified URL.
 [API documentation](https://developer.apple.com/documentation/uikit/uiapplication/1648685-open)
 
 ### Advanced work
 - *Advanced* Add a way for a user to add a rewview to that restaurant. For this one, you 
 will need to look into [Core Data](https://developer.apple.com/documentation/coredata) if you want
 the review to be there when you next open the app too!

### Challenges

- *Challenge 1:* Its a bit hard to see where the restaurant is without a map isn't it?
Add in a [MapView](https://developer.apple.com/maps/) so the user can see it on a map!
- *Challenge 2:* For mobile apps, we should be limiting the amount of network calls we make.
Requesting data and then loading it into our app can slow it down, and consume users
data allowance. Perhaps an in-app database would be good so we could persist that data.
Setup the app to use [Core Data](https://developer.apple.com/documentation/coredata) and create
a 'Restaurant' core data model based on the data we pull from Zomato


## Helpful Links

- [Ray Wenderlich tutorials](https://www.raywenderlich.com/): Offer some of the best
iOS/Mac development and games tutorials out there. Very in-depth with easy to
follow instructions.
- [StackOverflow](https://stackoverflow.com/): For the non-developers, this every developers best friend and
secret. If you don't know the answer or how to do something, look on here.
- [Getting Started: Develop an iOS App in Swift](https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/index.html#//apple_ref/doc/uid/TP40015214-CH2-SW1): This tutorial created by apple is what this workshop is based around. If you
didn't get a chance to finish something, or need to revise, this tutorial will
cover most of it.
