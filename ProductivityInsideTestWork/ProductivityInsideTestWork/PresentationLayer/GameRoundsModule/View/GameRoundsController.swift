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
}

protocol GameRoundControllerOutput {

}

final class GameRoundsController: UINavigationController, GameRoundControllerInput {

	var output: GameRoundControllerOutput?
	
	func pushNextModule(view: UIViewController, animated: Bool) {
		navigationBar.isHidden = true
		pushViewController(view, animated: animated)
	}
	
	func setViewControllersAsFirst(firstController: UIViewController) {
		navigationBar.isHidden = true
		setViewControllers([firstController], animated: true)
	}
}
