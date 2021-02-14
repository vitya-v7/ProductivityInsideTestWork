//
//  StartNewGamePresenter.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import Foundation
import UIKit

protocol IStartNewGameModuleInput {
	func setModuleOutput(moduleOutput: IStartNewGameModuleOutput)
	func setGameState(state: GameState)
}

class StartNewGamePresenter: StartNewGameViewOutput {

	weak var view: StartNewGameViewInput?
	var viewModel: StartNewGameViewModel?
	var moduleOutput: IStartNewGameModuleOutput?
	
	func viewDidLoadDone() {
		viewModel = StartNewGameViewModel(gameState: viewModel?.gameState ?? .newGame)
		view?.setViewModel(viewModel: viewModel!)
		view?.setInitialState()
	}

	func onStartButtonTap() {
		moduleOutput?.startNewGameModuleComplete()
	}


}

extension StartNewGamePresenter: IStartNewGameModuleInput {

	func setModuleOutput(moduleOutput: IStartNewGameModuleOutput) {
		self.moduleOutput = moduleOutput
	}

	func setGameState(state: GameState) {
		if let viewModel = viewModel {
			viewModel.gameState = state
			view?.setViewModel(viewModel: viewModel)
		}
	}
}
