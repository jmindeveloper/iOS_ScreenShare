//
//  SampleHandler.swift
//  BroadCast
//
//  Created by J_Min on 8/10/24.
//

import ReplayKit
import Combine

class SampleHandler: RPBroadcastSampleHandler {

    private var subscriptions = Set<AnyCancellable>()
    
    override init() {
        super.init()
        print(#function, #file)
        
        
        CFNotificationCenterAddObserver(
            CFNotificationCenterGetDarwinNotifyCenter(),
            nil,
            { (_, _, _, _, _) in
                NotificationCenter.default.post(name: .STOP_BROADCAST, object: nil)
            },
            CFNotificationName.STOP_BROADCAST.rawValue,
            nil,
            .deliverImmediately
        )
        
        NotificationCenter.default.publisher(for: .STOP_BROADCAST)
            .sink { [weak self] _ in
                let info = [NSLocalizedFailureReasonErrorKey: "화면공유 종료."]
                let error = NSError(domain: "ScreenShare", code: -1, userInfo: info)
                
                self?.finishBroadcastWithError(error)
            }.store(in: &subscriptions)
    }
    
    override func broadcastFinished() {
        print("broadcast finish", #function)
        CFNotificationCenterPostNotification(
            CFNotificationCenterGetDarwinNotifyCenter(),
            .FINISH_BROADCAST,
            nil,
            nil,
            true
        )
    }
    
    override func processSampleBuffer(_ sampleBuffer: CMSampleBuffer, with sampleBufferType: RPSampleBufferType) {
        if let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) {
            let ciimage = CIImage(cvPixelBuffer: imageBuffer)
            let image = convert(ciImage: ciimage)
            
            if let data = image.jpegData(compressionQuality: 1) {
                UserDefaults.groupShared.setValue(data, forKey: UserDefaults.BROADCAST_IMAGE_KEY)
                CFNotificationCenterPostNotification(
                    CFNotificationCenterGetDarwinNotifyCenter(),
                    .SET_BROADCAST_IMAGE_DATA,
                    nil,
                    nil,
                    true
                )
            }
        }
    }
    
    // Convert CIImage to UIImage
    func convert(ciImage: CIImage) -> UIImage {
        let context = CIContext(options: nil)
        let cgImage = context.createCGImage(ciImage, from: ciImage.extent)!
        let image = UIImage(cgImage: cgImage)
        
        return image
    }
}
