//
//  UserGuessesNumberPresenter.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import Foundation

class UserGuessesNumberPresenter: UserGuessesNumberViewOutput {

	weak var view: UserGuessesNumberViewInput?
	var viewModel: UserGuessesNumberViewModel!
    var userGuessingService: UserGuessingServiceInterface!

	func viewDidLoadDone() {
        userGuessingService.startGame()
		viewModel = UserGuessesNumberViewModel(roundNumber: 0, numberTip: .none)
		view?.setViewModel(viewModel: viewModel!)
		view?.setInitialState()
	}

	func numberWasEntered(number: Int) {
        let result = userGuessingService.numberWasEntered(number: number)
        if result == .equal {
            let newViewController = ModulesFactory.createStartNewGameModule()
            self.view?.navigationController?.pushViewController(newViewController, animated: true)
        } else {
            viewModel = UserGuessesNumberViewModel(roundNumber: viewModel.roundNumber, numberTip: result)
            view?.setViewModel(viewModel: viewModel!)
        }
	}
}
