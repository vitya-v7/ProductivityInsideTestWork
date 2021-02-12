//
//  ComputerGuessingServiceTests.swift
//  ComputerGuessingServiceTests
//
//  Created by Admin on 07.02.2021.
//

@testable import ProductivityInsideTestWork
import XCTest

class ComputerGuessingServiceTests: XCTestCase {
	var computerGuessingService: ComputerGuessingService!

	override func setUpWithError() throws {
		computerGuessingService = ModulesFactory.createComputerGuessingService(minNumber: 0, maxNumber: 40)
	}

	override func tearDownWithError() throws {
		computerGuessingService = nil
	}

	func testStartGame() throws {
		// given
		let minNumber = computerGuessingService.minNumber
		let maxNumber = computerGuessingService.maxNumber

		// when
		let computerNumber = computerGuessingService.startGame(guessedNumber: 30)

		// then
		XCTAssertEqual(computerGuessingService.computerNumber, computerNumber)
		XCTAssertEqual(computerGuessingService.minNumber, minNumber)
		XCTAssertEqual(computerGuessingService.maxNumber, maxNumber)
		XCTAssertEqual(computerGuessingService.attempts, 0)
		XCTAssertGreaterThanOrEqual(computerNumber, minNumber)
		XCTAssertLessThanOrEqual(computerNumber, maxNumber)
	}

	func testCorrectGuessingOfEvenNumberWhichGreaterThan20() throws {
		// given
		// numberToGuess = 26
		let minNumber = computerGuessingService.minNumber
		let maxNumber = computerGuessingService.maxNumber

		let computerNumberStep1 = computerGuessingService.startGame(guessedNumber: 26)
		XCTAssertEqual(computerNumberStep1, 20)
		XCTAssertEqual(computerGuessingService.minNumber, minNumber)
		XCTAssertEqual(computerGuessingService.maxNumber, maxNumber)

		let computerNumberStep2 = try? computerGuessingService.greater()
		XCTAssertEqual(computerNumberStep2, 31)
		XCTAssertEqual(computerGuessingService.minGuessingNumber, 21)
		XCTAssertEqual(computerGuessingService.maxGuessingNumber, maxNumber)

		let computerNumberStep3 = try? computerGuessingService.less()
		XCTAssertEqual(computerNumberStep3, 25)
		XCTAssertEqual(computerGuessingService.minGuessingNumber, 21)
		XCTAssertEqual(computerGuessingService.maxGuessingNumber, 30)

		let computerNumberStep4 = try? computerGuessingService.greater()
		XCTAssertEqual(computerNumberStep4, 28)
		XCTAssertEqual(computerGuessingService.minGuessingNumber, 26)
		XCTAssertEqual(computerGuessingService.maxGuessingNumber, 30)

		let computerNumberStep5 = try? computerGuessingService.less()
		XCTAssertEqual(computerNumberStep5, 26)
		XCTAssertEqual(computerGuessingService.minGuessingNumber, 26)
		XCTAssertEqual(computerGuessingService.maxGuessingNumber, 27)
	}

	func testCorrectGuessingOfEvenNumberWhichLessThan20() throws {
		// given
		// numberToGuess = 17
		let computerNumberStep1 = computerGuessingService.startGame(guessedNumber: 17)
		XCTAssertEqual(computerNumberStep1, 20)
		XCTAssertEqual(try? computerGuessingService.less(), 9)
		XCTAssertEqual(try? computerGuessingService.greater(), 15)
		XCTAssertEqual(try? computerGuessingService.greater(), 18)
		XCTAssertEqual(try? computerGuessingService.less(), 16)
		XCTAssertEqual(try? computerGuessingService.greater(), 17)
	}
	
	func testCheckAttempts() throws {
		// given
		_ = computerGuessingService.startGame(guessedNumber: 3)
		XCTAssertEqual(computerGuessingService.attempts, 0)
		_ = try? computerGuessingService.less()
		XCTAssertEqual(computerGuessingService.attempts, 1)
		_ = try? computerGuessingService.less()
		XCTAssertEqual(computerGuessingService.attempts, 2)
	}

	func testAllGuessingCases() throws {
		// given
		let minNumber = computerGuessingService.minNumber
		let maxNumber = computerGuessingService.maxNumber
		let triesNumber = 20

		for guessNumber in minNumber..<maxNumber {
			var computerNumber = computerGuessingService.startGame(guessedNumber: guessNumber)
			for computerGuessingTryNumber in 0..<triesNumber {
				if computerGuessingTryNumber == triesNumber - 1 {
					XCTFail("computer wasn't able to guess number =" + String(guessNumber));
				} else {
					if computerNumber > guessNumber {
						computerNumber = try! computerGuessingService.less()
					} else if computerNumber < guessNumber {
						computerNumber = try! computerGuessingService.greater()
					} else {
						print(String(guessNumber) + "guessed")
						break;
					}
				}
			}
		}
	}
}
