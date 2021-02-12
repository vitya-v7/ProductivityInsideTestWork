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
	func greater() throws -> Int
	func less() throws -> Int
	func equal() throws
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

	enum WrongButton: Error {
		case unfairGame(String)
	}

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

	func greater() throws -> Int {
		if validNumber <= computerNumber {
			throw WrongButton.unfairGame(Constants.unfairGame)
		}
		if minGuessingNumber < computerNumber {
			minGuessingNumber = computerNumber + 1
		}
		computerNumber = getComputerNumber(min:minGuessingNumber, max:maxGuessingNumber, numberTip:.greater)
		attempts = attempts + 1

		return computerNumber
	}

	func less() throws -> Int {
		if validNumber >= computerNumber {
			throw WrongButton.unfairGame(Constants.unfairGame)
		}
		if maxGuessingNumber > computerNumber {
			maxGuessingNumber = computerNumber - 1
		}
		computerNumber = getComputerNumber(min:minGuessingNumber, max:maxGuessingNumber, numberTip:.less)
		attempts = attempts + 1

		return computerNumber
	}

	func equal() throws {
		if validNumber != computerNumber {
			throw WrongButton.unfairGame(Constants.unfairGame)
		}
		attempts = attempts + 1
	}

	// MARK: Private

	private func getComputerNumber(min:Int, max:Int, numberTip:NumberTips) -> Int {
		var difference = maxGuessingNumber - minGuessingNumber
		let differenceIsEven = difference % 2 == 0
		if differenceIsEven {
			return difference / 2 + minGuessingNumber
		} else {
			if numberTip == NumberTips.greater {
				difference += 1
				return difference / 2 + minGuessingNumber
			} else if numberTip == NumberTips.less {
				difference -= 1
				return difference / 2 + minGuessingNumber
			}
		}

		return difference / 2 + minGuessingNumber
	}
}
