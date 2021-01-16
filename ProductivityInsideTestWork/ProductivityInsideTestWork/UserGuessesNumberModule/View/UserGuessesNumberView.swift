//
//  UserGuessesNumberView.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import UIKit

protocol UserGuessesNumberViewInput : UIViewController  {
	func setInitialState()
	func setViewModel(viewModel: ComputerGuessesNumberViewModel)
}

protocol UserGuessesNumberViewOutput {
	func viewDidLoadDone()
}

class UserGuessesNumberView: UIViewController, UserGuessesNumberViewInput {

	var output: UserGuessesNumberViewOutput?

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
