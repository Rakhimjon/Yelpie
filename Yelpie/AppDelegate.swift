//
//  AppDelegate.swift
//  Yelpie
//
//  Created by KhuongPham on 11/05/2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setRootViewController()
        return true
    }

    private func setRootViewController() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let homeViewModel = HomeViewModel()
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        let navigationController = UINavigationController(rootViewController: homeViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}

