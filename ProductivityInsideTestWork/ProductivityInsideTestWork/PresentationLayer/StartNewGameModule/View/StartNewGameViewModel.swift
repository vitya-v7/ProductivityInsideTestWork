//
//  StartNewGameViewModel.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import Foundation

class StartNewGameViewModel {
	
	var title: String?
	var gameState: GameState
	
	init(gameState: GameState = .newGame) {
		self.gameState = gameState
		if self.gameState == .win {
			self.title = Constants.congratulations
		}
		else if self.gameState == .newGame {
			self.title = Constants.gameName
		}
		else {
			self.title = ""
		}
	}
}
