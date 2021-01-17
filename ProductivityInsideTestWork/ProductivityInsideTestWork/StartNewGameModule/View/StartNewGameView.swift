//
//  StartNewGameView.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//


import UIKit

protocol StartNewGameViewInput : UIViewController  {
	func setInitialState()
	func setViewModel(viewModel: StartNewGameViewModel)
}

protocol StartNewGameViewOutput {
	func viewDidLoadDone()
}


class StartNewGameView: UIViewController, StartNewGameViewInput{
	@IBOutlet weak var gameName: UILabel!

	@IBOutlet weak var gameResults: UILabel!

	@IBOutlet weak var startNewGameButton: UIButton!
	
	func setInitialState() {

	}

	func setViewModel(viewModel: StartNewGameViewModel) {

	}

	var output: StartNewGameViewOutput?

	override func viewDidLoad() {
		super.viewDidLoad()
		output?.viewDidLoadDone()
		// Do any additional setup after loading the view.
	}
}
