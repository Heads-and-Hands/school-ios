//
//  CustomSegue.swift
//  example
//
//  Created by basalaev on 04.12.2019.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue {

    override func perform() {
        guard let window = UIApplication.shared.delegate?.window else {
            return
        }

        window?.rootViewController = destination
    }
}
