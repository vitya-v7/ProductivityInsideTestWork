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
}

class SetNumberToGuessView: UIViewController, SetNumberToGuessViewInput {

	@IBOutlet weak var roundNumber: UILabel!
	@IBOutlet weak var enterNumber: UITextField!
	@IBOutlet weak var acceptNumber: UIButton!

	var output: SetNumberToGuessViewOutput?

	func setInitialState() {

	}

	func setViewModel(viewModel: SetNumberToGuessViewModel) {
		
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		output?.viewDidLoadDone()
        // Do any additional setup after loading the view.
    }
    
}
