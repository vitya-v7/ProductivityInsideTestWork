//
//  StartNewGamePresenter.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import Foundation

class StartNewGamePresenter: StartNewGameViewOutput {

	weak var view: StartNewGameViewInput?
	var viewModel: StartNewGameViewModel?
	func viewDidLoadDone() {
		viewModel = StartNewGameViewModel(gamerStatus: .gamer)
		view?.setViewModel(viewModel: viewModel!)
		view?.setInitialState()
	}

    func onStartButtonTap() {
        let newViewController = ModulesFactory.createSetNumberToGuessModule()
        self.view?.navigationController?.pushViewController(newViewController, animated: true)
    }
}
