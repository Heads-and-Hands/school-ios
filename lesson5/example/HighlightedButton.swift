//
//  HighlightedButton.swift
//  example
//
//  Created by basalaev on 24.11.2019.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import UIKit

// Простой вариант

/*
class HighlightedButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.7 : 1
        }
    }
}
*/

// Вариант по сложнее (нестабильное решение)

/*
class HighlightedButton: UIButton {
    var highlightedColor = #colorLiteral(red: 0.9294117647, green: 0.1058823529, blue: 0.2039215686, alpha: 1).withAlphaComponent(0.7)
    private var baseBackgroundColor: UIColor?

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                baseBackgroundColor = backgroundColor
                backgroundColor = highlightedColor
            } else {
                backgroundColor = baseBackgroundColor
                baseBackgroundColor = nil
            }
        }
    }
}
*/

/*
 */

// Сложный вариант

@IBDesignable
class HighlightedButton: UIButton {
    @IBInspectable var highlightedColor: UIColor?

    private var baseBackgroundColor: UIColor?

    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? highlightedColor : baseBackgroundColor
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        baseBackgroundColor = backgroundColor
    }
}
