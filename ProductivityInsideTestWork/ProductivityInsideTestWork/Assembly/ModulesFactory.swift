//
//  ModulesFactory.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import Foundation
import UIKit

class ModulesFactory {
	static let coordinatingController = GameRoundsController()
	class func createModules() -> GameRoundsController {
		createStartNewGameModule()
		createSetNumberToGuessModule()
		createComputerGuessesNumberModule()
		createUserGuessesNumberModule()
		return createGameRoundsModuleAndStart()
	}

	class func createGameRoundsModuleAndStart() -> GameRoundsController {

		let coordinationPresenter = GameRoundsPresenter()
		coordinationPresenter.nextModule = .startNewGameModule
		coordinationPresenter.gameController = coordinatingController
		coordinatingController.output = coordinationPresenter
		coordinationPresenter.nextScreen()
		return coordinatingController
	}
	
	class func createStartNewGameModule() {
		let storyboard = UIStoryboard.init(name: ModulesConstants.mainStoriboardName, bundle: nil)
        let view = storyboard.instantiateViewController(identifier: ModulesConstants.startNewGameViewIdentifier) as! StartNewGameView

		let presenter = StartNewGamePresenter()
		view.output = presenter
		presenter.view = view
		coordinatingController.registerFirst(module: .startNewGameModule, seed: view)
	}

	class func createSetNumberToGuessModule() {
		let storyboard = UIStoryboard.init(name: ModulesConstants.mainStoriboardName, bundle: nil)
        let view = storyboard.instantiateViewController(identifier: ModulesConstants.setNumberToGuessViewIdentifier) as! SetNumberToGuessView

		let presenter = SetNumberToGuessPresenter()
		view.output = presenter
		presenter.view = view
		coordinatingController.register(module: .setNumberToGuessModule, seed: view)
	}

	class func createComputerGuessesNumberModule() {
		let storyboard = UIStoryboard.init(name: ModulesConstants.mainStoriboardName, bundle: nil)
        let view = storyboard.instantiateViewController(identifier: ModulesConstants.computerGuessesNumberViewIdentifier) as! ComputerGuessesNumberView

		let presenter = ComputerGuessesNumberPresenter()
		view.output = presenter
		presenter.view = view
		//presenter.guessedNumber = guessedNumber
        presenter.computerGuessingService = createComputerGuessingService(minNumber: Constants.minNumber, maxNumber: Constants.maxNumber)
		coordinatingController.register(module: .computerGuessesNumberModule, seed: view)
	}

	class func createUserGuessesNumberModule() {
        let storyboard = UIStoryboard.init(name: ModulesConstants.mainStoriboardName, bundle: nil)
        let view = storyboard.instantiateViewController(identifier: ModulesConstants.userGuessesNumberViewIdentifier) as! UserGuessesNumberView

		let presenter = UserGuessesNumberPresenter()
		view.output = presenter
		presenter.view = view
        presenter.userGuessingService = createUserGuessingService(minNumber: Constants.minNumber, maxNumber: Constants.maxNumber)
		coordinatingController.register(module: .userGuessesNumberModule, seed: view)
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
