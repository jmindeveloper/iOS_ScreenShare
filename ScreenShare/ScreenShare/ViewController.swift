//
//  ViewController.swift
//  ScreenShare
//
//  Created by J_Min on 8/10/24.
//

import UIKit
import ReplayKit

class ViewController: UIViewController {

    private let startScreenShareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setSubViews()
    }

    private func setSubViews() {
        view.addSubview(startScreenShareButton)
        
        setConstraints()
        connectTarget()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            startScreenShareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startScreenShareButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startScreenShareButton.widthAnchor.constraint(equalToConstant: 60),
            startScreenShareButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func connectTarget() {
        startScreenShareButton.addTarget(self, action: #selector(startScreenShareButtonAction), for: .touchUpInside)
    }
    
    @objc private func startScreenShareButtonAction() {
        let picker = RPSystemBroadcastPickerView()
        picker.showsMicrophoneButton = false
        picker.preferredExtension = "com.J-Min.ScreenShare.BroadCast"
        
        for subview in picker.subviews {
            if let button = subview as? UIButton {
                button.sendActions(for: UIControl.Event.allTouchEvents)
            }
        }
    }

}

