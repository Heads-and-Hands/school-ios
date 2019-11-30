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

        let tableView = UITableView()
        tableView.register(SomeCellClass.self, forCellReuseIdentifier: "cellID")
        tableView.register(<#T##nib: UINib?##UINib?#>, forCellReuseIdentifier: <#T##String#>)

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

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") else {
            fatalError("Not found cell")
        }

        tableView.beginUpdates()
        tableView.endUpdates()


        tableView.reloadRows(at: <#T##[IndexPath]#>, with: <#T##UITableView.RowAnimation#>)

        cell.textLabel?.text = "Section: \(indexPath.section) Row: \(indexPath.row)"

        return cell
    }
}
