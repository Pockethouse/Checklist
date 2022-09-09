//
//  ChecklistItem.swift
//  checklist
//
//  Created by Mark Bowen on 8/31/22.
//
//currently only serves to combine the text and the checked variables into one object.
import Foundation
import UserNotifications


class ChecklistItem: NSObject, Codable {
    var dueDate = Date()
    var shouldRemind = false
    var itemID = -1
    
    var text = ""
  var checked = false

    
  
    
    
    override init() {
      super.init()
      itemID = DataModel.nextChecklistItemID()
    }
    
    func scheduleNotification() {
        removeNotification()
      if shouldRemind && dueDate > Date() {
    // 1
        let content = UNMutableNotificationContent()
        content.title = "Reminder:"
        content.body = text
        content.sound = UNNotificationSound.default
    // 2
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(
          [.year, .month, .day, .hour, .minute],
          from: dueDate)
    // 3
        let trigger = UNCalendarNotificationTrigger(
          dateMatching: components,
          repeats: false)
    // 4
        let request = UNNotificationRequest(
          identifier: "\(itemID)",
          content: content,  trigger: trigger)
          // 5
              let center = UNUserNotificationCenter.current()
              center.add(request)
              print("Scheduled: \(request) for itemID: \(itemID)")
            }
          }
    
    func removeNotification() {
      let center = UNUserNotificationCenter.current()
      center.removePendingNotificationRequests(withIdentifiers: ["\(itemID)"])
    }
    
    deinit {
     removeNotification()
   }
}
