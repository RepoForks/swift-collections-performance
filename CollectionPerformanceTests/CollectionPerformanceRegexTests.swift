//
//  CollectionPerformanceRegexTests.swift
//  CollectionPerformanceTests
//
//  Created by Piotr Sochalewski on 08.01.2018.
//  Copyright © 2018 Netguru Sp. z o.o. All rights reserved.
//

import XCTest
@testable import CollectionPerformance

final class CollectionPerformanceRegexTests: XCTestCase {
    
    private var sut: CleverValidator!
    private let regexes = ["p?z?a", "???", "po??r", "pap????", "???????", "tele???"]
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testPerformanceCleverArrayWordValidator() {
        sut = CleverArrayWordValidator()
        
        self.measure {
            regexes.forEach {
                let _ = sut.regex(phrase: $0)
            }
        }
    }
    
    func testPerformanceCleverSetWordValidator() {
        sut = CleverSetWordValidator()

        self.measure {
            regexes.forEach {
                _ = sut.regex(phrase: $0)
            }
        }
    }
    
    func testPerformanceTrieWordValidator() {
        sut = TrieWordValidator()
        
        self.measure {
            regexes.forEach {
                _ = sut.regex(phrase: $0)
            }
        }
    }
    
    func testPerformanceRealmWordValidator() {
        sut = RealmWordValidator()
        
        self.measure {
            regexes.forEach {
                _ = sut.regex(phrase: $0)
            }
        }
    }
    
    func testPerformanceSmartRealmWordValidator() {
        sut = SmartRealmWordValidator()
        
        self.measure {
            regexes.forEach {
                _ = sut.regex(phrase: $0)
            }
        }
    }
}
