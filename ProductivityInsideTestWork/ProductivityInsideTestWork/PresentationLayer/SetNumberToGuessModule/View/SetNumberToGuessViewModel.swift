//
//  SetNumberToGuessViewModel.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import Foundation

class SetNumberToGuessViewModel {
	
	var roundNumber: Int
	var guessedNumber: Int?
	
	init(roundNumber: Int) {
		self.roundNumber = roundNumber
	}
}
