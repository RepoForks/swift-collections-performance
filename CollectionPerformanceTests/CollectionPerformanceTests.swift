//
//  CollectionPerformanceInitTests.swift
//  CollectionPerformanceTests
//
//  Created by Piotr Sochalewski on 03.01.2018.
//  Copyright © 2018 Piotr Sochalewski. All rights reserved.
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
    
}
