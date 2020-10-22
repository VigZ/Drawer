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
                return UIColor(red: 255/255, green: 244/255, blue: 126/255, alpha: 0.85) //Yellowish Cream
            case .secondary:
                return UIColor(red: 94/255, green: 90/255, blue: 46/255, alpha: 1.0) // Greenish Brown
            case .tertiary:
                return UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1.0) // Off Black
            }
        }
    }
}
