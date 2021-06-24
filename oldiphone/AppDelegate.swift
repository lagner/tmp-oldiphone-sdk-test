//
//  AppDelegate.swift
//  oldiphone
//
//  Created by Sergey Lagner on 24.06.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = RootViewController()
		window?.makeKeyAndVisible()
		
		return true
	}
}

