//
//  UserGuessesNumberView.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import UIKit

protocol UserGuessesNumberViewInput : UIViewController  {
	func setInitialState()
	func setViewModel(viewModel: UserGuessesNumberViewModel)
}

protocol UserGuessesNumberViewOutput {
	func viewDidLoadDone()
	func numberWasEntered(number: Int)
	func setRoundNumber(roundNumber: Int)
}

class UserGuessesNumberView: UIViewController, UserGuessesNumberViewInput {

	@IBOutlet weak var roundNumber: UILabel!
	@IBOutlet weak var youGuesses: UILabel!
	@IBOutlet weak var guessedNumberByGamer: UITextField!
	@IBOutlet weak var numberTips: UILabel!
	@IBOutlet weak var acceptNumber: UIButton!

	var output: UserGuessesNumberViewOutput?
	var viewModel: UserGuessesNumberViewModel?

	func setInitialState() {
		self.youGuesses.text = "You Guesses"
		self.guessedNumberByGamer.placeholder = "Guess the number"
		self.acceptNumber.setTitle("Enter the number", for: .normal)
	}

	func setViewModel(viewModel: UserGuessesNumberViewModel) {
		self.viewModel = viewModel
		self.numberTips.text = "Number is " + viewModel.numberTip.rawValue
		self.roundNumber.text = "Round №" + String(viewModel.roundNumber)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		acceptNumber.addTarget(self, action: #selector(numberWasEntered(_:)), for: .touchUpInside)
		output?.viewDidLoadDone()
	}

	@objc func numberWasEntered(_:UIButton) {
		if let number = Int(guessedNumberByGamer.text!) {
			output?.numberWasEntered(number: number)
		}
	}
}

