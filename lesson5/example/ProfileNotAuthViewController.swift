//
//  ProfileNotAuthViewController.swift
//  example
//
//  Created by basalaev on 04.12.2019.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import UIKit

protocol ProfileNotAuthVCDelegate: AnyObject {
    func didSelectAuthButton()
}

class ProfileNotAuthViewController: UIViewController {
    weak var delegate: ProfileNotAuthVCDelegate?

    @IBAction func auth(sender: UIButton) {
        delegate?.didSelectAuthButton()
    }
}

