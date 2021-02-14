//
//  StartNewGameViewModel.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import Foundation

class StartNewGameViewModel {
	
	let title: String
	var gameState: GameState
	let buttonLabel = "Start New Game"
	
	init(gameState: GameState = .newGame) {
		self.gameState = gameState
		if self.gameState == .win {
			self.title = "Congratulations"
		}
		else if self.gameState == .newGame {
			self.title = "Guess The Number: The Game"
		}
		else {
			self.title = ""
		}
	}
}
