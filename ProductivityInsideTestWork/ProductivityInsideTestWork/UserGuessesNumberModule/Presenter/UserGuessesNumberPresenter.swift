//
//  UserGuessesNumberPresenter.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.01.2021.
//

import Foundation

class UserGuessesNumberPresenter: UserGuessesNumberViewOutput {

	weak var view: UserGuessesNumberViewInput?

	func viewDidLoadDone() {
		view?.setInitialState()
	}	
}
