//
//  AbstractFactory.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import Foundation
import UIKit

class AbstractFactory {
	class func createStartNewGameModule() -> UIViewController {
		let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
		let view = storyboard.instantiateViewController(identifier: "StartNewGameViewIdentifier") as! StartNewGameView

		let presenter = StartNewGamePresenter()
		view.output = presenter
		presenter.view = view
		return view
	}

	class func createSetNumberToGuessModule() -> UIViewController {
		let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
		let view = storyboard.instantiateViewController(identifier: "SetNumberToGuessViewIdentifier") as! SetNumberToGuessView

		let presenter = SetNumberToGuessPresenter()
		view.output = presenter
		presenter.view = view
		return view
	}

	class func createComputerGuessesNumberModule() -> UIViewController {
		let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
		let view = storyboard.instantiateViewController(identifier: "ComputerGuessesNumberViewIdentifier") as! ComputerGuessesNumberView

		let presenter = ComputerGuessesNumberPresenter()
		view.output = presenter
		presenter.view = view
		return view
	}

	class func createUserGuessesNumberModule() -> UIViewController {
		let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
		let view = storyboard.instantiateViewController(identifier: "UserGuessesNumberViewIdentifier") as! UserGuessesNumberView

		let presenter = UserGuessesNumberPresenter()
		view.output = presenter
		presenter.view = view
		return view
	}

}
