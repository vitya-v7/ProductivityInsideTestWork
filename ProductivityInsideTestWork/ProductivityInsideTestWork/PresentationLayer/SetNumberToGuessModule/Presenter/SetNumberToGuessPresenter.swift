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
	var output: IGoToNextScreen?
	
	func viewDidLoadDone() {
		viewModel = SetNumberToGuessViewModel(roundNumber: 0)
		view?.setViewModel(viewModel: viewModel!)
		view?.setInitialState()
	}

	func numberWasEntered(number: Int) {
		viewModel?.guessedNumber = number
		output?.nextScreen()
	}
}

extension SetNumberToGuessPresenter: INavigationSeed {
	var vc: UIViewController { return UIViewController() }

	func set<Parameters>(parameters: Parameters?) {
		output = parameters as? IGoToNextScreen
	}
}
