//
//  AppColorScheme.swift
//  Drawer
//
//  Created by Kyle on 10/22/20.
//

import Foundation
import UIKit


enum AppColorScheme {
    case primary
    case secondary
    case tertiary
}

extension AppColorScheme {
    var value: UIColor {
        get {
            switch self {
            case .primary:
                return UIColor(red: 255.0, green: 213.0, blue: 126.0, alpha: 1.0)
            case .secondary:
                return UIColor(red: 255.0, green: 244.0, blue: 126.0, alpha: 1.0)
            case .tertiary:
                return UIColor(red: 255.0, green: 180.0, blue: 126.0, alpha: 1.0)
            }
        }
    }
}
