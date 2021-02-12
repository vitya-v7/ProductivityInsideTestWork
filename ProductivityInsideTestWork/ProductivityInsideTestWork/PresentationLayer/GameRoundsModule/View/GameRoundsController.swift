//
//  GameRoundsController.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 08.02.2021.
//

import Foundation
import UIKit

protocol GameRoundControllerInput : UIViewController  {
	func pushNextModule(view: UIViewController, animated: Bool)
	func setViewControllersAsFirst(firstController: UIViewController)
	func presentResultModule(view: UIViewController, animated: Bool)
	func dismissLastModule(animated: Bool)
}

final class GameRoundsController: UINavigationController, GameRoundControllerInput {
	
	func pushNextModule(view: UIViewController, animated: Bool) {
		navigationBar.isHidden = true
		pushViewController(view, animated: animated)
	}
	
	func setViewControllersAsFirst(firstController: UIViewController) {
		navigationBar.isHidden = true
		setViewControllers([firstController], animated: true)
	}

	func presentResultModule(view: UIViewController, animated: Bool) {
		let modalStyle: UIModalTransitionStyle = UIModalTransitionStyle.coverVertical
		let presentationStyle: UIModalPresentationStyle = .fullScreen
		view.modalTransitionStyle = modalStyle
		view.modalPresentationStyle = presentationStyle
		present(view, animated: true, completion: nil)
	}

	func dismissLastModule(animated: Bool) {
		dismiss(animated: animated, completion: nil)
	}
}
