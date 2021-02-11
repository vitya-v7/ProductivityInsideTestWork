//
//  GameRoundsController.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 08.02.2021.
//

import Foundation
import UIKit

final class GameRoundsController: UINavigationController {

	func pushNextModule(view: UIViewController, animated: Bool) {
		navigationBar.isHidden = true
		pushViewController(view, animated: animated)
	}
	
	func setViewControllersAsFirst(firstController: UIViewController) {
		navigationBar.isHidden = true
		setViewControllers([firstController], animated: true)
	}
}
