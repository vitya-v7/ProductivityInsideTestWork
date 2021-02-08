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
    func onStartButtonTap()
}


class StartNewGameView: UIViewController, StartNewGameViewInput {
	@IBOutlet weak var gameName: UILabel!

	@IBOutlet weak var gameResults: UILabel!

	@IBOutlet weak var startNewGameButton: UIButton!

	var output: StartNewGameViewOutput?

	var viewModel: StartNewGameViewModel?

	func setInitialState() {
		
	}

	func setViewModel(viewModel: StartNewGameViewModel) {
		self.viewModel = viewModel
		gameName.text = viewModel.title
		gameResults.text = viewModel.gamerStatus.rawValue
		startNewGameButton.setTitle(viewModel.buttonLabel, for: .normal)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		startNewGameButton.addTarget(self, action: #selector(startNewGame(_:)), for: .touchUpInside)
		output?.viewDidLoadDone()
		// Do any additional setup after loading the view.
	}

	@objc func startNewGame(_: UIButton) {
        output?.onStartButtonTap()
	}	
}
