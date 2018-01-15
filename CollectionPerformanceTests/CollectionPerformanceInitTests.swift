//
//  CollectionPerformanceInitTests.swift
//  CollectionPerformanceTests
//
//  Created by Piotr Sochalewski on 03.01.2018.
//  Copyright © 2018 Netguru Sp. z o.o. All rights reserved.
//

import XCTest
@testable import CollectionPerformance

final class CollectionPerformanceInitTests: XCTestCase {
    
    private var sut: Validator!
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testPerformanceArrayWordValidator() {
        self.measure {
            sut = ArrayWordValidator()
        }
    }
    
    func testPerformanceCapacityArrayWordValidator() {
        self.measure {
            sut = CapacityArrayWordValidator()
        }
    }
    
    func testPerformanceContiguousArrayWordValidator() {
        self.measure {
            sut = ContiguousArrayWordValidator()
        }
    }
    
    func testPerformanceCapacityContiguousArrayWordValidator() {
        self.measure {
            sut = CapacityContiguousArrayWordValidator()
        }
    }
    
    func testPerformanceSetWordValidator() {
        self.measure {
            sut = SetWordValidator()
        }
    }
    
    func testPerformanceCleverArrayWordValidator() {
        self.measure {
            sut = CleverArrayWordValidator()
        }
    }
    
    func testPerformanceCleverSetWordValidator() {
        self.measure {
            sut = CleverSetWordValidator()
        }
    }
    
    func testPerformanceTrieWordValidator() {
        self.measure {
            sut = TrieWordValidator()
        }
    }
    
    func testPerformanceRealmWordValidator() {
        self.measure {
            sut = RealmWordValidator()
        }
    }
    
    func testPerformanceSmartRealmWordValidator() {
        self.measure {
            sut = SmartRealmWordValidator()
        }
    }
}
