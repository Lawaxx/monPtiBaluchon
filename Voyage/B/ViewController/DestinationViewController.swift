//
//  DestinationControllerView.swift
//  B
//
//  Created by Aurélien Waxin on 04/12/2021.
//

import Foundation
import UIKit

class DestinationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let destinationService = Destination()
        
        override func viewDidLoad() {
            super.viewDidLoad()

            picker.delegate = self
            picker.dataSource = self

            if let row = destinationService.options.firstIndex(of: destinationService.selection) {    // This code makes persistent the destination chosen in the picker
                picker.selectRow(row, inComponent: 0, animated: false)
            }
        }
        //MARK: IBACTIONS
    
        
        // Number of columns in the Picker
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1 }
        // Number of lines = number of rows in pickerData
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return destinationService.options.count }
        // Method called after Selection is made in the Picker, saetting destination's selection
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            destinationService.selection = destinationService.options[row]
//            destinationImageView.image = UIImage(named: String(destinationService.imageId))
        }
        // Method to define pickerData and design UIPicker rows as UILabels
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            let pickerLabel = UILabel()
            pickerLabel.textAlignment = .center
            let titleData = destinationService.options[row]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.font:UIFont(name: "Futura", size: 25.0)!,NSAttributedString.Key.foregroundColor:UIColor.black])
            pickerLabel.attributedText = myTitle
//            pickerLabel.backgroundColor = UIColor.Custom.myGreen
            
            pickerLabel.textAlignment = .center
            return pickerLabel
        }
    
    
       @IBOutlet weak var picker: UIPickerView!

     var pickerDataSource: [String] = [String]()

}

