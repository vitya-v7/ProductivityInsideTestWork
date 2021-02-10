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
	var moduleOutput: IGoToNextScreen?
	
	func viewDidLoadDone() {
		viewModel = SetNumberToGuessViewModel(roundNumber: 0)
		view?.setViewModel(viewModel: viewModel!)
		view?.setInitialState()
	}

	func numberWasEntered(number: Int) {
		viewModel?.guessedNumber = number
		moduleOutput?.nextScreen()
	}

	func setModuleOutput(moduleOutput: IGoToNextScreen) {
		self.moduleOutput = moduleOutput
	}
}

