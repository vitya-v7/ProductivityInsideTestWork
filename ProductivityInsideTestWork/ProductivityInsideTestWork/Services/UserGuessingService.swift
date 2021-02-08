//
//  UserGuessingService.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 07.02.2021.
//

import Foundation

/*
* User guessing service where user must guess the computer's number.
*/
protocol UserGuessingServiceInterface {
    var attempts:Int! {get}

    func startGame()
    func numberWasEntered(number: Int) -> NumberTips
}

class UserGuessingService: UserGuessingServiceInterface {
    var computerNumber:Int!
    var attempts:Int!

    let minNumber:Int
    let maxNumber:Int

    init(minNumber:Int, maxNumber:Int) {
        self.minNumber = minNumber
        self.maxNumber = maxNumber
    }

    func startGame() {
        self.computerNumber = Int.random(in: minNumber ..< maxNumber + 1)
        attempts = 0;
    }

    func numberWasEntered(number: Int) -> NumberTips {
        if number < minNumber || number > maxNumber {
            return .outOfInteval
        }

        attempts = attempts + 1
        if number > computerNumber {
            return .less
        } else if number < computerNumber {
            return .greater
        }
        return .equal
    }
}
