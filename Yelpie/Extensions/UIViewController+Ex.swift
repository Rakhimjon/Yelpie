//
//  UIViewController+Ex.swift
//  RoViu
//
//  Created by KhuongPham on 24/08/2021.
//

import Foundation
import UIKit

/// `UIViewController` extensions.
extension UIViewController {
    /// The main factory method for making a scene which includes a view controller, a view model and a storyboard.
    static func instantiate() -> Self {
        let name = String(describing: self).replacingOccurrences(of: "ViewController", with: "")
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        guard let controller = initial as? Self else {
            fatalError("Could not create \(name), please check your storyboard again.")
        }
        return controller
    }
}

// MARK: UINavigationController embeded
extension UIViewController {
    func embeded(in nav: UINavigationController? = nil) -> UINavigationController {
        if let nav = nav {
            nav.setViewControllers([self], animated: false)
            return nav
        } else {
            let nav = UINavigationController(rootViewController: self)
            nav.navigationBar.isTranslucent = false
            nav.navigationBar.barTintColor = .hex("0071FC")
            return nav
        }
    }
}
