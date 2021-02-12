//
//  ComputerGuessesNumberPresenter.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import Foundation
import UIKit

class ComputerGuessesNumberPresenter: ComputerGuessesNumberViewOutput {

	weak var view: ComputerGuessesNumberViewInput?
	var viewModel: ComputerGuessesNumberViewModel?
	var computerGuessingService: ComputerGuessingServiceInterface!
	var roundNumber: Int = 0
	var guessedNumber: Int = 0
	var moduleOutput: IComputerGuessesNumberComplete?

	//Используется бинарный поиск для угадывания числа, заданного пользователем
	func viewDidLoadDone() {
		let computerNumber = computerGuessingService.startGame(guessedNumber: guessedNumber)
		viewModel = ComputerGuessesNumberViewModel(roundNumber: roundNumber, guessedNumberByComputer: computerNumber)
		view?.setViewModel(viewModel: viewModel!)
		view?.setInitialState()
	}

	func setRoundNumber(roundNumber: Int) {
		self.roundNumber = roundNumber
	}
	
	//Используется бинарный поиск для угадывания числа, заданного пользователем
	func greaterButtonPressed() {
		do {
			let computerNumber = try computerGuessingService.greater()
			view?.unsetAlert()
			viewModel?.guessedNumberByComputer = computerNumber
			view?.setViewModel(viewModel: viewModel!)
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
			viewModel?.guessedNumberByComputer = computerNumber
			view?.setViewModel(viewModel: viewModel!)
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
