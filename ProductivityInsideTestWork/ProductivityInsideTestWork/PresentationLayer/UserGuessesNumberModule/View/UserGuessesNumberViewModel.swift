//
//  UserGuessesNumberViewModel.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import Foundation

class UserGuessesNumberViewModel {
	var roundNumber: Int
	var numberTip: NumberTips

	init(roundNumber: Int, numberTip: NumberTips) {
		self.roundNumber = roundNumber
		self.numberTip = numberTip
	}
}
