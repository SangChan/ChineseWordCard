//
//  UIButton.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 18/08/2019.
//  Copyright © 2019 VerandaStudio. All rights reserved.
//

import UIKit

enum ButtonType {
    case star
    case setting
    case next
    case prev
    case unkown
    
    var fontIcon : FontAwesome {
        switch self {
        case .star:
            return .star
        case .setting:
            return .cog
        case .next:
            return .angleRight
        case .prev:
            return .angleLeft
        default:
            return .question
        }
    }
}

/// FontAwesome button
extension UIButton {
    func prepareForAwesomeFont(_ size : CGFloat, style : FontAwesomeStyle = .solid) {
        self.titleLabel?.font = UIFont.fontAwesome(ofSize: size, style: style)
    }
    
    func starButton(size: CGFloat = 30.0, style : FontAwesomeStyle = .solid) {
        self.prepareForAwesomeFont(size, style: style)
        self.setTitle(String.fontAwesomeIcon(name: FontAwesome.star), for: UIControl.State())
    }
    
    func settingButton(size: CGFloat = 30.0) {
        self.prepareForAwesomeFont(size)
        self.setTitle(String.fontAwesomeIcon(name: FontAwesome.cog), for: UIControl.State())
    }
    
    func nextButton(size: CGFloat = 30.0) {
        self.prepareForAwesomeFont(size)
        self.setTitle(String.fontAwesomeIcon(name: FontAwesome.angleRight), for: UIControl.State())
    }
    
    func prevButton(size: CGFloat = 30.0) {
        self.prepareForAwesomeFont(size)
        self.setTitle(String.fontAwesomeIcon(name: FontAwesome.angleLeft), for: UIControl.State())
    }
}
