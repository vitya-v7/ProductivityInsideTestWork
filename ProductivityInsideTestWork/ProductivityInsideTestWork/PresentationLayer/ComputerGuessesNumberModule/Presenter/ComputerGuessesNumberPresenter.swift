//
//  ComputerGuessesNumberPresenter.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import Foundation
import UIKit

protocol IComputerGuessesNumberModuleInput {
	func setModuleOutput(moduleOutput: IComputerGuessesNumberModuleOutput)
	func setRoundNumber(roundNumber: Int)
	func setGuessedNumber(guessedNumber: Int)
}

class ComputerGuessesNumberPresenter: ComputerGuessesNumberViewOutput {

	weak var view: ComputerGuessesNumberViewInput?
	var computerGuessingService: ComputerGuessingServiceInterface!
	var moduleOutput: IComputerGuessesNumberModuleOutput?
	var guessedNumberByComputer: Int?
	var roundNumber: Int?

	// computer uses binary search to guess number
	func viewDidLoadDone() {
		view?.setInitialState()
		let computerNumber = computerGuessingService.startGame(guessedNumber: guessedNumberByComputer!)
		let viewModel = ComputerGuessesNumberViewModel(roundNumber: roundNumber!, guessedNumberByComputer: computerNumber)
		view?.setViewModel(viewModel: viewModel)
	}

	// computer uses binary search to guess number
	func greaterButtonPressed() {
		do {
			let computerNumber = try computerGuessingService.greater()
			view?.unsetAlert()
			let viewModel = ComputerGuessesNumberViewModel(roundNumber: roundNumber!, guessedNumberByComputer: computerNumber)
			view?.setViewModel(viewModel: viewModel)
		}
		catch ComputerGuessingService.WrongButton.unfairGame(let message) {
			view?.setAlert(string: message)
			return
		}
		catch  {
			fatalError("lessButtonPressed() - unknown error")
		}
	}

	func lessButtonPressed() {
		do {
			let computerNumber = try computerGuessingService.less()
			view?.unsetAlert()
			let viewModel = ComputerGuessesNumberViewModel(roundNumber: roundNumber!, guessedNumberByComputer: computerNumber)
			view?.setViewModel(viewModel: viewModel)
		}
		catch ComputerGuessingService.WrongButton.unfairGame(let message) {
			view?.setAlert(string: message)
			return
		}
		catch  {
			fatalError("lessButtonPressed() - unknown error")
		}
	}

	func equalButtonPressed() {
		do {
			try computerGuessingService.equal()
			// no exceptions = computer guessed user's number
			view?.unsetAlert()
			moduleOutput?.computerGuessesNumberModuleComplete(attempts: computerGuessingService.attempts)
		}
		catch ComputerGuessingService.WrongButton.unfairGame(let message) {
			view?.setAlert(string: message)
			return
		}
		catch  {
			fatalError("lessButtonPressed() - unknown error")
		}
	}
}

extension ComputerGuessesNumberPresenter: IComputerGuessesNumberModuleInput {

	func setModuleOutput(moduleOutput: IComputerGuessesNumberModuleOutput) {
		self.moduleOutput = moduleOutput
	}

	func setRoundNumber(roundNumber: Int) {
		self.roundNumber = roundNumber
	}

	func setGuessedNumber(guessedNumber: Int) {
		self.guessedNumberByComputer = guessedNumber
	}
}
