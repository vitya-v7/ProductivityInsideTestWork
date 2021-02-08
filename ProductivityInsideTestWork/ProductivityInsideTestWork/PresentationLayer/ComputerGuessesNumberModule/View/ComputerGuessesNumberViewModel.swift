//
//  ComputerGuessesNumberViewModel.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import Foundation

class ComputerGuessesNumberViewModel {
	var roundNumber: Int?
	var guessedNumberByComputer: Int?

	init(roundNumber: Int, guessedNumberByComputer: Int) {
		self.roundNumber = roundNumber
		self.guessedNumberByComputer = guessedNumberByComputer
	}

	init() {
		
	}
}
