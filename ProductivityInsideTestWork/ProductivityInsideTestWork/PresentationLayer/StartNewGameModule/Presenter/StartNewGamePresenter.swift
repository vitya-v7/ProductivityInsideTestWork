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
	var moduleOutput: IStartNewGameModuleOutput?
	var gameState: GameState?
	
	func viewDidLoadDone() {
		view?.setInitialState()
		let viewModel = StartNewGameViewModel(gameState: gameState!)
		view?.setViewModel(viewModel: viewModel)
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
		self.gameState = state
	}
}
