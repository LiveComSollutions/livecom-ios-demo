//
//  Extension+UIView.swift
//  LiveComExample
//

import UIKit

extension UIView {

    func hideKeyboardWhenTappedAround() {
        let tapGesture = HideKeyboardTapGestureRecognized(target: self, action: #selector(hideKeyboardAction(_:)))
        addGestureRecognizer(tapGesture)
    }

    @objc
    func hideKeyboardAction(_ gesture: UIGestureRecognizer) {
        if hitTest(gesture.location(in: self), with: nil)?.canBecomeFirstResponder != true {
            UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
            return
        }
    }
}

class HideKeyboardTapGestureRecognized: UITapGestureRecognizer {
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
        delegate = self
    }
}

extension HideKeyboardTapGestureRecognized: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
