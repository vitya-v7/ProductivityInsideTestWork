//
//  StartNewGameViewModel.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import Foundation

class StartNewGameViewModel {
	
	let title: String
	let gameState: GameState
	let buttonLabel = "Start New Game"
	
	init(gameState: GameState = .newGame) {
		self.gameState = gameState
		if self.gameState != .newGame {
			self.title = "Congratulations"
		}
		else {
			self.title = "Guess The Number: The Game"
		}
	}
}
