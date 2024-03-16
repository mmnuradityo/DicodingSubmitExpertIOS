//
//  NotificationUtils.swift
//  DS_ExpertIOS
//
//  Created by Admin on 15/03/24.
//

import UIKit

class NotificationUtils: NSObject {
  
  func setup() {
    UNUserNotificationCenter.current().delegate = self
  }
  
  func requestNotif(completion: @escaping () -> Void) {
    UNUserNotificationCenter.current()
      .requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
        if granted {
          print("granted")
          completion()
        } else {
          print("denied")
        }
      }
  }
  
  func notify(content: UNMutableNotificationContent) {
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
    let request = UNNotificationRequest(identifier: "message", content: content, trigger: trigger)
    
    let center = UNUserNotificationCenter.current()
    center.add(request) { error in
      if error != nil {
        print("Error = \(error?.localizedDescription ?? "Failed to show notification")")
      } else {
        print("notif has been scheduled")
      }
    }
  }
}

extension NotificationUtils: UNUserNotificationCenterDelegate {
  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    completionHandler([.banner, .badge, .sound])
  }
  
  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
  ) {
    print("UserInfo yang terkait dengan notifikasi == \(response.notification.request.content.userInfo)")
    completionHandler()
  }
}
