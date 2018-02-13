# swift-collections-performance

## Table of Contents

* [Mission](#mission)
* [Idea](#idea)
* [Environment](#environment)
* [Installation](#installation)
* [Collection Types](#collection-types)
  * [Standard vs clever collection types](#standard-vs-clever-collection-types)
* [Measurement](#measurement)
* [Results](#results)
  * [Initialization time](#initialization-time)
  * [Word validation](#word-validation)
  * [Words made from given letters](#words-made-from-given-letters)
  * [Simple regex for blanks](#simple-regex-for-blanks)
  * [RAM Usage](#ram-usage)

## Mission

Answer to the question: what collection type is the best to store enormous number of data?

## Idea

![Scrabble (Photo by Camille Orgel on Unsplash)](https://github.com/netguru/swift-collections-performance/blob/master/img/background.png)


Data layer for [Scrabble dictionary application](https://itunes.apple.com/us/app/scrabbdict/id687530221?mt=8) based on my experience and performance tests.

Polish dictionary has almost 3 millions of words and should allow in reasonable time:
- validating words
- returning words possible to create with given letters
- simple regex

Comparison of:
- different arrays (incl. optimized), sets and tries
- compiler optimizations
- syntax optimizations

## Environment

* Xcode 9.2
* Swift 4.0
* iPhone 8
* iOS 11.2.5

## Installation

* Clone the repository or download ZIP.
* Install CocoaPods (if you don't have): `sudo gem install cocoapods`.
* Run `pod install` in the project's root directory.

## Collection Types

The repository presents four main types of collection:

* Arrays:
  * Standard `Array`,
  * `Array` with reserved capacity that equals a count of strings,
  * `ContiguousArray`,
  * `ContiguousArray` with reserved capacity that equals a count of strings,
  * `CleverArray` that is standard two-dimensional `Array` where arrays inside contains words with letters count that equals an index of array.
* Sets:
  * Standard `Set`,
  * `CleverSet` that is standard `Array` of standard `Set`s where sets inside contains words with letters count that equals an index of set.
* Tries:
  * Modified `Trie` from [Buckets-Swift](https://github.com/mauriciosantos/Buckets-Swift) by Mauricio Santos
* Realm database:
  * Standard `Realm` database with `List` of `StringObject`s,
  * `CleverRealm` database with multiple `List`s of `StringObject`s where each list contains words with different letters count.

### Standard vs clever collection types

<img src="https://github.com/netguru/swift-collections-performance/blob/master/img/standard-clever.png" width="500"/>

## Measurement

All results, but RAM usage, were collected via measurement unit tests. RAM usage results were collected from Xcode / Debug navigator / Memory Report during running the sample app.

## Results

### Initialization time

<img src="https://github.com/netguru/swift-collections-performance/blob/master/img/init.png" width="500"/>

A time needed to initialize an object.

#### Conclusions

* Sets are much slower than arrays, because of object uniqueness.
* `CleverSet` and `Trie` initialization time is unacceptable.
* Both `Realm` and `CleverRealm` initialization time is unnoticeably, because of Realm laziness.

### Word validation

<img src="https://github.com/netguru/swift-collections-performance/blob/master/img/search.png" width="500"/>

A time needed to validate correctness of these words one by one: _"rękodzieło", "porównywać", "rodzicielski", "się", "powierzchnia", "substancja", "jeden", "dzień", "w", "kobieta", "narzędzie", "fałszywy", "pizza", "medycyna", "niematakiegoslowa"_.

#### Conclusions

* Again, there is no big difference between the first four arrays.
* Sets and trie are the fastest.
* Non-optimized Realm database is faster than arrays, but `CleverArray` and `CleverRealm` seem to be golden mean (a time needed to initialized sets and `Trie` makes them unacceptable).

### Words made from given letters

<img src="https://github.com/netguru/swift-collections-performance/blob/master/img/letters.png" width="500"/>

A time needed to find words that can be made from given letters:

* _a, p, s, t_ for four letters test,
* _a, d, p, s, t_ for five letters test.

#### Conclusions

* There is a huge difference between 4 and 5 letters for standard `Realm` database.
* Sets, trie, `CleverArray` and `CleverRealm` are really fast in this test, so I decided to run more tests for the fastest four of them.

<img src="https://github.com/netguru/swift-collections-performance/blob/master/img/letters-2.png" width="500"/>

<sub><sup>Logarithmic scale, power trendline</sup></sub>

* _a, d, e, p, s, t_ for six letters test,
* _a, d, e, p, r, s, t_ for seven letters test,
* _a, d, e, p, r, s, t, z_ for eight letters test.

#### Conclusions

* Sets and trie growth when more letters is reasonable, but `CleverRealm` is useless for more than six letters.

### Simple regex for blanks

<img src="https://github.com/netguru/swift-collections-performance/blob/master/img/regex.png" width="500"/>

A time time needed to find words that fit these simple blank regex one by one: _"p?z?a", "???", "po??r", "pap????", "???????", "tele???"_.

In example: _**po**??**r**_ should return _**po**bó**r**, **po**de**r**, **po**ke**r**, **po**kó**r**, **po**la**r**, **po**le**r**, **po**lo**r**, **po**mó**r**, **po**no**r**, **po**nu**r**, **po**ti**r**, **po**we**r**, **po**ze**r**, **po**zó**r**, **po**ża**r**_.

#### Conclusions

* This is possible in reasonable time only for `CleverArray`, `CleverSet`, `Trie`, `Realm` and `CleverRealm`.
* `CleverRealm` is the fastest, when `Realm` is the slowest.
* `Trie` is faster than standard Swift collection types.

### RAM Usage

<img src="https://github.com/netguru/swift-collections-performance/blob/master/img/ram.png" width="500"/>

RAM usage measured by Xcode profiler on real device running example app:

* **RAM Usage** is RAM usage just after initialization.
* **Highest RAM Usage** is the highest RAM usage noticed during initialization.

#### Conclusions

* Trie and sets RAM usage is unacceptable high (it may cause crashes on older devices).
* Arrays RAM usage is high, but acceptable. Unfortunately their performance is not satisfactory.
* Realm RAM usage is close to null.
