//
//  ExchangeViewController.swift
//  B
//
//  Created by Aurelien Waxin on 11/12/2021.
//

import UIKit

class ExchangeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var eurosTextfield: UITextField!
    @IBOutlet weak var dollarLabel: UILabel!
    
    var selectedCurrency: Double = 0.00
    var expectedValue: Double = 0.00
    var inputValue: Double = 0.00
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeAPICall()
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        eurosTextfield.resignFirstResponder()
    }
    
}


// MARK: - CALL API FONCTIONS
extension ExchangeViewController {
    
    private func makeAPICall() {
        ExchangeService.shared.getExchange { (result) in
            switch result {
            case .success(let response):
                self.currencyChange(response: response)
            case .failure :
                self.presentAlert()
            }
        }
    }
    
    
    private func currencyChange(response: ExchangeResponse) {
        selectedCurrency = response.rates.EUR
        expectedValue = response.rates.USD
        inputValue = Double(eurosTextfield.text!) ?? 1.00
        
        var conversion = (inputValue * expectedValue / selectedCurrency)
        conversion = round(conversion * 100) / 100
        
        if eurosTextfield.text != "" {
            dollarLabel.text = String(conversion)
        } else {
            var USDRate = response.rates.USD
            USDRate = round(USDRate * 100) / 100
            dollarLabel.text = String(USDRate)
        }
    }
}


// MARK: - MANAGE TEXTFIELDS
extension ExchangeViewController {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        makeAPICall()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.isEmpty { dollarLabel.text = "\(round(expectedValue * 100) / 100)" }
    }
}



// MARK: - PRESENTE ALERTS
extension ExchangeViewController {
    
    private func presentAlert() {
        let alertVC = UIAlertController.init(title: "Une erreur est survenue", message: "erreur de chargement", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
