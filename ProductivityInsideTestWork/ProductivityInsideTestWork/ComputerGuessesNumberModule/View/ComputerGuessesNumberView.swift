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
}

class ComputerGuessesNumberView: UIViewController, ComputerGuessesNumberViewInput {

	@IBOutlet weak var roundNumber: UILabel!

	@IBOutlet weak var computerGuesses: UILabel!


	@IBOutlet weak var guessedNumberByComputer: UILabel!

	@IBOutlet weak var greaterButton: UIButton!

	@IBOutlet weak var equalButton: UIButton!

	@IBOutlet weak var lessButton: UIButton!

	var output: ComputerGuessesNumberViewOutput?

	func setInitialState() {

	}

	func setViewModel(viewModel: ComputerGuessesNumberViewModel) {

	}

    override func viewDidLoad() {
        super.viewDidLoad()
		output?.viewDidLoadDone()
        // Do any additional setup after loading the view.
    }
	
}
