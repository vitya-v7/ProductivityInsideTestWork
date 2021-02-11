//
//  Computer.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 07.02.2021.
//

import Foundation

/*
* Computer guessing service which use binary search to guest user's number
*/
protocol ComputerGuessingServiceInterface {
	var attempts:Int! {get}

	func startGame(guessedNumber: Int) -> Int
	func greater() -> Int?
	func less() -> Int?
	func equal() -> Int?
}

class ComputerGuessingService: ComputerGuessingServiceInterface {
	let minNumber:Int
	let maxNumber:Int

	var minGuessingNumber:Int!
	var maxGuessingNumber:Int!
	var attempts:Int!
	var computerNumber:Int!
	var validNumber: Int!
	var userNumber: Int!

	init(minNumber:Int, maxNumber:Int) {
		self.minNumber = minNumber
		self.maxNumber = maxNumber
	}

	func startGame(guessedNumber: Int) -> Int {
		validNumber = guessedNumber
		minGuessingNumber = minNumber
		maxGuessingNumber = maxNumber
		attempts = 0
		computerNumber = getComputerNumber(min:minGuessingNumber, max:maxGuessingNumber, numberTip:.none)

		return computerNumber
	}

	func greater() -> Int? {
		if validNumber <= computerNumber {
			return nil
		}
		if minGuessingNumber < computerNumber {
			minGuessingNumber = computerNumber + 1
		}
		computerNumber = getComputerNumber(min:minGuessingNumber, max:maxGuessingNumber, numberTip:.greater)
		attempts = attempts + 1

		return computerNumber
	}

	func less() -> Int? {
		if validNumber >= computerNumber {
			return nil
		}
		if maxGuessingNumber > computerNumber {
			maxGuessingNumber = computerNumber - 1
		}
		computerNumber = getComputerNumber(min:minGuessingNumber, max:maxGuessingNumber, numberTip:.less)
		attempts = attempts + 1

		return computerNumber
	}

	func equal() -> Int? {
		if validNumber != computerNumber {
			return nil
		}
		attempts = attempts + 1
		return computerNumber
	}

	// MARK: Private

	private func getComputerNumber(min:Int, max:Int, numberTip:NumberTips) -> Int {
		var difference = maxGuessingNumber - minGuessingNumber
		let differenceIsUneven = difference % 2 == 1
		if differenceIsUneven {
			return difference / 2 + minGuessingNumber
		} else {
			if numberTip == NumberTips.greater {
				difference += 1
			} else if numberTip == NumberTips.less {
				difference -= 1
			}
		}
		return difference / 2 + minGuessingNumber
	}
}
