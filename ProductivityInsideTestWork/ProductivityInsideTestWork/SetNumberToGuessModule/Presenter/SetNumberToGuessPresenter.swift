//
//  SetNumberToGuessPresenter.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import Foundation

class SetNumberToGuessPresenter: SetNumberToGuessViewOutput {

	weak var view: SetNumberToGuessViewInput?

	func viewDidLoadDone() {
		view?.setInitialState()
	}	
}
