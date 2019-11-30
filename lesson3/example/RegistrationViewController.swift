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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!

    private var keyboardHeight: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self

        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardDisplay(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardDisplay(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        stackView.arrangedSubviews
            .compactMap { $0 as? UITextField }
            .forEach { $0.addTarget(self, action: #selector(beginEditing(sender:)), for: .editingDidBegin)}
    }

    // MARK: - Actions

    @objc func keyboardDisplay(notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }

        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }

        let keyboardHeight = keyboardFrame.cgRectValue.height
        self.keyboardHeight = keyboardHeight

        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentInset.bottom = keyboardHeight
            self.scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight
        }
    }

    @IBAction func beginEditing(sender: UITextField) {
        let visibleArea = scrollView.frame.height - keyboardHeight
        let centerY = visibleArea / 2.0
        let convertedFrame = view.convert(sender.frame, from: sender.superview)
        let diff = convertedFrame.midY - centerY

        let minContentOffset: CGFloat = -scrollView.adjustedContentInset.top
        let maxContentOffset: CGFloat = (scrollView.contentSize.height + scrollView.adjustedContentInset.bottom + keyboardHeight) - scrollView.frame.height - centerY

        let newContentOffsetY = min(max(scrollView.contentOffset.y + diff, minContentOffset), maxContentOffset)

        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: [.curveLinear, .beginFromCurrentState],
            animations: {
                self.scrollView.contentOffset.y = newContentOffsetY
            },
            completion: nil
        )
    }
}

extension RegistrationViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.contentOffset.y <= 0 else {
            return
        }

        let scale = 1 + (max(min(-scrollView.contentOffset.y / scrollView.frame.height, 1), 0)) * 2

        titleLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
            .translatedBy(x: 30 * scale, y: 0)
    }
}
