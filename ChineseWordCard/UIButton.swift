//
//  UIButton.swift
//  ChineseWordCard
//
//  Created by LeeSangchan on 18/08/2019.
//  Copyright © 2019 VerandaStudio. All rights reserved.
//

import UIKit
import FontAwesome_swift

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
    func starButton() {
        self.titleLabel?.font = UIFont.fontAwesome(ofSize: self.titleLabel?.font.pointSize ?? 30.0, style: .solid)
        self.setTitle(String.fontAwesomeIcon(name: FontAwesome.star), for: UIControl.State())
    }
    
    func settingButton() {
        self.titleLabel?.font = UIFont.fontAwesome(ofSize: self.titleLabel?.font.pointSize ?? 30.0, style: .solid)
        self.setTitle(String.fontAwesomeIcon(name: FontAwesome.cog), for: UIControl.State())
    }
    
    func nextButton() {
        self.titleLabel?.font = UIFont.fontAwesome(ofSize: self.titleLabel?.font.pointSize ?? 30.0, style: .solid)
        self.setTitle(String.fontAwesomeIcon(name: FontAwesome.angleRight), for: UIControl.State())
    }
    
    func prevButton() {
        self.titleLabel?.font = UIFont.fontAwesome(ofSize: self.titleLabel?.font.pointSize ?? 30.0, style: .solid)
        self.setTitle(String.fontAwesomeIcon(name: FontAwesome.angleLeft), for: UIControl.State())
    }
}
