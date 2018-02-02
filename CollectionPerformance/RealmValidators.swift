//
//  RealmValidators.swift
//  CollectionPerformance
//
//  Created by Piotr Sochalewski on 10.01.2018.
//  Copyright © 2018 Netguru Sp. z o.o. All rights reserved.
//

import Foundation
import RealmSwift

/// Word validator based on Realm database.
final class RealmWordValidator: CleverValidator {

    /// A Realm instance.
    private var realm: Realm {
        let config = Realm.Configuration(fileURL: Bundle.main.url(forResource: "Database", withExtension: "realm"), readOnly: true)

        return try! Realm(configuration: config)
    }
    /// A list of strings.
    private var words: List<String> {
        return realm.objects(Vocabulary.self).first!.words
    }

    func validate(word: String) -> Bool {
        // This crashes, because
        // >> Querying is currently only implemented for arrays of Realm Objects <<
        // but may be changed in the future
        let predicate = NSPredicate(format: "SELF == %@", word.lowercased())
        return !words.filter(predicate).isEmpty
    }

    func words(from letters: String) -> [String]? {
        let permutes = letters.lowercased()
            .map { String($0) }
            .permute()
        
        let predicate = NSPredicate(format: "SELF IN %@",permutes)
        return words
            .filter(predicate)
            .map { $0 }
    }

    func regex(phrase: String) -> [String]? {
        let predicate = NSPredicate(format: "SELF LIKE %@", phrase.lowercased())
        return words
            .filter(predicate)
            .map { $0 }
    }
}

/// Word validator based on orderly Realm database.
final class SmartRealmWordValidator: CleverValidator {

    /// A Realm instance.
    private var realm: Realm {
        let config = Realm.Configuration(fileURL: Bundle.main.url(forResource: "CleverDatabase", withExtension: "realm"), readOnly: true)

        return try! Realm(configuration: config)
    }
    /// An array of list of strings.
    ///
    /// Lists in the array contains words with letters count that equals an index of list.
    private var words: [List<String>] {
        return realm.objects(CleverVocabulary.self).first!.words
    }
    
    func validate(word: String) -> Bool {
        guard words.count > word.count && word.count >= 2 else { return false }
        let predicate = NSPredicate(format: "SELF == %@", word.lowercased())
        return !words[word.count].filter(predicate).isEmpty
    }
    
    func words(from letters: String) -> [String]? {
        guard words.count > letters.count else { return nil }
        
        let permutes = letters.lowercased()
            .map { String($0) }
            .permute()
        
        var dividedPermutes = (0...letters.count).map { _ in [String]() }

        permutes.forEach { permute in
            dividedPermutes[permute.count].append(permute)
        }

        return dividedPermutes
            .filter { !$0.isEmpty }
            .map { permute -> LazyMapRandomAccessCollection<Results<String>, String> in
                let predicate = NSPredicate(format: "SELF IN %@", permute)

                return words[permute.first!.count]
                    .filter(predicate)
                    .map { $0 }
            }
            .flatMap { $0 }
    }
    
    func regex(phrase: String) -> [String]? {
        guard words.count > phrase.count else { return nil }
        let predicate = NSPredicate(format: "SELF LIKE %@", phrase.lowercased())
        return words[phrase.count]
            .filter(predicate)
            .map { $0 }
    }
}
