//
//  CallDirectoryViewController.swift
//  iOS-10-Sampler
//
//  Created by Masayoshi Ukida on 2016/10/06.
//  Copyright © 2016年 Shuichi Tsutsumi. All rights reserved.
//

import UIKit

class CallDirectoryViewController: UIViewController {
    enum SegmentIndex: Int {
        case blocks = 0
        case labels
    }
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    lazy var blocks: [String] = {
        guard let blocks = UserDefaults.callDirectoryShared().callDirectoryBlocks() else {
            return []
        }
        return blocks
    }()
    lazy var labels: [String: String] = {
        guard let labels = UserDefaults.callDirectoryShared().callDirectoryLabels() else {
            return [String: String]()
        }
        return labels
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Action
    @IBAction func add(sender: AnyObject) {
        guard let segment = SegmentIndex(rawValue: segmentedControl.selectedSegmentIndex) else {
            return
        }
        
        switch segment {
        case .blocks:
            addBlock()
            
        case .labels:
            addLabel()
        }
    }
    
    @IBAction func change(sender: AnyObject) {
        
    }
    
    // MARK: - method
    func addBlock() {
        let alertController = UIAlertController(title: "Add block", message: "", preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: {
            textField in
            textField.placeholder = "Telephone number"
            textField.keyboardType = .phonePad
        })
        alertController.addAction(UIAlertAction(title: "Add", style: .default) { [weak self] action in
            let numberText = alertController.textFields?.first?.text ?? ""
            self?.createBlock(number: numberText)
            self?.tableView.reloadData()
        })
        
        present(alertController, animated: true)
    }
    
    func addLabel() {
        let alertController = UIAlertController(title: "Add identify and labels", message: "", preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: {
            textField in
            textField.placeholder = "Telephone number(required international code)"
            textField.keyboardType = .phonePad
        })
        alertController.addTextField(configurationHandler: {
            textField in
            textField.placeholder = "Label"
        })
        alertController.addAction(UIAlertAction(title: "Add", style: .default) { [weak self] action in
            let numberText = alertController.textFields?.first?.text ?? ""
            let labelText = alertController.textFields?.last?.text ?? ""
            self?.createLabel(number: numberText, label: labelText)
            self?.tableView.reloadData()
        })
        
        present(alertController, animated: true)
    }
    
    func createBlock(number: String) {
        if !blocks.contains(number) {
            blocks.append(number)
        }
    }
    
    func createLabel(number: String, label: String) {
        labels[number] = label
    }

}

extension CallDirectoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let segment = SegmentIndex(rawValue: segmentedControl.selectedSegmentIndex) else {
            return 0
        }
        
        var rows = 0
        switch segment {
        case .blocks:
            rows = 1
            
        case .labels:
            rows = 2
        }
        
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let segment = SegmentIndex(rawValue: segmentedControl.selectedSegmentIndex)
        var cell: UITableViewCell? = nil
        if segment == .blocks {
            cell = tableView.dequeueReusableCell(withIdentifier: "Basic",
                                                 for: indexPath)
            cell?.textLabel?.text = ""
        }
        else if segment == .labels {
            cell = tableView.dequeueReusableCell(withIdentifier: "Subtitle",
                                                 for: indexPath)
            cell?.textLabel?.text = ""
            cell?.detailTextLabel?.text = ""
        }
        
        return cell!
    }
}

extension CallDirectoryViewController: UITableViewDelegate {
    
}
