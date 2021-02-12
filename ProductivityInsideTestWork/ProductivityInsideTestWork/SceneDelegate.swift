//
//  SceneDelegate.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		let navVc = ModulesFactory.createGameRoundsModuleAndStart()		
		self.window = UIWindow(windowScene: windowScene)
		self.window!.rootViewController = navVc
		self.window!.makeKeyAndVisible()
	}
}

