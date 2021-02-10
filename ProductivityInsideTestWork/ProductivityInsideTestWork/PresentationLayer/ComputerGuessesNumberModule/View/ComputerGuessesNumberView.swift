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
}

protocol ComputerGuessesNumberViewOutput {
	func viewDidLoadDone()
	func greaterButtonPressed()
	func lessButtonPressed()
	func equalButtonPressed()
	func setModuleOutput(moduleOutput: IComputerGuessedNumber)
	func setRoundNumber(roundNumber: Int)
}

class ComputerGuessesNumberView: UIViewController, ComputerGuessesNumberViewInput {

	@IBOutlet weak var roundNumber: UILabel!
	@IBOutlet weak var computerGuesses: UILabel!
	@IBOutlet weak var guessedNumberByComputer: UILabel!
	@IBOutlet weak var greaterButton: UIButton!
	@IBOutlet weak var equalButton: UIButton!
	@IBOutlet weak var lessButton: UIButton!

	var output: ComputerGuessesNumberViewOutput?
	var viewModel = ComputerGuessesNumberViewModel()

	func setInitialState() {}

	func setViewModel(viewModel: ComputerGuessesNumberViewModel) {
		self.viewModel = viewModel
		self.roundNumber.text = "Round №" + String(self.viewModel.roundNumber!)
		self.computerGuesses.text = "Computer Guesses"
		self.guessedNumberByComputer.text = "Number is - " + String(self.viewModel.guessedNumberByComputer!)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationController?.navigationItem.setHidesBackButton(true, animated: false)
		greaterButton.addTarget(self, action: #selector(guessedNumberIsGreater(_:)), for: .touchUpInside)
		lessButton.addTarget(self, action: #selector(guessedNumberIsLess(_:)), for: .touchUpInside)
		equalButton.addTarget(self, action: #selector(guessedNumberIsEqual(_:)), for: .touchUpInside)
		output?.viewDidLoadDone()
	}

	@objc func guessedNumberIsGreater(_: UIButton) {
		output?.greaterButtonPressed()
	}

	@objc func guessedNumberIsLess(_: UIButton) {
		output?.lessButtonPressed()
	}
	@objc func guessedNumberIsEqual(_: UIButton) {
		output?.equalButtonPressed()
	}
}

