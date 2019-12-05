//
//  ViewController.swift
//  example
//
//  Created by basalaev on 24.11.2019.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions

    @IBAction func login(sender: UIButton) {
        print("Login: \(String(describing: loginTextField.text))")
        print("Password: \(String(describing: passwordTextField.text))")
    }

    @IBAction func endEditing(sender: UITextField) {
        if sender === loginTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            sender.resignFirstResponder()
        }
    }

    @IBAction func tap(sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            view.endEditing(true)
        default:
            print("Unknown state")
        }
    }
}
