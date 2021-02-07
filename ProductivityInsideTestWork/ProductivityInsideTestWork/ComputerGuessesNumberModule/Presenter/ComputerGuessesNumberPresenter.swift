//
//  ComputerGuessesNumberPresenter.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import Foundation

class ComputerGuessesNumberPresenter: ComputerGuessesNumberViewOutput {

	weak var view: ComputerGuessesNumberViewInput?
	var viewModel: ComputerGuessesNumberViewModel?
	var roundNumber: Int = 0
	var guessedNumber: Int = 0
	var computerNumber = Int.random(in: Constants.minNumber ..< Constants.maxNumber + 1)
	var minNumber = Constants.minNumber
	var maxNumber = Constants.maxNumber
	//Используется бинарный поиск для угадывания числа, заданного пользователем
	func viewDidLoadDone() {
		viewModel = ComputerGuessesNumberViewModel(roundNumber: roundNumber, guessedNumberByComputer: computerNumber)
		view?.setViewModel(viewModel: viewModel!)
		view?.setInitialState()
	}

	//Используется бинарный поиск для угадывания числа, заданного пользователем
	func greaterButtonPressed() {
		if minNumber < computerNumber {
			minNumber = computerNumber + 1
		}
		computerNumber = (maxNumber - minNumber)/2 + minNumber
		
		viewModel?.guessedNumberByComputer = computerNumber
		view?.setViewModel(viewModel: viewModel!)
		attempts = attempts + 1
	}

	//Используется бинарный поиск для угадывания числа, заданного пользователем
	func lessButtonPressed() {
		if maxNumber > computerNumber {
			maxNumber = computerNumber - 1
		}
		computerNumber = (maxNumber - minNumber)/2 + minNumber
		viewModel?.guessedNumberByComputer = computerNumber
		view?.setViewModel(viewModel: viewModel!)
		attempts = attempts + 1
	}

	func equalButtonPressed() {
		attempts = attempts + 1
		let newViewController = AbstractFactory.createUserGuessesNumberModule()
		self.view?.navigationController?.pushViewController(newViewController, animated: true)
	}
}
