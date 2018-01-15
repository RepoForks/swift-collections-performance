//
//  CollectionPerformanceContainTests.swift
//  CollectionPerformanceTests
//
//  Created by Piotr Sochalewski on 03.01.2018.
//  Copyright © 2018 Netguru Sp. z o.o. All rights reserved.
//

import XCTest
@testable import CollectionPerformance

final class CollectionPerformanceContainTests: XCTestCase {
    
    private var sut: Validator!
    private let wordsToFind = ["rękodzieło", "porównywać", "rodzicielski", "się", "powierzchnia", "substancja", "jeden", "dzień", "w", "kobieta", "narzędzie", "fałszywy", "pizza", "medycyna", "niematakiegoslowa"]
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testPerformanceArrayWordValidator() {
        sut = ArrayWordValidator()

        self.measure {
            wordsToFind.forEach {
                let _ = sut.validate(word: $0)
            }
        }
    }
    
    func testPerformanceCapacityArrayWordValidator() {
        sut = CapacityArrayWordValidator()

        self.measure {
            wordsToFind.forEach {
                let _ = sut.validate(word: $0)
            }
        }
    }
    
    func testPerformanceContiguousArrayWordValidator() {
        sut = ContiguousArrayWordValidator()

        self.measure {
            wordsToFind.forEach {
                let _ = sut.validate(word: $0)
            }
        }
    }
    
    func testPerformanceCapacityContiguousArrayWordValidator() {
        sut = CapacityContiguousArrayWordValidator()

        self.measure {
            wordsToFind.forEach {
                let _ = sut.validate(word: $0)
            }
        }
    }
    
    func testPerformanceSetWordValidator() {
        sut = SetWordValidator()

        self.measure {
            wordsToFind.forEach {
                let _ = sut.validate(word: $0)
            }
        }
    }
    
    func testPerformanceCleverArrayWordValidator() {
        sut = CleverArrayWordValidator()
        
        self.measure {
            wordsToFind.forEach {
                let _ = sut.validate(word: $0)
            }
        }
    }
    
    func testPerformanceCleverSetWordValidator() {
        sut = CleverSetWordValidator()
        
        self.measure {
            wordsToFind.forEach {
                let _ = sut.validate(word: $0)
            }
        }
    }
    
    func testPerformanceTrieWordValidator() {
        sut = TrieWordValidator()
        
        self.measure {
            wordsToFind.forEach {
                let _ = sut.validate(word: $0)
            }
        }
    }
    
    func testPerformanceRealmWordValidator() {
        sut = RealmWordValidator()
        
        self.measure {
            wordsToFind.forEach {
                let _ = sut.validate(word: $0)
            }
        }
    }
    
    func testPerformanceSmartRealmWordValidator() {
        sut = SmartRealmWordValidator()
        
        self.measure {
            wordsToFind.forEach {
                let _ = sut.validate(word: $0)
            }
        }
    }
}
