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
	var moduleOutput: IGoTomoduleComplete?
	var moduleState: GameState?
	
	func viewDidLoadDone() {
		viewModel = StartNewGameViewModel(gameState: moduleState ?? .newGame)
		view?.setViewModel(viewModel: viewModel!)
		view?.setInitialState()
	}

	func onStartButtonTap() {
		moduleOutput?.moduleComplete()
	}

	func setGameState(state: GameState) {
		moduleState = state

	}
}

