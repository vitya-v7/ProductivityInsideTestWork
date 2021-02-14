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
	var viewModel: SetNumberToGuessViewModel!
	var moduleOutput: ISetNumberToGuessModuleOutput?
	var roundNumber = 0
	
	func viewDidLoadDone() {
		viewModel = SetNumberToGuessViewModel(roundNumber: roundNumber)
		view?.setViewModel(viewModel: viewModel!)
		view?.setInitialState()
	}

	func numberWasEntered(number: Int) {
		viewModel?.guessedNumber = number
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
