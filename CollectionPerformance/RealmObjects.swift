//
//  RealmObjects.swift
//  CollectionPerformance
//
//  Created by Piotr Sochalewski on 10.01.2018.
//  Copyright © 2018 Netguru Sp. z o.o. All rights reserved.
//

import RealmSwift

/// A simple Vocabulary object that contains list of words.
final class Vocabulary: Object {
    
    /// A list of `String`s.
    let words = List<String>()
}

/// A Vocabulary object that contains multiple lists of words.
final class CleverVocabulary: Object {
    
    // List<List<String>> is not allowed :/
    private let words2 = List<String>()
    private let words3 = List<String>()
    private let words4 = List<String>()
    private let words5 = List<String>()
    private let words6 = List<String>()
    private let words7 = List<String>()
    private let words8 = List<String>()
    private let words9 = List<String>()
    private let words10 = List<String>()
    private let words11 = List<String>()
    private let words12 = List<String>()
    private let words13 = List<String>()
    private let words14 = List<String>()
    private let words15 = List<String>()

    /// An array of list of String objects sorted from zero to fiteen letters.
    lazy private(set) var words: [List<String>] = {
        return [List<String>(), List<String>(), words2, words3, words4, words5, words6, words7, words8, words9, words10, words11, words12, words13, words14, words15]
    }()
    
    override static func ignoredProperties() -> [String] {
        return ["words"]
    }
}
