//
//  UserGuessesNumberPresenter.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import Foundation
import UIKit

class UserGuessesNumberPresenter: UserGuessesNumberViewOutput {
	
	weak var view: UserGuessesNumberViewInput?
	var viewModel: UserGuessesNumberViewModel!
	var userGuessingService: UserGuessingServiceInterface!
	var roundNumber: Int = 0
	var moduleOutput: IUserGuessedNumber?

	func viewDidLoadDone() {
		userGuessingService.startGame()
		viewModel = UserGuessesNumberViewModel(roundNumber: roundNumber, numberTip: .none)
		view?.setViewModel(viewModel: viewModel!)
		view?.setInitialState()
	}

	func setRoundNumber(roundNumber: Int) {
		self.roundNumber = roundNumber
	}

	func numberWasEntered(number: Int) {
		let result = userGuessingService.numberWasEntered(number: number)
		if result == .equal {
			moduleOutput?.userEndedHisTurn(attempts: userGuessingService.attempts)
			moduleOutput?.nextScreen()
		} else {
			viewModel = UserGuessesNumberViewModel(roundNumber: viewModel.roundNumber, numberTip: result)
			view?.setViewModel(viewModel: viewModel!)
		}
	}

	func setModuleOutput(moduleOutput: IUserGuessedNumber) {
		self.moduleOutput = moduleOutput
	}
}
