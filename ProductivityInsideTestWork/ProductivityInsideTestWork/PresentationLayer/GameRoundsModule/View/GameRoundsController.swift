//
//  GameRoundsController.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 08.02.2021.
//

import Foundation
import UIKit

final class GameRoundsController: UINavigationController {

	var fullViewHeight: CGFloat = 0

	func keyboardPreferences() {
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
	}

	@objc func keyboardWillShow(notification: NSNotification) {
		guard let userInfo = notification.userInfo,
			  let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
			  let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
		else {
			return
		}
		
		let keyboardFrame = keyboardSize.cgRectValue
		let keyboardHeight: CGFloat = abs(keyboardFrame.height)
		fullViewHeight = self.view.frame.height
		UIView.animate(withDuration: animationDuration) {
			self.view.frame = CGRect.init(x: self.view.frame.minX, y: self.view.frame.minY, width: self.view.frame.width, height: self.view.frame.height - keyboardHeight)
			self.view.layoutIfNeeded()
		}
	}

	@objc func keyboardWillHide(notification: NSNotification) {
		guard let userInfo = notification.userInfo,
			  let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
			  let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
		else {
			return
		}

		let keyboardFrame = keyboardSize.cgRectValue
		let keyboardHeight: CGFloat = abs(keyboardFrame.height)
		UIView.animate(withDuration: animationDuration) { [self] in
			self.view.frame = CGRect.init(x: self.view.frame.minX, y: self.view.frame.minY, width: self.view.frame.width, height: self.view.frame.size.height + keyboardHeight)
			self.view.layoutIfNeeded()
		}
	}

	func pushNextModule(view: UIViewController, animated: Bool) {
		navigationBar.isHidden = true
		pushViewController(view, animated: animated)
	}
	
	func setViewControllersAsFirst(firstController: UIViewController) {
		navigationBar.isHidden = true
		setViewControllers([firstController], animated: true)
	}
}
