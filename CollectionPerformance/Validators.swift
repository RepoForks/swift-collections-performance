//
//  Validators.swift
//  CollectionPerformance
//
//  Created by Piotr Sochalewski on 03.01.2018.
//  Copyright © 2018 Netguru Sp. z o.o. All rights reserved.
//

import Foundation

/// An URL to raw text file Polish dictionary.
let fileURL = Bundle.main.url(forResource: "pl_PL", withExtension: "txt")!

/// A protocol that allows validating words and returning words that can be made from given letters.
protocol Validator: class {
    init()
    /// Returns a Boolean value indicating whether the Polish dictionary contains the given word.
    /// - parameter word: The word to validate.
    func validate(word: String) -> Bool
    /// Returns an array of words that can be made from the given letters.
    /// - parameter letters: The letters
    func words(from letters: String) -> [String]?
}

/// Simple word validator based on array of strings.
final class ArrayWordValidator: Validator {
    
    /// An array of strings.
    private let words: [String]
    
    init() {
        let string = try! String(contentsOf: fileURL, encoding: .utf8)
        words = string.components(separatedBy: .newlines)
    }
    
    func validate(word: String) -> Bool {
        return words.contains(word.lowercased())
    }
    
    func words(from letters: String) -> [String]? {
        return letters.lowercased()
            .map { String($0) }
            .permute()
            .filter { words.contains($0) }
    }
}

/// Simple word validator based on capacity array of strings.
final class CapacityArrayWordValidator: Validator {
    
    /// An capacity array of strings.
    private var words = [String]()
    
    init() {
        let string = try! String(contentsOf: fileURL, encoding: .utf8)
        let separated = string.components(separatedBy: .newlines)
        words.reserveCapacity(separated.count)
        words = separated
    }
    
    func validate(word: String) -> Bool {
        return words.contains(word.lowercased())
    }
    
    func words(from letters: String) -> [String]? {
        return letters.lowercased()
            .map { String($0) }
            .permute()
            .filter { words.contains($0) }
    }
}

/// Simple word validator based on contiguous array of strings.
final class ContiguousArrayWordValidator: Validator {
    
    /// An contiguous array of strings.
    private let words: ContiguousArray<String>
    
    init() {
        let string = try! String(contentsOf: fileURL, encoding: .utf8)
        words = ContiguousArray(string.components(separatedBy: .newlines))
    }
    
    func validate(word: String) -> Bool {
        return words.contains(word.lowercased())
    }
    
    func words(from letters: String) -> [String]? {
        return letters.lowercased()
            .map { String($0) }
            .permute()
            .filter { words.contains($0) }
    }
}

/// Simple word validator based on capacity contiguous array of strings.
final class CapacityContiguousArrayWordValidator: Validator {
    
    /// An capacity contiguous array of strings.
    private var words = ContiguousArray<String>()

    init() {
        let string = try! String(contentsOf: fileURL, encoding: .utf8)
        let separated = string.components(separatedBy: .newlines)
        words.reserveCapacity(separated.count)
        words.append(contentsOf: separated)
    }
    
    func validate(word: String) -> Bool {
        return words.contains(word.lowercased())
    }
    
    func words(from letters: String) -> [String]? {
        return letters.lowercased()
            .map { String($0) }
            .permute()
            .filter { words.contains($0) }
    }
}

/// Simple word validator based on set of strings.
final class SetWordValidator: Validator {
    
    /// A set of strings.
    private let words: Set<String>
    
    init() {
        let string = try! String(contentsOf: fileURL, encoding: .utf8)
        words = Set(string.components(separatedBy: .newlines))
    }
    
    func validate(word: String) -> Bool {
        return words.contains(word.lowercased())
    }
    
    func words(from letters: String) -> [String]? {
        return letters.lowercased()
            .map { String($0) }
            .permute()
            .filter { words.contains($0) }
    }
}
