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
	var moduleOutput: (IComputerGuessedNumber & IGoTomoduleComplete)?

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
		let computerNumber = computerGuessingService.greater()
		if computerNumber == nil {
			view?.setAlert()
			return
		}
		else {
			view?.unsetAlert()
		}
		viewModel?.guessedNumberByComputer = computerNumber
		view?.setViewModel(viewModel: viewModel!)
	}

	func lessButtonPressed() {
		let computerNumber = computerGuessingService.less()
		if computerNumber == nil {
			view?.setAlert()
			return
		}
		else {
			view?.unsetAlert()
		}
		viewModel?.guessedNumberByComputer = computerNumber
		view?.setViewModel(viewModel: viewModel!)
	}

	func equalButtonPressed() {
		let computerNumber = computerGuessingService.equal()
		if computerNumber == nil {
			view?.setAlert()
			return
		}
		else {
			view?.unsetAlert()
		}
		moduleOutput?.computerEndedItsTurn(attempts: computerGuessingService.attempts)
		moduleOutput?.moduleComplete()
	}
}
