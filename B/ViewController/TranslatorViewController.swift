//
//  TranslatorViewController.swift
//  B
//
//  Created by Aurélien Waxin on 05/12/2021.
//

import UIKit

class TranslatorViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    
    @IBOutlet weak var textToTranslateTextfield: UITextField!
    @IBOutlet weak var texteWasTranslatedLabel: UILabel!
    
    private var reversalArrowButton: Bool = false
    
    private var target: String = "en"
    private var source: String = "fr"
    
    private var text1 = ""
    private var text2 = ""
    
    let translationServices = TranslateService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        texteWasTranslatedLabel.text = ""
        textToTranslateTextfield.placeholder = "Écrivez votre texte ici pour le traduire en Anglais"
    }
    
    // MARK: - BUTTONS ACTION
    
    @IBAction func reversalButtonTapped() {
        manageReversalButton()
    }
    
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textToTranslateTextfield.resignFirstResponder()
    }
    
}


// MARK: - MANAGE API CALL

extension TranslatorViewController {
    
    private func makeAPICall() {
        translationServices.getTranslation(text: textToTranslateTextfield.text ?? "", target: target, source: source) { (result) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let response):
                        self.updateTranslatorDisplay(response: response)
                    case .failure:
                        self.presentAlert()
                }
            }
        }
    }
    
    private func updateTranslatorDisplay(response: TranslationResponse) {
        if textToTranslateTextfield.text != "" {
            text1 = textToTranslateTextfield.text ?? ""
            text2 = response.data.translations[0].translatedText
            self.texteWasTranslatedLabel.text = response.data.translations[0].translatedText
        } else {
            texteWasTranslatedLabel.text = ""
        }
    }
    
}



// MARK: - MANAGE REVERSAL BUTTON (BONUS)

extension TranslatorViewController {
    
    private func manageReversalButton() {
        if reversalArrowButton {
            reversalArrowButton = false
            sourceLabel.text = "Français"
            targetLabel.text = "Anglais"
            target = "en"
            source = "fr"
            textToTranslateTextfield.placeholder = "Écrivez votre texte ici pour le traduire en Anglais"
        } else {
            reversalArrowButton = true
            sourceLabel.text = "Anglais"
            targetLabel.text = "Français"
            target = "fr"
            source = "en"
            textToTranslateTextfield.placeholder = "Write your text here to translate it into French"
        }
        if textToTranslateTextfield.text?.isEmpty == false {
            let text3 = text1
            text1 = text2
            text2 = text3
            textToTranslateTextfield.text = text1
            texteWasTranslatedLabel.text = text2
        }
    }
}


// MARK: - MANAGE TEXTFIELD

extension TranslatorViewController {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        makeAPICall()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.isEmpty { texteWasTranslatedLabel.text = "" }
    }
}


