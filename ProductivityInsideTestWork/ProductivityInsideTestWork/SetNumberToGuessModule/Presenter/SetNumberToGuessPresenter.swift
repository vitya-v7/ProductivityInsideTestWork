//
//  SetNumberToGuessPresenter.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import Foundation

class SetNumberToGuessPresenter: SetNumberToGuessViewOutput {

	weak var view: SetNumberToGuessViewInput?
	var viewModel: SetNumberToGuessViewModel?
	func viewDidLoadDone() {
		viewModel = SetNumberToGuessViewModel(roundNumber: 0)
		view?.setViewModel(viewModel: viewModel!)
		view?.setInitialState()
	}

	func numberWasEntered(number: Int) {
		viewModel?.guessedNumber = number
		let newViewController = AbstractFactory.createComputerGuessesNumberModule(guessedNumber: number)
		self.view?.navigationController?.pushViewController(newViewController, animated: true)
	}
}
