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

    static let darkText: UIColor = .hex("141414")
    static let seperateLine: UIColor = .hex("D7D7D7")
    static let ratingBackground: UIColor = .hex("A0A0A0")
    static let primaryColor: UIColor = .hex("D63031")
}
