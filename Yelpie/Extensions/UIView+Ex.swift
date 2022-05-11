//
//  UIView+Ex.swift
//  RoViu
//
//  Created by KhuongPham on 24/08/2021.
//

import UIKit
import Oneline

/// `UIView` + convenient methods.
extension UIView {
    /**
     Add multiple subviews
     - Parameter subviews: various views
     */
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }

    /**
     Round a view
     - Parameter radius: corner radius to be rounded
     - Parameter corners: choose specific corners to be rounded
     */
    func round(by radius: CGFloat? = nil, corners: CACornerMask? = nil) {
        layer.masksToBounds = true
        layer.cornerRadius = radius ?? (frame.height / 2)
        if let corners = corners {
            layer.maskedCorners = corners
        }
    }

    /**
     set border on view
     - Parameter color: color or border
     - Parameter width: width of border
     */
    func setBorder(with color: UIColor, width: CGFloat = 2) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    /**
     set shadow on view
     - Parameter color: color or shadow
     - Parameter opacity: opacity of shadow
     - Parameter radius: radius of shadow
     - Parameter offset: offset of shadow
     */
    func setShadow(color: UIColor = .darkGray, opacity: Float = 0.11, radius: CGFloat = 5.0, offset: CGSize = CGSize(width: 0, height: 2)) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
    }

    /**
     remove shadow on view
     */
    func removeShadow() {
        layer.shadowOpacity = 0
    }
}
