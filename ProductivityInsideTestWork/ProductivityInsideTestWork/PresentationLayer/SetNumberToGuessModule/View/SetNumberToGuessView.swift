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
}

class SetNumberToGuessView: UIViewController, SetNumberToGuessViewInput {

	@IBOutlet weak var roundNumber: UILabel!
	@IBOutlet weak var enterNumber: UITextField! {
		didSet {
			enterNumber?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForMyNumericTextField)))
		}}
	@IBOutlet weak var acceptNumber: UIButton!
	@IBOutlet weak var mainScrollViewBottomConstraint: NSLayoutConstraint!
	
	@IBAction func numberWasAccepted(_ sender: UIButton? = nil) {
		let number = Int(enterNumber.text!)
		if number == nil {
			return
		}
		output?.numberWasEntered(number: number!)
	}

	var output: SetNumberToGuessViewOutput?
	var viewModel:SetNumberToGuessViewModel?
	var keyboardHandler: KeyboardHandler?
	
	func setInitialState() {
		keyboardHandler = KeyboardHandler(mainScrollViewBottomConstraint: mainScrollViewBottomConstraint)
		updateInitialUI()
	}

	func updateInitialUI() {
		self.acceptNumber.setTitle("Enter the number", for: .normal)
		self.enterNumber.placeholder = "Введите число"
	}
	
	func setViewModel(viewModel: SetNumberToGuessViewModel) {
		self.viewModel = viewModel
		self.roundNumber.text = String("Round №\(self.viewModel!.roundNumber)")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		output?.viewDidLoadDone()
	}

	@objc func doneButtonTappedForMyNumericTextField() {
		enterNumber.resignFirstResponder()
		numberWasAccepted()
	}
}


