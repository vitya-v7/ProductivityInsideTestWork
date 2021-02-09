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

	var output: IUserGuessedNumber?

	func viewDidLoadDone() {
        userGuessingService.startGame()
		viewModel = UserGuessesNumberViewModel(roundNumber: 0, numberTip: .none)
		view?.setViewModel(viewModel: viewModel!)
		view?.setInitialState()
	}

	func numberWasEntered(number: Int) {
        let result = userGuessingService.numberWasEntered(number: number)
        if result == .equal {
			output?.nextScreen()
        } else {
            viewModel = UserGuessesNumberViewModel(roundNumber: viewModel.roundNumber, numberTip: result)
            view?.setViewModel(viewModel: viewModel!)
        }
	}
}

extension UserGuessesNumberPresenter: INavigationSeed {
	var vc: UIViewController { return UIViewController() }

	func set<Parameters>(parameters: Parameters?) {
		output = parameters as? IUserGuessedNumber
	}
}
