//
//  ViewController.swift
//  REES46
//
//  Created by Avsi222 on 08/06/2020.
//  Copyright (c) 2020 Avsi222. All rights reserved.
//

import UIKit
import REES46

class ViewController: UIViewController {
    
    @IBOutlet private weak var fcmTokenLabel: UITextView!
    @IBOutlet private weak var pushTokenLabel: UITextView!
    @IBOutlet private weak var didLabel: UITextView!
    
    @IBOutlet private weak var updateButton: UIButton!
    @IBOutlet private weak var storiesBackView: StoriesView!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateButton.addTarget(self, action: #selector(didTapUpdate), for: .touchUpInside)
        addObserver()
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateStories), name: globalSDKNotificationName, object: nil)
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: globalSDKNotificationName, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func updateStories() {
        if let globalSDK = globalSDK {
            storiesBackView.configure(sdk: globalSDK, mainVC: self, code: "fcaa8d3168ab7d7346e4b4f1a1c92214")
            
        }
    }
    
    @objc
    func didTapUpdate() {
        pushTokenLabel.text = "PUSHTOKEN = " + pushGlobalToken
        fcmTokenLabel.text = "FCMTOKEN = " + fcmGlobalToken
        didLabel.text = "DID = " + didToken
        if let globalSDK = globalSDK {
            storiesBackView.configure(sdk: globalSDK, mainVC: self, code: "fcaa8d3168ab7d7346e4b4f1a1c92214")
        }
    }
}


@IBDesignable class UpdateButton: UIButton{
    override func layoutSubviews() {
        super.layoutSubviews()

        updateCornerRadius()
    }

    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }

    func updateCornerRadius() {
        layer.backgroundColor = UIColor.white.cgColor
        layer.masksToBounds = true
        layer.borderWidth = 1.2
        layer.borderColor = UIColor.systemBlue.cgColor
        layer.cornerRadius = frame.size.height / 2
    }
}
