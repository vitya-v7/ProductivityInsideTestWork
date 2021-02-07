//
//  UserGuessesNumberPresenter.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import Foundation

class UserGuessesNumberPresenter: UserGuessesNumberViewOutput {

	weak var view: UserGuessesNumberViewInput?
	var viewModel: UserGuessesNumberViewModel?
	var computersNumber: Int = Int.random(in: Constants.minNumber ..< Constants.maxNumber + 1)
	var attempts = 0

	func viewDidLoadDone() {
		viewModel = UserGuessesNumberViewModel(roundNumber: 0, numberTip: .none)
		view?.setViewModel(viewModel: viewModel!)
		view?.setInitialState()
	}

	func numberWasEntered(number: Int) -> UserGuessesNumberViewModel.NumberTips {
		attempts = attempts + 1
		if number > computersNumber {
			return .greater
		}
		else if number < computersNumber {
			return .less
		}
		return .equal
	}
}
