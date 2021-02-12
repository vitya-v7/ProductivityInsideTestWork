//
//  SetNumberToGuessPresenter.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import Foundation
import UIKit

class SetNumberToGuessPresenter: SetNumberToGuessViewOutput {
	
	weak var view: SetNumberToGuessViewInput?
	var viewModel: SetNumberToGuessViewModel!
	var moduleOutput: ISetNumberToGuessModuleComplete?
	var roundNumber = 0
	
	func viewDidLoadDone() {
		viewModel = SetNumberToGuessViewModel(roundNumber: roundNumber)
		view?.setViewModel(viewModel: viewModel!)
		view?.setInitialState()
	}
	
	func setRoundNumber(roundNumber: Int) {
		self.roundNumber = roundNumber
	}
	
	func numberWasEntered(number: Int) {
		viewModel?.guessedNumber = number
		moduleOutput?.setNumberToGuessModuleComplete(guessedNumberByUser: number)
	}
}

