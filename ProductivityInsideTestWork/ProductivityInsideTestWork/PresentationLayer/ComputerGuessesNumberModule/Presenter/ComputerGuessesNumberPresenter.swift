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

	var roundNumber: Int = 1
	var guessedNumber: Int = 0

	var output: IComputerGuessedNumber?
	//Используется бинарный поиск для угадывания числа, заданного пользователем
	func viewDidLoadDone() {
        let computerNumber = computerGuessingService.startGame()
		viewModel = ComputerGuessesNumberViewModel(roundNumber: roundNumber, guessedNumberByComputer: computerNumber)
		view?.setViewModel(viewModel: viewModel!)
		view?.setInitialState()
	}

	//Используется бинарный поиск для угадывания числа, заданного пользователем
	func greaterButtonPressed() {
        let computerNumber = computerGuessingService.greater()
        viewModel?.guessedNumberByComputer = computerNumber
		view?.setViewModel(viewModel: viewModel!)
	}

	func lessButtonPressed() {
        let computerNumber = computerGuessingService.less()
		viewModel?.guessedNumberByComputer = computerNumber
		view?.setViewModel(viewModel: viewModel!)
	}

	func equalButtonPressed() {
        computerGuessingService.equal()
		output?.nextScreen()
	}
}

extension ComputerGuessesNumberPresenter: INavigationSeed {
	var vc: UIViewController { return UIViewController() }

	func set<Parameters>(parameters: Parameters?) {
		output = parameters as? IComputerGuessedNumber
	}
}
