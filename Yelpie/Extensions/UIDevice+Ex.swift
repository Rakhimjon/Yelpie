//
//  UIDevice+Ex.swift
//  Yelpie
//
//  Created by KhuongPham on 11/05/2022.
//

import Foundation
import UIKit

extension UIDevice {
    var hasTopNotch: Bool {
        return UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0 > 20
    }
}
