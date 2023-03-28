//
//  Extension+UIViewController.swift
//  LiveCom
//

import UIKit

extension UIViewController {

    func showAlert(
        title: String? = nil,
        textFieldText: String? = nil,
        textFieldPlaceholder: String? = nil,
        keyboardType: UIKeyboardType = .default,
        contentType: UITextContentType? = nil,
        message: String?,
        closeHandler: ((UIAlertAction) -> Void)? = nil,
        submitHandler: @escaping ((String?) -> Void)
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "Cancel", style: .cancel, handler: closeHandler)
        var textField: UITextField!
        alert.addTextField { CLTextField in
            CLTextField.placeholder = textFieldPlaceholder
            textField = CLTextField
            textField.text = textFieldText
            textField.keyboardType = keyboardType
            if let contentType {
                textField.textContentType = contentType
            }
        }
        let submit = UIAlertAction(title: "OK", style: .default) { (_) in
            submitHandler(textField.text)
        }
        alert.addAction(close)
        alert.addAction(submit)
        present(alert, animated: true, completion: nil)
    }
}
