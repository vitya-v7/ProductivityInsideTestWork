//
//  UserGuessesNumberPresenter.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import Foundation
import UIKit

protocol IUserGuessesNumberModuleInput {
	func setModuleOutput(moduleOutput: IUserGuessesNumberModuleOutput)
	func setRoundNumber(roundNumber: Int)
}

class UserGuessesNumberPresenter: UserGuessesNumberViewOutput {
	
	weak var view: UserGuessesNumberViewInput?
	var viewModel: UserGuessesNumberViewModel!
	var userGuessingService: UserGuessingServiceInterface!
	var roundNumber: Int = 0
	var moduleOutput: IUserGuessesNumberModuleOutput?

	func viewDidLoadDone() {
		userGuessingService.startGame()
		viewModel = UserGuessesNumberViewModel(roundNumber: roundNumber, numberTip: .none)
		view?.setViewModel(viewModel: viewModel!)
		view?.setInitialState()
	}

	func numberWasEntered(number: Int) {
		let result = userGuessingService.numberWasEntered(number: number)
		if result == .equal {
			moduleOutput?.userGuessesNumberModuleComplete(attempts: userGuessingService.attempts)
		} else {
			viewModel = UserGuessesNumberViewModel(roundNumber: viewModel.roundNumber, numberTip: result)
			view?.setViewModel(viewModel: viewModel!)
		}
	}
}

extension UserGuessesNumberPresenter {

	func setModuleOutput(moduleOutput: IUserGuessesNumberModuleOutput) {
		self.moduleOutput = moduleOutput
	}
	
	func setRoundNumber(roundNumber: Int) {
		self.roundNumber = roundNumber
	}
}
