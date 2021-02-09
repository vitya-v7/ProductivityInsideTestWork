//
//  StartNewGamePresenter.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import Foundation
import UIKit

class StartNewGamePresenter: StartNewGameViewOutput {

	weak var view: StartNewGameViewInput?
	var viewModel: StartNewGameViewModel?
	var output: IGoToNextScreen?
	
	func viewDidLoadDone() {
		viewModel = StartNewGameViewModel(gamerStatus: .gamer)
		view?.setViewModel(viewModel: viewModel!)
		view?.setInitialState()
	}

    func onStartButtonTap() {
        output?.nextScreen()
    }
}

extension StartNewGamePresenter: INavigationSeed {
	var vc: UIViewController { return UIViewController() }

	func set<Parameters>(parameters: Parameters?) {
		output = parameters as? IGoToNextScreen
	}
}
