//
//  Collection+Permute.swift
//  CollectionPerformance
//
//  Created by Piotr Sochalewski on 15.01.2018.
//  Copyright © 2018 Netguru Sp. z o.o. All rights reserved.
//

extension Array where Element == String {
    private func permute(fromList: [String], toList: [String], minStringLen: Int, set: inout Set<String>) {
        if toList.count >= minStringLen {
            set.insert(toList.joined())
        }
        guard !fromList.isEmpty else { return }
        for (index, item) in fromList.enumerated() {
            var newFrom = fromList
            newFrom.remove(at: index)
            permute(fromList: newFrom, toList: toList + [item], minStringLen: minStringLen, set: &set)
        }
    }
    
    /// Returns set of unique permutations of `self`.
    /// - parameter minStringLen: The minimum desired string length. Default is 2.
    func permute(minStringLen: Int = 2) -> Set<String> {
        var set = Set<String>()
        permute(fromList: self, toList: [], minStringLen: minStringLen, set: &set)
        return set
    }
}

extension Set where Element == String {
    private func permute(fromList: Set<String>, toList: [String], minStringLen: Int, set: inout Set<String>) {
        if toList.count >= minStringLen {
            set.insert(toList.joined())
        }
        guard !fromList.isEmpty else { return }
        fromList.forEach {
            var newFrom = fromList
            newFrom.remove($0)
            permute(fromList: newFrom, toList: toList + [$0], minStringLen: minStringLen, set: &set)
        }
    }
    
    /// Returns set of unique permutations of `self`.
    /// - parameter minStringLen: The minimum desired string length. Default is 2.
    func permute(minStringLen: Int = 2) -> Set<String> {
        var set = Set<String>()
        permute(fromList: self, toList: [], minStringLen: minStringLen, set: &set)
        return set
    }
}

