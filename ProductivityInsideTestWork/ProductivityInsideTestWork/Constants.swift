//
//  Constants.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 04.02.2021.
//

import Foundation

enum Constants {
	static let maxNumber = 100
	static let minNumber = 0
	static let totalRoundNumber = 5
	static let numberOfRecyclingViews = 3
	static let startRound = 1
	static let unfairGame = "Press the right button!"
	static let gameName = "Guess The Number: The Game"
	static let congratulations = "Congratulations"
	static let startNewGameButtonText = "Start new game"
}

public enum NavigationModuleType: Int {
	case startNewGameModule = 0
	case setNumberToGuessModule = 1
	case computerGuessesNumberModule = 2
	case userGuessesNumberModule = 3
}

public enum GameState: String {
	case win = "You win"
	case lose = "You lose"
	case newGame = ""
}
