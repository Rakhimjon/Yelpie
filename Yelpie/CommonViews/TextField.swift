//
//  TextField.swift
//  Yelpie
//
//  Created by KhuongPham on 11/05/2022.
//

import Foundation
import UIKit

class TextField: UITextField {
    let inset: CGFloat = 10

    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset , dy: inset)
    }

    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset , dy: inset)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: inset)
    }
}
