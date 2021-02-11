//
//  SetNumberToGuessView.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import UIKit

protocol SetNumberToGuessViewInput : UIViewController  {
	func setInitialState()
	func setViewModel(viewModel: SetNumberToGuessViewModel)
}

protocol SetNumberToGuessViewOutput {
	func viewDidLoadDone()
	func numberWasEntered(number: Int)
	func setRoundNumber(roundNumber: Int)
}

class SetNumberToGuessView: UIViewController, SetNumberToGuessViewInput {

	@IBOutlet weak var roundNumber: UILabel!
	@IBOutlet weak var enterNumber: UITextField!
	@IBOutlet weak var acceptNumber: UIButton!
	@IBOutlet weak var mainScrollViewBottomConstraint: NSLayoutConstraint!
	
	var output: SetNumberToGuessViewOutput?
	var viewModel:SetNumberToGuessViewModel?
	var keyboardHandler: KeyboardHandler?
	
	func setInitialState() {
		keyboardHandler = KeyboardHandler(mainScrollViewBottomConstraint: mainScrollViewBottomConstraint)
		updateInitialUI()
	}

	func setViewModel(viewModel: SetNumberToGuessViewModel) {
		self.viewModel = viewModel
	}

	func updateInitialUI() {
		self.roundNumber.text = String("Round №\(self.viewModel!.roundNumber)")
		self.acceptNumber.setTitle("Enter the number", for: .normal)
		self.enterNumber.placeholder = "Введите число"
	}


	override func viewDidLoad() {

		super.viewDidLoad()

		navigationController?.navigationItem.setHidesBackButton(true, animated: false)
		acceptNumber.addTarget(self, action: #selector(numberWasAccepted(_:)), for: .touchUpInside)
		output?.viewDidLoadDone()
	}

	@objc func numberWasAccepted(_: UIButton) {
		let number = Int(enterNumber.text!)
		if number == nil {
			return
		}
		output?.numberWasEntered(number: number!)
	}

}
