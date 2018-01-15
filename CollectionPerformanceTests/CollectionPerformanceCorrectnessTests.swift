//
//  CollectionPerformanceCorrectnessTests.swift
//  CollectionPerformanceTests
//
//  Created by Piotr Sochalewski on 15.01.2018.
//  Copyright © 2018 Netguru Sp. z o.o. All rights reserved.
//

import XCTest
@testable import CollectionPerformance

final class CollectionPerformanceCorrectnessTests: XCTestCase {
    
    private var sut: Validator!
    
    private let correctWord = "komiks"
    private let incorrectWord = "chohlik"
    
    private let letters = "ikkmo"
    private let wordsFromPhrase = ["im", "ki", "ko", "mi", "ok", "om", "kim", "kio", "koi", "kok", "kom", "mik", "moi", "kimo", "kiom", "koki", "komi", "miko", "mokk", "komik", "mokki"]
    
    private let regexPhrase = "p?k?s"
    private let regexResults = ["pikas", "pokos", "pokus"]
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testArrayWordValidator() {
        sut = ArrayWordValidator()
        test(validator: sut)
    }
    
    func testCapacityArrayWordValidator() {
        sut = CapacityArrayWordValidator()
        test(validator: sut)
    }
    
    func testContiguousArrayWordValidator() {
        sut = ContiguousArrayWordValidator()
        test(validator: sut)
    }
    
    func testCapacityContiguousArrayWordValidator() {
        sut = CapacityContiguousArrayWordValidator()
        test(validator: sut)
    }
    
    func testSetWordValidator() {
        sut = SetWordValidator()
        test(validator: sut)
    }
    
    func testCleverArrayWordValidator() {
        sut = CleverArrayWordValidator()
        test(validator: sut)
    }
    
    func testCleverSetWordValidator() {
        sut = CleverSetWordValidator()
        test(validator: sut)
    }
    
    func testTrieWordValidator() {
        sut = TrieWordValidator()
        test(validator: sut)
    }
    
    func testRealmWordValidator() {
        sut = RealmWordValidator()
        test(validator: sut)
    }
    
    func testSmartRealmWordValidator() {
        sut = SmartRealmWordValidator()
        test(validator: sut)
    }
    
    private func test(validator: Validator) {
        validate(validator: sut)
        letters(validator: sut)
        
        guard let validator = validator as? CleverValidator else { return }
        regex(validator: validator)
    }
    
    private func validate(validator: Validator) {
        XCTAssertTrue(validator.validate(word: correctWord))
        XCTAssertFalse(validator.validate(word: incorrectWord))
    }
    
    private func letters(validator: Validator) {
        let words = validator.words(from: letters)
        XCTAssert(words!.count == wordsFromPhrase.count)
        wordsFromPhrase.forEach {
            XCTAssert(words!.contains($0))
        }
    }
    
    private func regex(validator: CleverValidator) {
        let results = validator.regex(phrase: regexPhrase)
        XCTAssert(results!.count == regexResults.count)
        regexResults.forEach {
            XCTAssert(results!.contains($0))
        }
    }
}
