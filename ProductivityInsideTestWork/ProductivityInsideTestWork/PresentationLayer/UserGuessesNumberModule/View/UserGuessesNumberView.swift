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
	@IBOutlet weak var guessedNumberByGamer: UITextField! {
		didSet {
			guessedNumberByGamer?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForMyNumericTextField)))
		}}
	@IBOutlet weak var numberTips: UILabel!
	@IBOutlet weak var acceptNumber: UIButton!
	@IBOutlet weak var mainScrollViewBottomConstraint: NSLayoutConstraint!

	@IBAction func numberWasEntered(_ sender: UIButton? = nil) {
		if let number = Int(guessedNumberByGamer.text!) {
			output?.numberWasEntered(number: number)
		}
	}

	var output: UserGuessesNumberViewOutput?
	var viewModel: UserGuessesNumberViewModel?
	var keyboardHandler: KeyboardHandler?

	func setInitialState() {
		keyboardHandler = KeyboardHandler(mainScrollViewBottomConstraint: mainScrollViewBottomConstraint)
		self.youGuesses.text = "You Guesses"
		self.guessedNumberByGamer.placeholder = "Guess the number"
		self.acceptNumber.setTitle(Constants.enterNumber, for: .normal)
	}

	func setViewModel(viewModel: UserGuessesNumberViewModel) {
		self.viewModel = viewModel
		self.numberTips.text = "Number is " + viewModel.numberTip.rawValue
		self.roundNumber.text = "Round №" + String(viewModel.roundNumber)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		output?.viewDidLoadDone()
	}

	@objc func doneButtonTappedForMyNumericTextField() {
		numberWasEntered()
	}
}

