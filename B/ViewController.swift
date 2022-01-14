//
//  ViewController.swift
//  B
//
//  Created by Aurélien Waxin on 03/12/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

extension UIViewController {
        
         func presentAlert() {
            let alertVC = UIAlertController.init(title: "Une erreur est survenue", message: "erreur de chargement", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alertVC, animated: true, completion: nil)
        }
    }
