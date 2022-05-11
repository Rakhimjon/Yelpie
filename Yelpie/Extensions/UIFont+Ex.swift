//
//  UIFont+Ex.swift
//  RoViu
//
//  Created by KhuongPham on 25/08/2021.
//

import UIKit

extension UIFont {
    static func light(_ size: CGFloat = 14) -> UIFont { return UIFont(name: "Poppins-Light", size: size)! }
    static func regular(_ size: CGFloat = 14) -> UIFont { return UIFont(name: "Poppins-Regular", size: size)! }
    static func italic(_ size: CGFloat = 14) -> UIFont { return UIFont(name: "Poppins-Italic", size: size)! }
    static func medium(_ size: CGFloat = 14) -> UIFont { return UIFont(name: "Poppins-Medium", size: size)! }
    static func semiBold(_ size: CGFloat = 14) -> UIFont { return UIFont(name: "Poppins-SemiBold", size: size)! }
    static func bold(_ size: CGFloat = 14) -> UIFont { return UIFont(name: "Poppins-Bold", size: size)! }
    static func extraBold(_ size: CGFloat = 14) -> UIFont { return UIFont(name: "Poppins-ExtraBold", size: size)! }
}
