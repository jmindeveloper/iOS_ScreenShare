//
//  GroupUserDefaults.swift
//  ScreenShare
//
//  Created by J_Min on 8/10/24.
//

import Foundation

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
    
    var broadcastImageData: Data? {
        return UserDefaults.groupShared.data(forKey: UserDefaults.BROADCAST_IMAGE_KEY)
    } 
}
