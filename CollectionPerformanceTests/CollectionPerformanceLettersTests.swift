//
//  CollectionPerformanceLettersTests.swift
//  CollectionPerformanceTests
//
//  Created by Piotr Sochalewski on 03.01.2018.
//  Copyright © 2018 Netguru Sp. z o.o. All rights reserved.
//

import XCTest
@testable import CollectionPerformance

final class CollectionPerformanceLettersTests: XCTestCase {
    
    private var sut: Validator!
    private let letters = "spat" //"spatd"
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testPerformanceArrayWordValidator() {
        sut = ArrayWordValidator()

        self.measure {
            _ = sut.words(from: letters)
        }
    }
    
    func testPerformanceCapacityArrayWordValidator() {
        sut = CapacityArrayWordValidator()

        self.measure {
            _ = sut.words(from: letters)
        }
    }
    
    func testPerformanceContiguousArrayWordValidator() {
        sut = ContiguousArrayWordValidator()

        self.measure {
            _ = sut.words(from: letters)
        }
    }
    
    func testPerformanceCapacityContiguousArrayWordValidator() {
        sut = CapacityContiguousArrayWordValidator()

        self.measure {
            _ = sut.words(from: letters)
        }
    }
    
    func testPerformanceSetWordValidator() {
        sut = SetWordValidator()

        self.measure {
            _ = sut.words(from: letters)
        }
    }
    
    func testPerformanceCleverArrayWordValidator() {
        sut = CleverArrayWordValidator()
        
        self.measure {
            _ = sut.words(from: letters)
        }
    }
    
    func testPerformanceCleverSetWordValidator() {
        sut = CleverSetWordValidator()
        
        self.measure {
            _ = sut.words(from: letters)
        }
    }
    
    func testPerformanceTrieWordValidator() {
        sut = TrieWordValidator()
        
        self.measure {
            _ = sut.words(from: letters)
        }
    }
    
    func testPerformanceRealmWordValidator() {
        sut = RealmWordValidator()
        
        self.measure {
            _ = sut.words(from: letters)
        }
    }
    
    func testPerformanceSmartRealmWordValidator() {
        sut = SmartRealmWordValidator()
        
        self.measure {
            _ = sut.words(from: letters)
        }
    }
}
