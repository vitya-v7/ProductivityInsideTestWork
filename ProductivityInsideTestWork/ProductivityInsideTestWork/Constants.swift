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
	static let totalRoundNumber = 2
	static let numberOfRecyclingViews = 3
	static let startRound = 1
}

public enum NavigationModule: Int {
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
