//
//  GameRoundsPresenter.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 08.02.2021.
//

import Foundation

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

	func nextScreen() {
		if !roundEnded && nextModule.rawValue <= Constants.numberOfRecyclingViews {

			if nextModule == .computerGuessesNumberModule {
				gameController?.push(module: nextModule, parameters: self as IComputerGuessedNumber, animated: true)
			}

			else if nextModule == .userGuessesNumberModule {
				gameController?.push(module: nextModule, parameters: self as IUserGuessedNumber, animated: true)
			}

			else {
				gameController?.push(module: nextModule, parameters: self as IGoToNextScreen, animated: true)
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
				gameController?.back(animated: false)
			}
			if roundNumber < Constants.totalRoundNumber {
				if computerAttemptsInCurrentRound > userAttemptsInCurrentRound {
					computerWins = computerWins + 1
				}
				else {
					userWins = userWins + 1
				}
				nextModule = NavigationModule.setNumberToGuessModule
				gameController?.push(module: nextModule, parameters: self as IGoToNextScreen, animated: true)
			}
			else {
				nextModule = NavigationModule.startNewGameModule
				gameController?.push(module: nextModule, parameters: self as IGoToNextScreen, animated: true)
			}
		}
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
