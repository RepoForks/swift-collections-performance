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
    
    /// A list of `StringObject`s.
    let words = List<StringObject>()
}

/// A Vocabulary object that contains multiple lists of words.
final class CleverVocabulary: Object {
    
    // List<List<StringObject>> is not allowed :/
    private let words2 = List<StringObject>()
    private let words3 = List<StringObject>()
    private let words4 = List<StringObject>()
    private let words5 = List<StringObject>()
    private let words6 = List<StringObject>()
    private let words7 = List<StringObject>()
    private let words8 = List<StringObject>()
    private let words9 = List<StringObject>()
    private let words10 = List<StringObject>()
    private let words11 = List<StringObject>()
    private let words12 = List<StringObject>()
    private let words13 = List<StringObject>()
    private let words14 = List<StringObject>()
    private let words15 = List<StringObject>()

    /// An array of list of String objects sorted from zero to fiteen letters.
    lazy private(set) var words: [List<StringObject>] = {
        return [List<StringObject>(), List<StringObject>(), words2, words3, words4, words5, words6, words7, words8, words9, words10, words11, words12, words13, words14, words15]
    }()
    
    override static func ignoredProperties() -> [String] {
        return ["words"]
    }
}

/// A String object.
final class StringObject: Object {
    
    /// A String value.
    @objc dynamic var value = ""
    
    override static func indexedProperties() -> [String] {
        return ["value"]
    }
    
    override static func primaryKey() -> String? {
        return "value"
    }
}
