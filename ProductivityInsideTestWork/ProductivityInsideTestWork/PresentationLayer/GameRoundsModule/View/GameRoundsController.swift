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
		pushViewController(view, animated: animated)
	}

	func resetControllersAndStartNewRound() {
		for _ in 0 ..< Constants.numberOfRecyclingViews {
			popViewController(animated: false)
		}
	}
}
