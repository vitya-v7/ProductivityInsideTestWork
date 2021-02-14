//
//  GameRoundsPresenter.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 08.02.2021.
//

import Foundation
import UIKit

protocol IStartNewGameModuleOutput {
	func startNewGameModuleComplete()
}

protocol ISetNumberToGuessModuleOutput {
	func setNumberToGuessModuleComplete(guessedNumberByUser: Int)
}

protocol IComputerGuessesNumberModuleOutput {
	func computerGuessesNumberModuleComplete(attempts: Int)
}

protocol IUserGuessesNumberModuleOutput {
	func userGuessesNumberModuleComplete(attempts: Int)
}

class GameRoundsPresenter {
	
	weak var gameController: GameRoundViewInput?
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
			let moduleInput = view.output as! IComputerGuessesNumberModuleInput
			moduleInput.setRoundNumber(roundNumber: roundNumber)
			moduleInput.setModuleOutput(moduleOutput: self as IComputerGuessesNumberModuleOutput)
			moduleInput.setGuessedNumber(guessedNumber: parameters as! Int)
		case .userGuessesNumberModule:
			let view = (moduleView as! UserGuessesNumberView)
			let moduleInput = view.output as! IUserGuessesNumberModuleInput
			moduleInput.setRoundNumber(roundNumber: roundNumber)
			moduleInput.setModuleOutput(moduleOutput: self as IUserGuessesNumberModuleOutput)
		case .setNumberToGuessModule:
			let view = (moduleView as! SetNumberToGuessView)
			let moduleInput = view.output as! ISetNumberToGuessModuleInput
			moduleInput.setRoundNumber(roundNumber: roundNumber)
			moduleInput.setModuleOutput(moduleOutput: self as ISetNumberToGuessModuleOutput)
		case .startNewGameModule:
			let startView = (moduleView as! StartNewGameView)
			let moduleInput = startView.output as! IStartNewGameModuleInput
			if roundNumber == Constants.totalRoundNumber + 1 {
				moduleInput.setGameState(state: parameters as! GameState)
			}
			else {
				moduleInput.setGameState(state: GameState.newGame)
			}
			moduleInput.setModuleOutput(moduleOutput: self as IStartNewGameModuleOutput)
		}
	}

	func returnNextModule(parameters: Any? = nil) -> UIViewController {
		currentModule = getNextModuleEnum(currentModule: currentModule)
		let moduleView = getModuleByEnum(moduleName: currentModule)
		setParametersForModule(moduleView: moduleView, parameters: parameters)
		
		return moduleView
	}
}

extension GameRoundsPresenter: IStartNewGameModuleOutput {
	func startNewGameModuleComplete() {
		let moduleView = returnNextModule()
		gameController?.setViewControllersAsFirst(firstController: moduleView)
		if roundNumber == Constants.startRound {
			gameController?.dismissLastModule(animated: true)
		}
	}
}

extension GameRoundsPresenter: ISetNumberToGuessModuleOutput {
	func setNumberToGuessModuleComplete(guessedNumberByUser: Int) {
		let moduleView = returnNextModule(parameters: guessedNumberByUser)
		gameController?.pushNextModule(view: moduleView, animated: true)
	}
}

extension GameRoundsPresenter: IComputerGuessesNumberModuleOutput {
	func computerGuessesNumberModuleComplete(attempts: Int) {
		computerAttemptsInCurrentRound = attempts
		let moduleView = returnNextModule()
		gameController?.pushNextModule(view: moduleView, animated: true)
	}
}

extension GameRoundsPresenter: IUserGuessesNumberModuleOutput {
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
			userWins = 0
			computerWins = 0
			gameController?.presentResultModule(view: moduleView, animated: true)
		}
	}
}
