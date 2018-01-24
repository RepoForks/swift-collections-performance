//
//  CleverValidators.swift
//  CollectionPerformance
//
//  Created by Piotr Sochalewski on 08.01.2018.
//  Copyright © 2018 Netguru Sp. z o.o. All rights reserved.
//

import Foundation

/// A protocol that allows validating words, returning words that can be made from given letters and simple regex queries.
protocol CleverValidator: Validator {
    /**
     Returns an array of words that fit the given regex query.
     
     An example of correct query:
     
         regex(phrase: "pr??lem") // ["preclem", "problem"]
     
     - parameter phrase: The simple regex query. Only letters and blanks (`?`) are allowed.
     */
    func regex(phrase: String) -> [String]?
}

/// Word validator based on two-dimensional array of strings.
final class CleverArrayWordValidator: CleverValidator {
    
    /// An two-dimensional array of strings.
    ///
    /// Arrays in the array contains words with letters count that equals an index of array.
    private var words = [[String]]()
    
    init() {
        words = (0...15).map { _ in [String]() }
        
        let string = try! String(contentsOf: fileURL, encoding: .utf8)
        let allWords = string.components(separatedBy: .newlines)
        allWords.forEach { word in
            words[word.count].append(word)
        }
    }
    
    func validate(word: String) -> Bool {
        guard words.count > word.count else { return false }
        return words[word.count].contains(word.lowercased())
    }
    
    func words(from letters: String) -> [String]? {
        return letters.lowercased()
            .map { String($0) }
            .permute()
            .filter { permute in words[permute.count].contains(permute) }
    }
    
    func regex(phrase: String) -> [String]? {
        guard words.count > phrase.count else { return nil }
        
        return words[phrase.count].filter { word in
            return zip(phrase, word)
                .map { $0 == "?" ? true : $0 == $1 }
                .reduce(true) { $0 && $1 }
        }
    }
}

/// Word validator based on array of set of strings.
final class CleverSetWordValidator: CleverValidator {
    
    /// A array of set of strings.
    ///
    /// Sets in the array contains words with letters count that equals an index of set.
    private var words = [Set<String>]()
    
    init() {
        words = (0...15).map { _ in Set<String>() }

        let string = try! String(contentsOf: fileURL, encoding: .utf8)
        let allWords = string.components(separatedBy: .newlines)
        allWords.forEach { word in
            words[word.count].insert(word)
        }
    }
    
    func validate(word: String) -> Bool {
        guard words.count > word.count else { return false }
        return words[word.count].contains(word.lowercased())
    }
    
    func words(from letters: String) -> [String]? {
        return letters.lowercased()
            .map { String($0) }
            .permute()
            .filter { permute in words[permute.count].contains(permute) }
    }
    
    func regex(phrase: String) -> [String]? {
        guard words.count > phrase.count else { return nil }
        
        return words[phrase.count].filter { word in
            return zip(phrase, word)
                .map { $0 == "?" ? true : $0 == $1 }
                .reduce(true) { $0 && $1 }
        }
    }
}

/// Word validator based on trie.
final class TrieWordValidator: CleverValidator {
    
    /// A trie of strings.
    private let words: Trie
    
    init() {
        let string = try! String(contentsOf: fileURL, encoding: .utf8)
        words = Trie(string.components(separatedBy: .newlines))
    }
    
    func validate(word: String) -> Bool {
        return words.contains(word.lowercased())
    }
    
    func words(from letters: String) -> [String]? {
        let permutes = letters.lowercased()
            .map { String($0) }
            .permute()
        
        return permutes
            .filter { words.contains($0) }
    }
    
    func regex(phrase: String) -> [String]? {
        return words.findPattern(phrase.lowercased())
    }
}
