//
//  OverlayViewPickPrice.swift
//  ParserMega
//
//  Created by Владислав Баранов on 02.05.2024.
//

import Foundation
import UIKit


class OverlayViewPickPrice: OverlayView {
    
    var textTo = ""
    var textFrom = ""
    var textFieldFrom = UnderlinedTextField()
    var textFieldTo = UnderlinedTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        view.addSubview(textFieldFrom)
        view.addSubview(textFieldTo)
        textFieldFrom.placeholder = "Цена от.."
        textFieldTo.placeholder = "Цена до.."
        textFieldFrom.translatesAutoresizingMaskIntoConstraints = false
        textFieldTo.translatesAutoresizingMaskIntoConstraints = false
        
        textFieldFrom.becomeFirstResponder()
        
        view.backgroundColor = UIColor(red: 74/255, green: 117/255, blue: 170/255, alpha: 1)
        
        NSLayoutConstraint.activate([
            textFieldFrom.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldFrom.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -32),
            textFieldFrom.widthAnchor.constraint(equalToConstant: view.bounds.width - 32),
            textFieldTo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldTo.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 32),
            textFieldTo.widthAnchor.constraint(equalToConstant: view.bounds.width - 32)
        ])
    }
    
    
    override func addToList() {
        super.addToList()
        priceFrom = textFieldFrom.text ?? ""
        priceTo = textFieldTo.text ?? ""
        print("Цена от: \(textFrom), Цена до: \(textTo)")
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
