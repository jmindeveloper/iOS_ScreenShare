//
//  GroupUserDefaults.swift
//  ScreenShare
//
//  Created by J_Min on 8/10/24.
//

import Foundation

extension CFNotificationName {
    static let SET_BROADCAST_IMAGE_DATA = CFNotificationName("SET_BROADCAST_IMAGE_DATA" as CFString)
    /// broadcast 중지 요청
    static let STOP_BROADCAST = CFNotificationName("STOP_BROADCAST" as CFString)
    /// broadcast 종료 알림
    static let FINISH_BROADCAST = CFNotificationName("FINISH_BROADCAST" as CFString)
}

extension Notification.Name {
    static let SET_BROADCAST_IMAGE_DATA = Notification.Name("SET_BROADCAST_IMAGE_DATA")
    /// broadcast 중지 요청
    static let STOP_BROADCAST = Notification.Name("STOP_BROADCAST")
    /// broadcast 종료 알림
    static let FINISH_BROADCAST = Notification.Name("FINISH_BROADCAST")
}

extension UserDefaults {
    static let BROADCAST_IMAGE_KEY = "BROADCAST_IMAGE_BUFFER_KEY"
    
    static var groupShared: UserDefaults {
        let groupId = "group.com.J-Min.ScreenShare"
        if let userDefaults = UserDefaults(suiteName: groupId) {
            return userDefaults
        } else {
            fatalError("failed get userdefaults")
        }
    }
}
