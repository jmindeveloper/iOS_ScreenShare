//
//  ScreenShareViewModel.swift
//  ScreenShare
//
//  Created by J_Min on 8/10/24.
//

import Foundation
import Combine

final class ScreenShareViewModel {
    
    private var subscriptions = Set<AnyCancellable>()
    
    func observeBroadCastImageBuffer() {
        CFNotificationCenterAddObserver(
            CFNotificationCenterGetDarwinNotifyCenter(),
            nil,
            { (_, _, _, _, _) in
                NotificationCenter.default.post(name: .SET_BROADCAST_IMAGE_DATA, object: nil)
            },
            CFNotificationName.SET_BROADCAST_IMAGE_DATA.rawValue,
            nil,
            .deliverImmediately
        )
        
        NotificationCenter.default.publisher(for: .SET_BROADCAST_IMAGE_DATA)
            .sink { [weak self] _ in
                guard let self = self else { return }
                if let data = UserDefaults.groupShared.data(forKey: UserDefaults.BROADCAST_IMAGE_KEY) {
                    // TODO: - 이미지 전송
                }
            }.store(in: &subscriptions)
    }
}
