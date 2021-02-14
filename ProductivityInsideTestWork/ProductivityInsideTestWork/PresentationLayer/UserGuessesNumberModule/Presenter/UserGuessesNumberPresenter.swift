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
	var userGuessingService: UserGuessingServiceInterface!
	var moduleOutput: IUserGuessesNumberModuleOutput?
	var roundNumber: Int?

	func viewDidLoadDone() {
		userGuessingService.startGame()
		view?.setInitialState()
		let viewModel = UserGuessesNumberViewModel(roundNumber: roundNumber!, numberTip: .none)
		view?.setViewModel(viewModel: viewModel)
	}

	func numberWasEntered(number: Int) {
		let result = userGuessingService.numberWasEntered(number: number)
		// user guessed computer number
		if result == .equal {
			moduleOutput?.userGuessesNumberModuleComplete(attempts: userGuessingService.attempts)
		} else {
			let viewModel = UserGuessesNumberViewModel(roundNumber: roundNumber!, numberTip: result)
			view?.setViewModel(viewModel: viewModel)
		}
	}
}

extension UserGuessesNumberPresenter: IUserGuessesNumberModuleInput {

	func setModuleOutput(moduleOutput: IUserGuessesNumberModuleOutput) {
		self.moduleOutput = moduleOutput
	}
	
	func setRoundNumber(roundNumber: Int) {
		self.roundNumber = roundNumber
	}
}
