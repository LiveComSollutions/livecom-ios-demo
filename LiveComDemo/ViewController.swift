//
//  ViewController.swift
//  LiveComDemo
//

import UIKit
import LiveComSDK

class ViewController: UIViewController {

    @IBOutlet weak var loaderContainerView: UIView!
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sdkVersionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = demoSDKKey
        sdkVersionLabel.text = "SDK version: \(LiveCom.sdkVersion)"
        view.hideKeyboardWhenTappedAround()

        LiveCom.shared.delegate = self
    }

    func startLoading() {
        loaderView.startAnimating()
        UIView.animate(withDuration: 0.25) {
            self.loaderContainerView.alpha = 1.0
        }
    }

    func stopLoading() {
        loaderView.stopAnimating()
        UIView.animate(withDuration: 0.25) {
            self.loaderContainerView.alpha = 0.0
        }
    }

    func showStreamIdAlert(completion: @escaping (String?) -> Void) {
        showAlert(
            title: "Enter Stream id",
            textFieldText: "",
            textFieldPlaceholder: "Stream id",
            message: nil,
            closeHandler: nil,
            submitHandler: completion
        )
    }
}

// MARK: - Actions
extension ViewController {

    @IBAction
    func applyKey(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "Restart application", preferredStyle: .alert)
        let close = UIAlertAction(title: "Ok", style: .cancel) { _ in
            UserDefaults.standard.set(self.textField.text, forKey: "sdkKey")
            exit(0)
        }
        alert.addAction(close)
        present(alert, animated: true)
    }

    @IBAction
    func showList(_ sender: Any) {
        startLoading()
        LiveCom.shared.presentStreams { [weak self] _ in
            self?.stopLoading()
        }
    }

    @IBAction
    func showVideo(_ sender: Any) {
        showStreamIdAlert { [weak self] streamId in
            guard let streamId else { return }
            self?.startLoading()
            LiveCom.shared.presentStream(id: streamId) { [weak self] _ in
                self?.stopLoading()
            }
        }
    }

    @IBAction
    func showCheckout(_ sender: Any) {
        startLoading()
        LiveCom.shared.presentCheckout { [weak self] _ in
            self?.stopLoading()
        }
    }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

// MARK: - LiveComDelegate
extension ViewController: LiveComDelegate {

    func userDidRequestOpenCheckoutScreen(
        products: [LiveCom.Product],
        presenting presentingViewController: UIViewController
    ) -> Bool {
        false
    }

    func userDidRequestOpenProductScreen(
        for product: LiveCom.Product,
        streamId: String,
        presenting presentingViewController: UIViewController
    ) -> Bool {
        false
    }

    func cartDidChange(products: [LiveCom.Product]) {
        let productSKUs = products.map(\.sku).joined(separator: "\r\n")
        print("[LiveCom] cartDidChange productSKUs: \(productSKUs)")
    }

    func productDidAddToCart(_ product: LiveCom.Product, inStreamId streamId: String) {
        print("[LiveCom] productDidAddToCart productSKU: \(product.sku) streamId: \(streamId)")
    }

    func productDidDeleteFromCart(_ productSKU: String) {
        print("[LiveCom] productDidAddToCart productSKU: \(productSKU)")
    }

    func liveComWillAppear() {
        print("[LiveCom] liveComWillAppear")
    }

    func liveComDidAppear() {
        print("[LiveCom] liveComDidAppear")
    }
}
