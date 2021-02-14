//
//  SetNumberToGuessPresenter.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import Foundation
import UIKit

protocol ISetNumberToGuessModuleInput {
	func setModuleOutput(moduleOutput: ISetNumberToGuessModuleOutput)
	func setRoundNumber(roundNumber: Int)
}

class SetNumberToGuessPresenter: SetNumberToGuessViewOutput {
	
	weak var view: SetNumberToGuessViewInput?
	var moduleOutput: ISetNumberToGuessModuleOutput?
	var roundNumber: Int?

	func viewDidLoadDone() {
		view?.setInitialState()
		let viewModel = SetNumberToGuessViewModel(roundNumber: roundNumber!)
		view?.setViewModel(viewModel: viewModel)
	}

	func numberWasEntered(number: Int) {
		let viewModel = SetNumberToGuessViewModel(roundNumber: roundNumber!)
		viewModel.guessedNumber = number
		view?.setViewModel(viewModel: viewModel)
		moduleOutput?.setNumberToGuessModuleComplete(guessedNumberByUser: number)
	}
}

extension SetNumberToGuessPresenter: ISetNumberToGuessModuleInput {

	func setRoundNumber(roundNumber: Int) {
		self.roundNumber = roundNumber
	}

	func setModuleOutput(moduleOutput: ISetNumberToGuessModuleOutput) {
		self.moduleOutput = moduleOutput
	}
}
