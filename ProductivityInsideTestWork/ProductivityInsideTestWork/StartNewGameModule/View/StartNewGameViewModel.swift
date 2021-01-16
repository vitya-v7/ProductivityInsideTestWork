//
//  StartNewGameViewModel.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import Foundation

class StartNewGameViewModel {

	enum GamerStatus: String {
		case winner = "You win"
		case loser = "You lose"
		case gamer = ""
	}

	let title: String
	let gamerStatus: GamerStatus
	let buttonLabel = "Start New Game"

	init(gamerStatus: GamerStatus = .gamer) {

		self.gamerStatus = gamerStatus
		if self.gamerStatus != .gamer {
			self.title = "Congratulations"
		}
		else {
			self.title = "Guess The Number: The Game"
		}
	}
	
}
