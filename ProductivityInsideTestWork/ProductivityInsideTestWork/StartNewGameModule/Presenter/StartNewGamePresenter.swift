//
//  StartNewGamePresenter.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import Foundation

class StartNewGamePresenter: StartNewGameViewOutput {

	weak var view: StartNewGameViewInput?

	func viewDidLoadDone() {
		view?.setInitialState()
	}
}
