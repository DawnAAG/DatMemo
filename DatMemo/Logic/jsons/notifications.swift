//
//  notifications.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 18.07.2024.
//

import Foundation
import UserNotifications

func scheduleNotification() {
    let notificationContent = UNMutableNotificationContent()
    let messages = [
        "Maybe you should call them?📞",
        "Don't you miss them?🥺",
        "How was your partner's day?❤️",
        "Maybe Netflix today?😏"
    ]
    notificationContent.title = "Reminder"
    notificationContent.body = messages.randomElement() ?? "Don't forget to add new memories!"

    // Configure the trigger for 7 days from now
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)

    // Create the request
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)

    // Schedule the request with the system
    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            print("Notification scheduling error: \(error.localizedDescription)")
        } else {
            print("Notification scheduled successfully")
        }
    }
}


//use scheduleNotification()
