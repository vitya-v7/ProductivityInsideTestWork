//
//  GameRoundsPresenter.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 08.02.2021.
//

import Foundation
import UIKit

protocol IGoToNextScreen {
	func nextScreen()
}

protocol IComputerGuessedNumber: IGoToNextScreen {
	func computerEndedItsTurn(attempts: Int)
}

protocol IUserGuessedNumber: IGoToNextScreen {
	func userEndedHisTurn(attempts: Int)
}

class GameRoundsPresenter: IGoToNextScreen {
	var roundNumber = Constants.startRound
	var computerWins = 0
	var userWins = 0
	var userAttemptsInCurrentRound = 0
	var computerAttemptsInCurrentRound = 0
	weak var gameController: GameRoundsController?
	var nextModule: NavigationModule = .startNewGameModule
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

	func isGameInProgress() -> Bool {
		return !roundEnded && nextModule.rawValue <= Constants.numberOfRecyclingViews
	}

	func nextScreen() {
		if isGameInProgress()
		{
			if nextModule == .startNewGameModule {
				let moduleView = returnModule(nextModule: nextModule, parameters: GameState.newGame)
				gameController?.setViewControllersAsFirst(firstController: moduleView)
			}
			else {
				let moduleView = returnModule(nextModule: nextModule)
				gameController?.pushNextModule(view: moduleView, animated: true)
			}
			if nextModule.rawValue == Constants.numberOfRecyclingViews {
				roundEnded = true
				roundNumber = roundNumber + 1
			}
			nextModule = getNextModuleEnum(currentModule: nextModule)
		}
		else {
			roundEnded = false
			if roundNumber <= Constants.totalRoundNumber {
				if computerAttemptsInCurrentRound < userAttemptsInCurrentRound {
					computerWins = computerWins + 1
				}
				else {
					userWins = userWins + 1
				}
				nextModule = NavigationModule.setNumberToGuessModule
				let moduleView = returnModule(nextModule: nextModule)
				gameController?.setViewControllersAsFirst(firstController: moduleView)
				nextModule = getNextModuleEnum(currentModule: nextModule)
			}
			else {
				roundNumber = Constants.startRound
				nextModule = NavigationModule.startNewGameModule
				if computerWins > userWins {
					let moduleView = returnModule(nextModule: nextModule, parameters: GameState.lose)
					gameController?.setViewControllersAsFirst(firstController: moduleView)
					nextModule = getNextModuleEnum(currentModule: nextModule)
				}
				else {
					let moduleView = returnModule(nextModule: nextModule, parameters: GameState.win)
					gameController?.setViewControllersAsFirst(firstController: moduleView)
					nextModule = getNextModuleEnum(currentModule: nextModule)
				}
			}
		}
	}

	func getNextModuleEnum(currentModule: NavigationModule) -> NavigationModule {
		var nextModule = currentModule
		if currentModule.rawValue < Constants.numberOfRecyclingViews {
			nextModule = NavigationModule(rawValue: nextModule.rawValue + 1)!
		}
		return nextModule
	}

	func returnModule(nextModule: NavigationModule, parameters: Any? = nil) -> UIViewController {
		let moduleView = getModuleByEnum(moduleName: nextModule)

		switch nextModule {
		case .computerGuessesNumberModule:
			let view = (moduleView as! ComputerGuessesNumberView)
			view.output?.setRoundNumber(roundNumber: roundNumber)
			view.output?.setModuleOutput(moduleOutput: self as IComputerGuessedNumber)
		case .userGuessesNumberModule:
			let view = (moduleView as! UserGuessesNumberView)
			view.output?.setRoundNumber(roundNumber: roundNumber)
			view.output?.setModuleOutput(moduleOutput: self as IUserGuessedNumber)
		case .setNumberToGuessModule:
			let view = (moduleView as! SetNumberToGuessView)
			view.output?.setRoundNumber(roundNumber: roundNumber)
			view.output?.setModuleOutput(moduleOutput: self as IGoToNextScreen)
		case .startNewGameModule:
			let startView = (moduleView as! StartNewGameView)
			startView.output?.setGameState(state: parameters as! GameState)
			startView.output?.setModuleOutput(moduleOutput: self as IGoToNextScreen)
		}
		return moduleView
	}
}

extension GameRoundsPresenter: IComputerGuessedNumber {
	func computerEndedItsTurn(attempts: Int) {
		computerAttemptsInCurrentRound = attempts
	}
}

extension GameRoundsPresenter: IUserGuessedNumber {
	func userEndedHisTurn(attempts: Int) {
		userAttemptsInCurrentRound = attempts
	}
}
