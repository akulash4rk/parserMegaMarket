//
//  OverlayViewPickerPromo.swift
//  ParserMega
//
//  Created by Владислав Баранов on 02.05.2024.
//

import Foundation
import UIKit

class OverlayViewPickerPromo : OverlayView, UIPickerViewDataSource {
    //picker
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let picker = UIPickerView()
        view.addSubview(picker)
        picker.dataSource = self
        picker.delegate = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 74/255, green: 154/255, blue: 207/255, alpha: 1)
        
        NSLayoutConstraint.activate([
            picker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            picker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
          //  picker.topAnchor.constraint(equalTo: OverlayView.closeButton.bottomAnchor, constant: 16),
            picker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          //  picker.bottomAnchor.constraint(equalTo: OverlayView.submitButton.topAnchor, constant: -16),
            picker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    //MARK: - Picker
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return leftValues.count
        } else {
            return rightValues.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            if row == 0 {
                return "Размер скидки"
            }
            return String(leftValues[row])
        } else {
            if row == 0 {
                return "Cкидка от"
            }
            return String(rightValues[row])
        }
    }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            currentLeft = leftValues[row]
        } else
        {
            currentRight = rightValues[row]
        }
    }
    
    
    //MARK: - Actions
    @objc override func addToList(){
        listOfPromos.append((currentRight, currentLeft))
        closeOverlay()
    }
}
