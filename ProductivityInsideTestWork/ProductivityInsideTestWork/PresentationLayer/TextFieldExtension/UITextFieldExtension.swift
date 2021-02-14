//
//  UITextFieldExtension.swift
//  ProductivityInsideTestWork
//
//  Created by Admin on 14.02.2021.
//

import Foundation
import UIKit

// add toolbar on keyboard with "Cancel" and "Done" buttons for user's convenience
extension UITextField {
	func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
		let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
		let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

		let toolbar: UIToolbar = UIToolbar()
		toolbar.barStyle = .default
		toolbar.items = [
			UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
			UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
			UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
		]
		toolbar.sizeToFit()

		self.inputAccessoryView = toolbar
	}

	// default behavior
	@objc func doneButtonTapped() { self.resignFirstResponder() }
	@objc func cancelButtonTapped() { self.resignFirstResponder() }
}
