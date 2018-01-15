# collections-performance

## Mission

Answer to the question: what collection type is the best to store enormous number of data?

## Idea

Data layer for Scrabble dictionary application based on my experience and performance tests.

Polish dictionary has almost 3 millions of words and should allow in reasonable time:
- validating words
- returning words possible to create with given letters
- simple regex

Comparision of:
- different arrays (incl. optimized), sets and tries
- compiler optimizations
- syntax optimizations

## Environment

* Xcode 9.2
* Swift 4.0
* iPhone 8
* iOS 11.2.2

## Results

### Init time

<img src="https://github.com/netguru/collections-performance/blob/master/Results/init.png" width="500"/>

### Word validation

<img src="https://github.com/netguru/collections-performance/blob/master/Results/search.png" width="500"/>

### Word made from given letters

<img src="https://github.com/netguru/collections-performance/blob/master/Results/letters.png" width="500"/>

### Simple regex for blanks

<img src="https://github.com/netguru/collections-performance/blob/master/Results/regex.png" width="500"/>

### RAM Usage

<img src="https://github.com/netguru/collections-performance/blob/master/Results/ram.png" width="500"/>
