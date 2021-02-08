//
//  UserGuessingServiceTests.swift
//  ProductivityInsideTestWorkTests
//
//  Created by Andrey Belkin on 07.02.2021.
//

@testable import ProductivityInsideTestWork
import XCTest

class UserGuessingServiceTests: XCTestCase {
    var userGuessingService: UserGuessingService!

    override func setUpWithError() throws {
        userGuessingService = ModulesFactory.createUserGuessingService(minNumber:0, maxNumber:40)
    }

    override func tearDownWithError() throws {
        userGuessingService = nil
    }

    func testGuessingGreater() throws {
        userGuessingService.startGame()
        userGuessingService.computerNumber = 10
        XCTAssertEqual(userGuessingService.numberWasEntered(number:5), .greater)
    }

    func testGuessingLess() throws {
        userGuessingService.startGame()
        userGuessingService.computerNumber = 10
        XCTAssertEqual(userGuessingService.numberWasEntered(number:15), .less)
    }

    func testGuessingEqual() throws {
        userGuessingService.startGame()
        userGuessingService.computerNumber = 10
        XCTAssertEqual(userGuessingService.numberWasEntered(number:10), .equal)
    }

    func testAttemptsCounting() throws {
        userGuessingService.startGame()
        userGuessingService.computerNumber = 10

        XCTAssertEqual(userGuessingService.attempts, 0)
        _ = userGuessingService.numberWasEntered(number:11)
        XCTAssertEqual(userGuessingService.attempts, 1)
        _ = userGuessingService.numberWasEntered(number:9)
        XCTAssertEqual(userGuessingService.attempts, 2)
        _ = userGuessingService.numberWasEntered(number:10)
        XCTAssertEqual(userGuessingService.attempts, 3)
    }
}
