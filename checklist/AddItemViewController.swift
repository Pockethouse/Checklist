//
//  AddItemViewController.swift
//  checklist
//
//  Created by Mark Bowen on 8/31/22.
//

import UIKit

class AddItemViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    // MARK: - Actions
    @IBAction func cancel() {
      navigationController?.popViewController(animated: true)
    }
    @IBAction func done() {
      navigationController?.popViewController(animated: true)
    }
    
}
