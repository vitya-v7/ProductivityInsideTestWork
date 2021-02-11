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
        let minNumber = 0
        let maxNumber = 40

        // when
        let computerNumber = computerGuessingService.startGame()

        // then
        XCTAssertEqual(computerGuessingService.computerNumber, computerNumber)
        XCTAssertEqual(computerGuessingService.minNumber, minNumber)
        XCTAssertEqual(computerGuessingService.maxNumber, maxNumber)
        XCTAssertEqual(computerGuessingService.attempts, 0)
        XCTAssertGreaterThanOrEqual(computerNumber, minNumber)
        XCTAssertLessThanOrEqual(computerNumber, maxNumber)
    }

    func testCheckAttemts() throws {
        // given
        _ = computerGuessingService.startGame()
        XCTAssertEqual(computerGuessingService.attempts, 0)
        _ = computerGuessingService.greater()
        XCTAssertEqual(computerGuessingService.attempts, 1)
        _ = computerGuessingService.less()
        XCTAssertEqual(computerGuessingService.attempts, 2)
    }

    func testCorrectGuessingOfEvenNumberWhichGreaterThan20() throws {
        // given
        // numberToGuess = 26
        let minNumber = 0
        let maxNumber = 40

        let computerNumberStep1 = computerGuessingService.startGame()
        XCTAssertEqual(computerNumberStep1, 20)
        XCTAssertEqual(computerGuessingService.minNumber, minNumber)
        XCTAssertEqual(computerGuessingService.maxNumber, maxNumber)

        let computerNumberStep2 = computerGuessingService.greater()
        XCTAssertEqual(computerNumberStep2, 31)
        XCTAssertEqual(computerGuessingService.minGuessingNumber, 21)
        XCTAssertEqual(computerGuessingService.maxGuessingNumber, maxNumber)

        let computerNumberStep3 = computerGuessingService.less()
        XCTAssertEqual(computerNumberStep3, 25)
        XCTAssertEqual(computerGuessingService.minGuessingNumber, 21)
        XCTAssertEqual(computerGuessingService.maxGuessingNumber, 30)

        let computerNumberStep4 = computerGuessingService.greater()
        XCTAssertEqual(computerNumberStep4, 28)
        XCTAssertEqual(computerGuessingService.minGuessingNumber, 26)
        XCTAssertEqual(computerGuessingService.maxGuessingNumber, 30)

        let computerNumberStep5 = computerGuessingService.less()
        XCTAssertEqual(computerNumberStep5, 26)
        XCTAssertEqual(computerGuessingService.minGuessingNumber, 26)
        XCTAssertEqual(computerGuessingService.maxGuessingNumber, 27)
    }

    func testCorrectGuessingOfOddNumberWhichGreaterThan20() throws {
         // numberToGuess = 27
        XCTAssertEqual(computerGuessingService.startGame(), 20)
        XCTAssertEqual(computerGuessingService.greater(), 31)
        XCTAssertEqual(computerGuessingService.less(), 25)
        XCTAssertEqual(computerGuessingService.greater(), 28)
        XCTAssertEqual(computerGuessingService.less(), 26)
        XCTAssertEqual(computerGuessingService.greater(), 27)
    }

    func testCorrectGuessingOfOddNumberWhichLessThan20() throws {
        // numberToGuess = 16
        XCTAssertEqual(computerGuessingService.startGame(), 20)
        XCTAssertEqual(computerGuessingService.less(), 9)
        XCTAssertEqual(computerGuessingService.greater(), 15)
        XCTAssertEqual(computerGuessingService.greater(), 18)
        XCTAssertEqual(computerGuessingService.less(), 16)
    }

    func testCorrectGuessingOfEvenNumberWhichLessThan20() throws {
        // given
        // numberToGuess = 17
        let computerNumberStep1 = computerGuessingService.startGame()
        XCTAssertEqual(computerNumberStep1, 20)
        XCTAssertEqual(computerGuessingService.less(), 9)
        XCTAssertEqual(computerGuessingService.greater(), 15)
        XCTAssertEqual(computerGuessingService.greater(), 18)
        XCTAssertEqual(computerGuessingService.less(), 16)
        XCTAssertEqual(computerGuessingService.greater(), 17)
    }
}
