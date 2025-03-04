//
//  StoryButton.swift
//  REES46
//
//  Created by REES46
//  Copyright (c) 2023. All rights reserved.
//

import UIKit

protocol CustomButtonDelegate: AnyObject {
    func openDeepLink(url: String)
    func openLinkIosExternal(url: String)
    func openLinkWebExternal(url: String)
}

class StoryButton: UIButton {
    
    var _buttonData: StoriesElement?
    weak var delegate: CustomButtonDelegate?
    
    init() {
        super.init(frame: .zero)
        setToDefault()
    }
    
    func configButton(buttonData: StoriesElement) {
        if let font = buttonData.textBold {
            self.titleLabel?.font = .systemFont(ofSize: 14, weight: font ? .bold : .regular)
        }
        
        self.setTitle(buttonData.title ?? "", for: .normal)
        
        if let bgColor = buttonData.background {
            let color = bgColor.hexToRGB()
            self.backgroundColor = UIColor(red: color.red, green: color.green, blue: color.blue, alpha: 1)
        } else {
            self.backgroundColor = .white
        }
        
        if let titleColor = buttonData.color {
            let color = titleColor.hexToRGB()
            self.setTitleColor(UIColor(red: color.red, green: color.green, blue: color.blue, alpha: 1), for: .normal)
        } else {
            self.setTitleColor(.black, for: .normal)
        }
        
        self.layer.cornerRadius = CGFloat(buttonData.cornerRadius)
    }
    
    private func setToDefault() {
        self.backgroundColor = .white
        self.setTitleColor(.black, for: .normal)
        self.setTitle("", for: .normal)
    }
    
    @objc public func didTapOnButton() {
        
        if let iosLink = _buttonData?.linkIos {
            delegate?.openLinkIosExternal(url: iosLink)
            //delegate?.openDeepLink(url: iosLink)
            return
        }
        if let link = _buttonData?.link {
            delegate?.openDeepLink(url: link)
            return
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setToDefault()
    }
}
