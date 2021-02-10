//
//  ModulesFactory.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import Foundation
import UIKit

class ModulesFactory {
	
	class func createGameRoundsModuleAndStart() -> GameRoundsController {
		let navVc = GameRoundsController()
		navVc.keyboardPreferences()
		let presenter = GameRoundsPresenter()
		presenter.nextModule = .startNewGameModule
		presenter.gameController = navVc
		presenter.moduleComplete()
		return navVc
	}
	
	class func createStartNewGameModule() -> UIViewController {
		let storyboard = UIStoryboard.init(name: ModulesConstants.mainStoriboardName, bundle: nil)
		let view = storyboard.instantiateViewController(identifier: ModulesConstants.startNewGameViewIdentifier) as! StartNewGameView

		let presenter = StartNewGamePresenter()
		view.output = presenter
		presenter.view = view
		return view
	}

	class func createSetNumberToGuessModule() -> UIViewController {
		let storyboard = UIStoryboard.init(name: ModulesConstants.mainStoriboardName, bundle: nil)
		let view = storyboard.instantiateViewController(identifier: ModulesConstants.setNumberToGuessViewIdentifier) as! SetNumberToGuessView

		let presenter = SetNumberToGuessPresenter()
		view.output = presenter
		presenter.view = view
		return view
	}

	class func createComputerGuessesNumberModule() -> UIViewController {
		let storyboard = UIStoryboard.init(name: ModulesConstants.mainStoriboardName, bundle: nil)
		let view = storyboard.instantiateViewController(identifier: ModulesConstants.computerGuessesNumberViewIdentifier) as! ComputerGuessesNumberView

		let presenter = ComputerGuessesNumberPresenter()
		view.output = presenter
		presenter.view = view
		presenter.computerGuessingService = createComputerGuessingService(minNumber: Constants.minNumber, maxNumber: Constants.maxNumber)
		return view
	}

	class func createUserGuessesNumberModule() -> UIViewController {
		let storyboard = UIStoryboard.init(name: ModulesConstants.mainStoriboardName, bundle: nil)
		let view = storyboard.instantiateViewController(identifier: ModulesConstants.userGuessesNumberViewIdentifier) as! UserGuessesNumberView

		let presenter = UserGuessesNumberPresenter()
		view.output = presenter
		presenter.view = view
		presenter.userGuessingService = createUserGuessingService(minNumber: Constants.minNumber, maxNumber: Constants.maxNumber)
		return view
	}

	class func createComputerGuessingService(minNumber: Int, maxNumber: Int) -> ComputerGuessingService {
		return ComputerGuessingService(minNumber: minNumber, maxNumber: maxNumber);
	}

	class func createUserGuessingService(minNumber: Int, maxNumber: Int) -> UserGuessingService {
		return UserGuessingService(minNumber: minNumber, maxNumber: maxNumber);
	}
}

private extension ModulesFactory {
	// MARK: - Constants

	enum ModulesConstants {
		static let mainStoriboardName:String = "Main"
		static let startNewGameViewIdentifier:String = "StartNewGameViewIdentifier"
		static let setNumberToGuessViewIdentifier:String = "SetNumberToGuessViewIdentifier"
		static let computerGuessesNumberViewIdentifier:String = "ComputerGuessesNumberViewIdentifier"
		static let userGuessesNumberViewIdentifier:String = "UserGuessesNumberViewIdentifier"
	}
}
