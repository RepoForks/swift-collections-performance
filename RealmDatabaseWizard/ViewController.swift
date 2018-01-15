//
//  ViewController.swift
//  RealmDatabaseWizard
//
//  Created by Piotr Sochalewski on 10.01.2018.
//  Copyright © 2018 Netguru Sp. z o.o. All rights reserved.
//

import Cocoa
import RealmSwift

/// An URL to raw text file Polish dictionary.
let fileURL = Bundle.main.url(forResource: "pl_PL", withExtension: "txt")!

final class ViewController: NSViewController {
    
    private let realm = try! Realm()
    
    private lazy var words: [String] = {
        let string = try! String(contentsOf: fileURL, encoding: .utf8)
        return string.components(separatedBy: .newlines)
    }()
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        database()
        cleverDatabase()
    }
    
    /// Creates a database with `Vocabulary` object and writes `Database.realm` to Home directory.
    private func database() {
        try! realm.write {
            realm.deleteAll()
        }
        
        let vocabulary = Vocabulary()
        
        words.forEach { word in
            autoreleasepool {
                let object = StringObject()
                object.value = word
                vocabulary.words.append(object)
            }
        }
        
        try! realm.write {
            realm.add(vocabulary)
        }
        
        let url = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Database.realm")
        try! realm.writeCopy(toFile: url)
    }
    
    /// Creates a database with `CleverVocabulary` object and writes `CleverDatabase.realm` to Home directory.
    private func cleverDatabase() {
        try! realm.write {
            realm.deleteAll()
        }
        
        let vocabulary = CleverVocabulary()
        
        words.forEach { word in
            autoreleasepool {
                let object = StringObject()
                object.value = word
                vocabulary.words[word.count]!.append(object)
            }
        }
        
        try! realm.write {
            realm.add(vocabulary)
        }
        
        let url = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("CleverDatabase.realm")
        try! realm.writeCopy(toFile: url)
    }
}
