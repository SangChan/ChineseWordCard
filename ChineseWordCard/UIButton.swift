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

extension UIButton {
    
}
