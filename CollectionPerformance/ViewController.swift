//
//  ViewController.swift
//  CollectionPerformance
//
//  Created by Piotr Sochalewski on 03.01.2018.
//  Copyright © 2018 Netguru Sp. z o.o. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var methodSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var memoryUsageLabel: UILabel!
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var searchButton: UIButton!
    
    /// A current validator.
    private var validator: Validator? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.isUserInteractionEnabled = true
                self.resultLabel.text = nil
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                UIView.animate(withDuration: 0.3) {
                    self.tableView.alpha = 1.0
                }
            }
        }
    }
    /// A Boolean value indicating whether the app is executing a query.
    private var isSearching = false {
        didSet {
            searchButton.isEnabled = !isSearching
            searchTextField.isEnabled = !isSearching
            methodSegmentedControl.isEnabled = !isSearching
            tableView.isUserInteractionEnabled = !isSearching
            UIApplication.shared.isNetworkActivityIndicatorVisible = isSearching
        }
    }
    /// A Timer instance responsible for
    private var timer: Timer?
    
    private lazy var validators: [Validator.Type] = {
        return [ArrayWordValidator.self, CapacityArrayWordValidator.self, ContiguousArrayWordValidator.self, CapacityContiguousArrayWordValidator.self, SetWordValidator.self, CleverArrayWordValidator.self, CleverSetWordValidator.self, TrieWordValidator.self, RealmWordValidator.self, SmartRealmWordValidator.self]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [unowned self] _ in
            self.memoryUsageLabel.text = "Memory used: \(self.getMemory() ?? 0) MB"
        }
    }
    
    @IBAction private func searchButtonAction(_ sender: Any) {        
        guard let validator = validator else {
            resultLabel.text = "Please select validator first"
            return
        }
        
        let text = searchTextField.text!
        let isStandard = methodSegmentedControl.selectedSegmentIndex == 0
        let beforeDate = Date()
        
        isSearching = true
        
        DispatchQueue.global(qos: .background).async {
            let result: String
            
            if isStandard {
                // Standard
                let isRegex = text.contains("?")
                if isRegex {
                    // Regex
                    if let regexValidator = validator as? CleverValidator {
                        result = regexValidator.regex(phrase: text)?.joined(separator: ", ") ?? "Nothing found"
                    } else {
                        result = "Selected validator does not support regex expressions."
                    }
                } else {
                    // Normal
                    result = validator.validate(word: text) ? "\(text) is correct word" : "\(text) is incorrect word"
                }
            } else {
                // Tiles
                result = validator.words(from: text)?.joined(separator: ", ") ?? "Nothing found"
            }
            let afterDate = Date()
            
            DispatchQueue.main.async {
                let duration = afterDate.timeIntervalSince(beforeDate)
                self.resultLabel.text = "Time: \(String(format: "%.2f", duration))s\n\(result)"
                self.isSearching = false
            }
        }
    }
    
    @IBAction private func infoButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "Info", message: "Polish dictionary by sjp.pl licensed under CC BY 4.0: https://sjp.pl/slownik/growy/", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        searchTextField.resignFirstResponder()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = .boldSystemFont(ofSize: 18)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Validator"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return validators.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = String(describing: validators[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.isUserInteractionEnabled = false
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        UIView.animate(withDuration: 0.3) {
            self.tableView.alpha = 0.1
        }
        let type = validators[indexPath.row]
        DispatchQueue.global(qos: .background).async {
            self.validator = type.init()
        }
    }
}

extension ViewController {
    fileprivate func getMemory() -> UInt64? {
        var taskInfo = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size) / 4
        let kerr: kern_return_t = withUnsafeMutablePointer(to: &taskInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_, task_flavor_t(MACH_TASK_BASIC_INFO), $0, &count)
            }
        }
        if kerr == KERN_SUCCESS {
            return taskInfo.resident_size / 1000000
        } else {
            return nil
        }
    }
}
