//
//  RegistrationViewController.swift
//  example
//
//  Created by basalaev on 27.11.2019.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let center = NotificationCenter.default
         center.addObserver(self, selector: #selector(keyboardDisplay(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
         center.addObserver(self, selector: #selector(keyboardDisplay(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardDisplay(notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }

        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }

        let keyboardHeight = keyboardFrame.cgRectValue.height

        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentInset.bottom = keyboardHeight
            self.scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight
        }
    }
}
