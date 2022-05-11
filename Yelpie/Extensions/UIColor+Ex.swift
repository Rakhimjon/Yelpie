//
//  UIColor+Ex.swift
//  RoViu
//
//  Created by KhuongPham on 24/08/2021.
//

import UIKit

/// `UIColor` extensions.
extension UIColor {
    /**
     Creates and returns a color from a hex string.
     - Parameter value: The hex string value.
     */
    static func hex(_ value: String, _ alpha: CGFloat? = 1.0) -> UIColor {
        let hex = value.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: alpha ?? 1.0)
    }
    
    /**
     Creates and returns a color for distinctive userInterfaceStyles
     - Parameter light: The color for light interface
     - Parameter dark: The color for dark interface
     */
    static func userInterfaceStyle(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
        } else {
            return light
        }
    }
}
