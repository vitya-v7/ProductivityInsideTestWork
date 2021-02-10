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
	func setComputerAttempts(attempts: Int)
}

protocol IUserGuessedNumber: IGoToNextScreen {
	func setUserAttempts(attempts: Int)
}

class GameRoundsPresenter: IGoToNextScreen {
	var roundNumber = 0
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


	func nextScreen() {
		if !roundEnded && nextModule.rawValue <= Constants.numberOfRecyclingViews {
			if nextModule == .startNewGameModule {
				pushNextScreen(nextModule: nextModule, parameters: GameState.newGame)
			}
			else {
				pushNextScreen(nextModule: nextModule)
			}
			if nextModule.rawValue == Constants.numberOfRecyclingViews {
				roundEnded = true
				roundNumber = roundNumber + 1
			}

			if nextModule.rawValue < Constants.numberOfRecyclingViews {
				nextModule = NavigationModule(rawValue: nextModule.rawValue + 1)!
			}
		}
		else {
			roundEnded = false
			for _ in 0 ..< Constants.numberOfRecyclingViews {
				gameController?.resetControllersAndStartNewRound()
			}
			if roundNumber < Constants.totalRoundNumber {
				if computerAttemptsInCurrentRound > userAttemptsInCurrentRound {
					computerWins = computerWins + 1
				}
				else {
					userWins = userWins + 1
				}
				nextModule = NavigationModule.setNumberToGuessModule
				pushNextScreen(nextModule: nextModule)
			}
			else {
				nextModule = NavigationModule.startNewGameModule
				if computerWins > userWins {
					pushNextScreen(nextModule: nextModule, parameters: GameState.lose)
				}
				else {
					pushNextScreen(nextModule: nextModule, parameters: GameState.win)
				}
			}
		}
	}

	func pushNextScreen(nextModule: NavigationModule, parameters: Any? = nil) {
		let moduleView = getModuleByEnum(moduleName: nextModule)

		switch nextModule {
		case .computerGuessesNumberModule:
			(moduleView as! ComputerGuessesNumberView).output!.setModuleOutput(moduleOutput: self as IComputerGuessedNumber)
		case .userGuessesNumberModule:
			(moduleView as! UserGuessesNumberView).output!.setModuleOutput(moduleOutput: self as IUserGuessedNumber)
		case .setNumberToGuessModule:
			(moduleView as! SetNumberToGuessView).output!.setModuleOutput(moduleOutput: self as IGoToNextScreen)
		case .startNewGameModule:
			let startView = (moduleView as! StartNewGameView)
			startView.output?.setGameState(state: parameters as! GameState)
			startView.output?.setModuleOutput(moduleOutput: self as IGoToNextScreen)
		}
		gameController?.pushNextModule(view: moduleView, animated: true)
	}
}

extension GameRoundsPresenter: IComputerGuessedNumber {
	func setComputerAttempts(attempts: Int) {
		computerAttemptsInCurrentRound = attempts
	}
}

extension GameRoundsPresenter: IUserGuessedNumber {
	func setUserAttempts(attempts: Int) {
		userAttemptsInCurrentRound = attempts
	}
}
