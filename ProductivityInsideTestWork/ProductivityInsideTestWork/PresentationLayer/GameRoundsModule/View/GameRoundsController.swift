//
//  GameRoundsController.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 08.02.2021.
//

import Foundation
import UIKit
protocol INavigationSeed: AnyObject {
	var vc: UIViewController { get }
	func set<Parameters>(parameters: Parameters?)
}

extension INavigationSeed
{
	func set<Parameters>(parameters: Parameters?) {
		// do nothing
	}
}


protocol ICoordinatingController: AnyObject {
	func back(animated: Bool)
	func push<Parameters>(module: NavigationModule, parameters: Parameters?, animated: Bool)
}

final class GameRoundsController: UINavigationController {
	private var modules = [NavigationModule: INavigationSeed]()
	private var stack = [INavigationSeed]()
	var output: GameRoundsPresenter?
	func register(module: NavigationModule, seed: INavigationSeed) {
		self.modules[module] = seed
	}

	func registerFirst(module: NavigationModule, seed: INavigationSeed) {
		self.modules[module] = seed
		self.stack.append(seed)
	}
}

extension GameRoundsController: ICoordinatingController
{
	func back(animated: Bool) {
		if self.viewControllers.count > 0 {
			let _ = self.stack.popLast()
			self.popViewController(animated: animated)
		}
 	}

	func push<Parameters>(module: NavigationModule, parameters: Parameters?, animated: Bool) {
		guard let nextModule = self.modules[module] else {
			assertionFailure("module didn't register")
			return
		}

		if self.stack.last?.vc === nextModule.vc { self.stack.removeLast() }

		self.pushViewController(nextModule.vc, animated: animated)
		self.stack.append(nextModule)
		nextModule.set(parameters: parameters)
	}
}
