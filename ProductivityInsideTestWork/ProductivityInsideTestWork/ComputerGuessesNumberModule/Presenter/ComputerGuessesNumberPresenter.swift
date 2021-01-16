//
//  ComputerGuessesNumberPresenter.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import Foundation

class ComputerGuessesNumberPresenter: ComputerGuessesNumberViewOutput {

	weak var view: ComputerGuessesNumberViewInput?
	
	func viewDidLoadDone() {
		view?.setInitialState()
	}
}
