//
//  KeyboardHandler.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 11.02.2021.
//

import Foundation
import UIKit

class KeyboardHandler {

	let mainScrollViewBottomConstraint: NSLayoutConstraint

	init(mainScrollViewBottomConstraint: NSLayoutConstraint) {
		self.mainScrollViewBottomConstraint = mainScrollViewBottomConstraint
		addKeyboardObservers()
	}

	deinit {
		removeKeyboardObservers()
	}

	//MARK: Private

	@objc private func keyboardWillShow(notification: NSNotification) {
		let userInfo = (notification as NSNotification).userInfo!
		let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
		mainScrollViewBottomConstraint.constant = keyboardSize.height
	}

	@objc private func keyboardWillHide(_ notification: Notification) {
		mainScrollViewBottomConstraint.constant = 0
	}

	private func addKeyboardObservers() {
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
	}

	private func removeKeyboardObservers() {
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
	}
}
