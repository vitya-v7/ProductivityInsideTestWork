//
//  ComputerGuessesNumberView.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import UIKit

protocol ComputerGuessesNumberViewInput : UIViewController  {
	func setInitialState()
	func setViewModel(viewModel: ComputerGuessesNumberViewModel)
	func setAlert(string: String)
	func unsetAlert()
}

protocol ComputerGuessesNumberViewOutput {
	func viewDidLoadDone()
	func greaterButtonPressed()
	func lessButtonPressed()
	func equalButtonPressed()
	func setRoundNumber(roundNumber: Int)
}

class ComputerGuessesNumberView: UIViewController, ComputerGuessesNumberViewInput {

	@IBOutlet weak var roundNumber: UILabel!
	@IBOutlet weak var computerGuesses: UILabel!
	@IBOutlet weak var guessedNumberByComputer: UILabel!
	@IBOutlet weak var greaterButton: UIButton!
	@IBOutlet weak var equalButton: UIButton!
	@IBOutlet weak var lessButton: UIButton!

	@IBAction func guessedNumberIsGreater(_ sender: UIButton) {
		output?.greaterButtonPressed()
	}

	@IBAction func guessedNumberIsLess(_ sender: UIButton) {
		output?.lessButtonPressed()
	}

	@IBAction func guessedNumberIsEqual(_ sender: UIButton) {
		output?.equalButtonPressed()
	}
	
	var output: ComputerGuessesNumberViewOutput?
	var viewModel: ComputerGuessesNumberViewModel?

	func setInitialState() {}

	func setViewModel(viewModel: ComputerGuessesNumberViewModel) {
		self.viewModel = viewModel
		self.roundNumber.text = "Round №" + String(self.viewModel!.roundNumber!)
		self.computerGuesses.text = "Computer Guesses"
		self.guessedNumberByComputer.text = "Number is - " + String(self.viewModel!.guessedNumberByComputer!)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationController?.navigationItem.setHidesBackButton(true, animated: false)
		output?.viewDidLoadDone()
	}

	func setAlert(string: String) {
		let text = NSAttributedString.init(string: string, attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
		self.computerGuesses.attributedText = text
	}

	func unsetAlert() {
		let text = NSAttributedString.init(string: "Computer Guesses", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
		self.computerGuesses.attributedText = text
	}
}

