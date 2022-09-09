//
//  AddItemViewController.swift
//  checklist
//
//  Created by Mark Bowen on 8/31/22.
//

import UIKit

//delegate protocol

protocol ItemDetailViewControllerDelegate: AnyObject {
  func itemDetailViewControllerDidCancel(
    _ controller: ItemDetailViewController)
  func itemDetailViewController(
    _ controller: ItemDetailViewController,
    didFinishAdding item: ChecklistItem
  )
  func itemDetailViewController(
    _ controller: ItemDetailViewController,
    didFinishEditing item: ChecklistItem
  )
}

class ItemDetailViewController: UITableViewController,
UITextFieldDelegate {
   
    //delegate protocol
    
    var itemToEdit: ChecklistItem?
    
    @IBOutlet weak var shouldRemindSwitch: UISwitch!
   @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    weak var delegate: ItemDetailViewControllerDelegate?
    // MARK: - Actions
    @IBAction func cancel() {
      delegate?.itemDetailViewControllerDidCancel(self)
    }
    @IBAction func done() {
      if let item = itemToEdit {
        item.text = textField.text!
          
          item.shouldRemind = shouldRemindSwitch.isOn  // add this
             item.dueDate = datePicker.date               // add this
          item.scheduleNotification()

        delegate?.itemDetailViewController(
    self,
          didFinishEditing: item)
      } else {
        let item = ChecklistItem()
        item.text = textField.text!
          item.checked = false
          item.shouldRemind = shouldRemindSwitch.isOn  // add this
            item.dueDate = datePicker.date
         
          
        delegate?.itemDetailViewController(self, didFinishAdding: item)
          
    } }

    override func viewDidLoad() {
      super.viewDidLoad()
      if let item = itemToEdit {
        title = "Edit Item"
        textField.text = item.text
        doneBarButton.isEnabled = true
          shouldRemindSwitch.isOn = item.shouldRemind  // add this
              datePicker.date = item.dueDate               // add this
    } }
  //disable selections
    // MARK: - Table View Delegates
    override func tableView(
      _ tableView: UITableView,
      willSelectRowAt indexPath: IndexPath
    ) -> IndexPath? {
    return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      textField.becomeFirstResponder()
    }
    // MARK: - Text Field Delegates
    func textField(
      _ textField: UITextField,
      shouldChangeCharactersIn range: NSRange,
      replacementString string: String
    ) -> Bool {
      let oldText = textField.text!
      let stringRange = Range(range, in: oldText)!
      let newText = oldText.replacingCharacters(
        in: stringRange,
        with: string)
      if newText.isEmpty {
        doneBarButton.isEnabled = false
          
      } else {
        doneBarButton.isEnabled = true
      }
    return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
      doneBarButton.isEnabled = false
    return true
    }
    @IBAction func shouldRemindToggled(_ switchControl: UISwitch) {
      textField.resignFirstResponder()
      if switchControl.isOn {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) {_, _
    in
    } }
    }
    
}
