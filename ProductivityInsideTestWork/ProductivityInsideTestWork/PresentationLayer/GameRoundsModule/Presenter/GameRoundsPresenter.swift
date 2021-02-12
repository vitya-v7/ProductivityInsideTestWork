//
//  GameRoundsPresenter.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 08.02.2021.
//

import Foundation
import UIKit

protocol IStartNewModuleComplete {
	func startNewGameModuleComplete()
}

protocol ISetNumberToGuessModuleComplete {
	func setNumberToGuessModuleComplete(guessedNumberByUser: Int)
}

protocol IComputerGuessesNumberComplete {
	func computerGuessesNumberModuleComplete(attempts: Int)
}

protocol IUserGuessesNumberComplete {
	func userGuessesNumberModuleComplete(attempts: Int)
}

class GameRoundsPresenter: GameRoundControllerOutput {
	weak var gameController: GameRoundControllerInput?
	var roundNumber = Constants.startRound
	var computerWins = 0
	var userWins = 0
	var userAttemptsInCurrentRound = 0
	var computerAttemptsInCurrentRound = 0
	var currentModule: NavigationModule = .startNewGameModule
	var roundEnded = false

	func getModuleByEnum(moduleName: NavigationModule) -> UIViewController {
		switch moduleName {
		case .startNewGameModule:
			return ModulesFactory.createStartNewGameModule()
		case .setNumberToGuessModule:
			return ModulesFactory.createSetNumberToGuessModule()
		case .computerGuessesNumberModule:
			return ModulesFactory.createComputerGuessesNumberModule()
		case .userGuessesNumberModule:
			return ModulesFactory.createUserGuessesNumberModule()
		}
	}

	func getNextModuleEnum(currentModule: NavigationModule) -> NavigationModule {
		var nextModule = currentModule
		var index = nextModule.rawValue % Constants.numberOfRecyclingViews + 1
		if roundNumber == Constants.totalRoundNumber + 1 {
			index = 0
		}
		nextModule = NavigationModule(rawValue: index)!
		return nextModule
	}

	func setParametersForModule(moduleView: UIViewController, parameters: Any? = nil) {
		switch currentModule {
		case .computerGuessesNumberModule:
			let view = (moduleView as! ComputerGuessesNumberView)
			view.output?.setRoundNumber(roundNumber: roundNumber)
			(view.output! as! ComputerGuessesNumberPresenter).guessedNumber = parameters as! Int
			(view.output as! ComputerGuessesNumberPresenter).moduleOutput = self as IComputerGuessesNumberComplete
		case .userGuessesNumberModule:
			let view = (moduleView as! UserGuessesNumberView)
			view.output?.setRoundNumber(roundNumber: roundNumber)
			(view.output as! UserGuessesNumberPresenter).moduleOutput = self as IUserGuessesNumberComplete
		case .setNumberToGuessModule:
			let view = (moduleView as! SetNumberToGuessView)
			view.output?.setRoundNumber(roundNumber: roundNumber)

			(view.output as! SetNumberToGuessPresenter).moduleOutput = self as ISetNumberToGuessModuleComplete
		case .startNewGameModule:
			let startView = (moduleView as! StartNewGameView)
			if roundNumber == Constants.totalRoundNumber {
				if computerWins > userWins {
					startView.output?.setGameState(state: GameState.lose)
				}
				else {
					startView.output?.setGameState(state: GameState.win)
				}
			}
			else {
				startView.output?.setGameState(state: GameState.newGame)
			}
			(startView.output as! StartNewGamePresenter).moduleOutput = self as IStartNewModuleComplete
		}
	}

	func returnNextModule(parameters: Any? = nil) -> UIViewController {
		currentModule = getNextModuleEnum(currentModule: currentModule)
		return returnCurrentModule(parameters: parameters)
	}

	func returnCurrentModule(parameters: Any? = nil) -> UIViewController {
		let moduleView = getModuleByEnum(moduleName: currentModule)
		setParametersForModule(moduleView: moduleView, parameters: parameters)
		return moduleView
	}
}

extension GameRoundsPresenter: IStartNewModuleComplete {
	func startNewGameModuleComplete() {
		let moduleView = returnNextModule()
		gameController?.setViewControllersAsFirst(firstController: moduleView)
		if roundNumber == Constants.startRound {
			gameController?.dismissLastModule(animated: true)
		}

	}
}

extension GameRoundsPresenter: ISetNumberToGuessModuleComplete {
	func setNumberToGuessModuleComplete(guessedNumberByUser: Int) {
		
		let moduleView = returnNextModule(parameters: guessedNumberByUser)
		gameController?.pushNextModule(view: moduleView, animated: true)
	}
}

extension GameRoundsPresenter: IComputerGuessesNumberComplete {
	func computerGuessesNumberModuleComplete(attempts: Int) {
		computerAttemptsInCurrentRound = attempts
		let moduleView = returnNextModule()
		gameController?.pushNextModule(view: moduleView, animated: true)
	}
}

extension GameRoundsPresenter: IUserGuessesNumberComplete {
	func userGuessesNumberModuleComplete(attempts: Int) {
		userAttemptsInCurrentRound = attempts
		roundNumber = roundNumber + 1
		if roundNumber <= Constants.totalRoundNumber {
			if computerAttemptsInCurrentRound < userAttemptsInCurrentRound {
				computerWins = computerWins + 1
			}
			else {
				userWins = userWins + 1
			}
			let moduleView = returnNextModule()
			gameController?.setViewControllersAsFirst(firstController: moduleView)
		}
		else {
			let moduleView: UIViewController
			if computerWins > userWins {
				moduleView = returnNextModule(parameters: GameState.lose)
			}
			else {
				moduleView = returnNextModule(parameters: GameState.win)
			}
			roundNumber = Constants.startRound
			gameController?.presentResultModule(view: moduleView, animated: true)
		}
	}
}
